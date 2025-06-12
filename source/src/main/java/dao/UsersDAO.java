package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Users;

public class UsersDAO {
	/*引数のユーザー情報でログイン、成功ならtrueを返す*/
	public boolean isLoginOK(Users users) {
	    Connection conn = null;
	    boolean loginResult = false;
	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");

	        String sql = "SELECT count(*) AS cnt FROM users WHERE id=? AND pw=?";
	        PreparedStatement pStmt = conn.prepareStatement(sql);
	        pStmt.setString(1, users.getId());
	        pStmt.setString(2, users.getPw());
	        ResultSet rs = pStmt.executeQuery();
	        if (rs.next() && rs.getInt("cnt") == 1) {
	            loginResult = true;
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    } finally {
	        if (conn != null) {
	            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
	        }
	    }
	    return loginResult;
	}


	
	//selectを実装 idのみを引数に検索
	public List<Users> select(Users users) {
		Connection conn = null;
		List<Users> usersList = new ArrayList<Users>();
		
		try {
			/*JDBCドライバの読み込み*/
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			/*データベースに接続*/
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");
			
			/*SELECT文を準備*/
			//ユーザー情報の取得
			String sql = "SELECT * FROM users WHERE id = ? ";
			
			//ユーザー変数を用いて連続ログイン日数を算出
			
			//ユーザー変数の初期化
			String resetSql = "SET @prev_date := NULL, @streak_group := 0, @pd := NULL, @sg := 0";
			//対象となるデータの切り出し
			String cutSql = "SELECT user_id, login_date, @streak_group := "
					+ "IF(DATEDIFF(login_date, @prev_date) = 1, @streak_group, @streak_group + 1) "
					+ "AS streak_group, @prev_date := login_date FROM "
					+ "(SELECT id AS user_id, date AS login_date FROM healthList WHERE id = ? ORDER BY login_date)"
					+ " AS ordered";

			//最長連続ログイン日数の算出
			String mLogSql = "SELECT user_id, COUNT(*) AS longest_streak_days "
					+ "FROM (SELECT user_id, login_date, "
					+ "@sg := IF(DATEDIFF(login_date, @pd) = 1, @sg, @sg + 1) "
					+ "AS streak_group, @pd := login_date FROM (SELECT id AS user_id, date "
					+ "AS login_date FROM healthList WHERE id = ? ORDER BY login_date) AS t1, "
					+ "(SELECT @pd := NULL, @sg := 0) AS vars) AS "
					+ "streaks GROUP BY user_id, streak_group ORDER BY COUNT(*) "
					+ "DESC, MAX(login_date) DESC LIMIT 1";
			
			//最新連続ログイン日数の算出
			String nLogSql = "SELECT user_id, COUNT(*) AS latest_streak_days "
					+ "FROM (SELECT user_id, login_date, "
					+ "@sg := IF(DATEDIFF(login_date, @pd) = 1, @sg, @sg + 1) "
					+ "AS streak_group, @pd := login_date FROM (SELECT id AS user_id, date "
					+ "AS login_date FROM healthList WHERE id = ? ORDER BY login_date) AS t1, "
					+ "(SELECT @pd := NULL, @sg := 0) AS vars) AS "
					+ "streaks GROUP BY user_id, streak_group ORDER BY MAX(login_date) "
					+ "DESC LIMIT 1";

			//SQL文を完成
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, users.getId());
			PreparedStatement resetStmt = conn.prepareStatement(resetSql);
			PreparedStatement cutStmt = conn.prepareStatement(cutSql);
			cutStmt.setString(1, users.getId());
			PreparedStatement mlStmt = conn.prepareStatement(mLogSql);
			mlStmt.setString(1, users.getId());
			PreparedStatement nlStmt = conn.prepareStatement(nLogSql);
			nlStmt.setString(1, users.getId());
			
			// SELECT文を実行し、結果表を取得する
			ResultSet prs = pStmt.executeQuery();
			resetStmt.executeQuery();
			cutStmt.executeQuery();
			ResultSet mrs = mlStmt.executeQuery();
			ResultSet nrs = nlStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (prs.next()) {
				
				//日々のデータがなかった場合の処理
				 int mLogin = 0;
				 int nLogin = 0;

				 if (mrs.next()) {
					 mLogin = mrs.getInt("longest_streak_days");
					 if (mrs.wasNull()) mLogin = 0;
				 }

				 if (nrs.next()) {
					 nLogin = nrs.getInt("latest_streak_days");
					 if (nrs.wasNull()) nLogin = 0;
				 }
			    
				Users tmpUser = new Users(
						prs.getString("id"), 
						prs.getString("pw"), 
						prs.getInt("height"),
						prs.getString("name"),
						prs.getInt("theme"),
						prs.getInt("icon"),
						prs.getInt("vPrivate"),
						prs.getInt("sPrivate"),
						prs.getInt("wPrivate"),
						mLogin,
						nLogin
						);
				
				usersList.add(tmpUser);
			}
		} catch(SQLException e) {
			e.printStackTrace();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		}finally {
			/*データベース切断*/
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		/*結果を返す*/
		return usersList;
	}
	
	//insertを実装
	
	//deleteを実装(テストデータの削除用)
	
}
