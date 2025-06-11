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
			/*JDBCドライバの読み込み*/
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			/*データベースに接続*/
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");
			
			/*SELECT文を準備*/
			String sql = "SELECT count(*) FROM users WHERE id=? AND pw=? AND height=? AND name=? AND theme=? "
					+ "AND icon=? AND vPrivate=? AND sPrivate=? AND wPrivate=?";
			
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, users.getId());
			pStmt.setString(2, users.getPw());
			pStmt.setInt(3, users.getHeight());
			pStmt.setString(4, users.getName());
			pStmt.setInt(5, users.getTheme());
			pStmt.setInt(6, users.getIcon());
			pStmt.setInt(7, users.getvPrivate());
			pStmt.setInt(8, users.getsPrivate());
			pStmt.setInt(9, users.getwPrivate());
			
			// SELECT文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();
			
			/*ユーザーIDとパスワードが一致するユーザーがいれば結果をtrueにする*/
			rs.next();
			if(rs.getInt("count(*)") ==1 ) {
				loginResult = true;
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
			loginResult = false;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			loginResult = false;
		}finally {
			/*データベース切断*/
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					loginResult = false;
				}
			}
		}
		/*結果を返す*/
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
			String sql = "SELECT * FROM users WHERE id = ? ";
			
			String cLogSql = "WITH login_data AS SELECT id AS user_id, date AS login_date, "
					+ "ROW_NUMBER() OVER (PARTITION BY id ORDER BY date) AS rn "
					+ "FROM healthList), "
					+ "streaks AS (SELECT user_id, login_date, "
					+ "DATE_SUB(login_date, INTERVAL rn DAY) AS streak_group "
					+ "FROM login_data) "
					+ "SELECT user_id, COUNT(*) AS consecutive_days, "
					+ "MIN(login_date) AS start_date, "
					+ "MAX(login_date) AS end_date "
					+ "FROM streaks GROUP BY user_id, streak_group ORDER BY user_id, start_date";
			
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, users.getId());
			
			// SELECT文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();
			

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				Users tmpUser = new Users(
						rs.getString("id"), 
						rs.getString("pw"), 
						rs.getInt("height"),
						rs.getString("name"),
						rs.getInt("theme"),
						rs.getInt("icon"),
						rs.getInt("vPrivate"),
						rs.getInt("sPrivate"),
						rs.getInt("wPrivate")
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
