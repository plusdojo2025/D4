package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Users;

public class UsersDAO {

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


	//insert
	public boolean insert (Users users) {
		Connection conn = null;
		boolean result = false;
		
		try {
			//JDBCドライバ読み込み
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");
			
			// SQL文を準備する
			String sql = "INSERT INTO users (id, pw, height, name) VALUES (?, ?, ?, ? )";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			
			// SQL文を完成させる
			pStmt.setString(1, users.getId());
			pStmt.setString(2, users.getPw());			
			pStmt.setInt(3, users.getHeight());
			pStmt.setString(4, users.getName());
		
			
			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
						
					// 結果を返す
		return result;
	}
			
			
	//selectを実装 idのみを引数に検索
	public Users select(String id) {
		Connection conn = null;
		Users user = null;
		
		try {
			/*JDBCドライバの読み込み*/
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			/*データベースに接続*/
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");
			
			/*SELECT文を準備*/
			//ユーザー情報の取得
			String sql = "SELECT u.id, u.pw, u.height, u.name, u.vPrivate, "
					+ "u.sPrivate, u.wPrivate, t.name AS theme, i.path AS icon "
					+ "FROM users u LEFT JOIN themeList t ON u.theme = t.id "
					+ "LEFT JOIN iconList i ON u.icon = i.id WHERE u.id = ? ";
			
			//ユーザー変数を用いて連続ログイン日数を算出
			
			//ユーザー変数の初期化
			String resetSql = "SET @prev_date := NULL, @streak_group := 0, @pd := NULL, @sg := 0";
			//対象となるデータの切り出し
			String cutSql = "SELECT user_id, login_date, @streak_group := "
					+ "IF(DATEDIFF(login_date, @prev_date) = 1, @streak_group, @streak_group + 1) "
					+ "AS streak_group, @prev_date := login_date FROM "
					+ "(SELECT id AS user_id, date AS login_date FROM healthList WHERE id = ? ORDER BY login_date)"
					+ " AS ordered";
			
			//最新連続ログイン日数の算出
			String nLogSql = "SELECT user_id, COUNT(*) AS latest_streak_days "
					+ "FROM (SELECT user_id, login_date, "
					+ "@sg := IF(DATEDIFF(login_date, @pd) = 1, @sg, @sg + 1) "
					+ "AS streak_group, @pd := login_date FROM (SELECT id AS user_id, date "
					+ "AS login_date FROM healthList WHERE id = ? ORDER BY login_date) AS t1, "
					+ "(SELECT @pd := NULL, @sg := 0) AS vars) AS "
					+ "streaks GROUP BY user_id, streak_group ORDER BY MAX(login_date) "
					+ "DESC LIMIT 1";
			
			//合計ログイン日数の算出
			String mLogSql = "SELECT COUNT(*) AS count FROM healthList WHERE id = ? ";
			

			//SQL文を完成
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, id);
			PreparedStatement resetStmt = conn.prepareStatement(resetSql);
			PreparedStatement cutStmt = conn.prepareStatement(cutSql);
			cutStmt.setString(1, id);
			PreparedStatement mlStmt = conn.prepareStatement(mLogSql);
			mlStmt.setString(1, id);
			PreparedStatement nlStmt = conn.prepareStatement(nLogSql);
			nlStmt.setString(1, id);
			
			// SELECT文を実行し、結果表を取得する
			ResultSet prs = pStmt.executeQuery();
			resetStmt.executeQuery();
			cutStmt.executeQuery();
			ResultSet mrs = mlStmt.executeQuery();
			ResultSet nrs = nlStmt.executeQuery();

			// 結果表をコレクションにコピーする
			if(prs.next()) {
				
				//日々のデータがなかった場合の処理
				 int mLogin = 0;
				 int nLogin = 0;

				 if (mrs.next()) {
					 mLogin = mrs.getInt("count");
					 if (mrs.wasNull()) mLogin = 0;
				 }

				 if (nrs.next()) {
					 nLogin = nrs.getInt("latest_streak_days");
					 if (nrs.wasNull()) nLogin = 0;
				 }
			    
				 user = new Users(
						 prs.getString("id"), 
						 prs.getString("pw"), 
						 prs.getInt("height"),
						 prs.getString("name"),
						 prs.getString("theme"),
						 prs.getString("icon"),
						 prs.getInt("vPrivate"),
						 prs.getInt("sPrivate"),
						 prs.getInt("wPrivate"),
						 mLogin,
						 nLogin
						 );
				
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
		return user;
	}
	
	//updateを実装
	public boolean update(Users user) {
		Connection conn = null;
		boolean result = false;
		int iconId = -1;
		int themeId = -1;
		
		try {
			// JDBCドライバを読み込む
			Class.forName("com.mysql.cj.jdbc.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");
			
			
			//ユーザー情報の更新
			String sql ="UPDATE users SET pw = ?, height = ?, name = ?, theme = ?, icon = ?, "
					+ "vPrivate = ?, sPrivate = ?, wPrivate = ? WHERE id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
	
			//メインのSQLに格納するデータを取得
			String getIconIdSql ="select id from iconList where path = ?";
			String getThemeIdSql ="select id from themeList where name = ?";
			PreparedStatement iStmt = conn.prepareStatement(getIconIdSql);
			PreparedStatement tStmt = conn.prepareStatement(getThemeIdSql);
			//SQL文を完成
			if (user.getTheme() != null) {
				tStmt.setString(1, user.getTheme());
			} else {
				tStmt.setString(1, "");
			}
			if (user.getIcon() != null) {
				iStmt.setString(1, user.getIcon());
			} else {
				iStmt.setString(1, "");
			}
			//System.out.println("path:"+user.getIcon());
			
			//SQL文を実行
			ResultSet trs = tStmt.executeQuery();
			ResultSet irs = iStmt.executeQuery();
			
			//結果から値を取得
			if (trs.next()) {
				 themeId = trs.getInt("id");
				 if (trs.wasNull()) themeId = 0;
			 }
			 if (irs.next()) {
				 iconId = irs.getInt("id");
				 if (irs.wasNull()) iconId = 0;
			 }
			 //System.out.println("theme:"+themeId);
			 //System.out.println("icon:"+iconId);
			 
			// SQL文を完成
			 if (user.getPw() != null) {
					stmt.setString(1, user.getPw());
				} else {
					stmt.setString(1, "");
				}
			stmt.setInt(2, user.getHeight());
		
			if (user.getName() != null) {
				stmt.setString(3, user.getName());
			} else {
				stmt.setString(3, "");
			}
			stmt.setInt(4, themeId);
			stmt.setInt(5, iconId);
			stmt.setInt(6, user.getvPrivate());
			stmt.setInt(7, user.getsPrivate());
			stmt.setInt(8, user.getwPrivate());
			if (user.getId() != null) {
				stmt.setString(9, user.getId());
			} else {
				stmt.setString(9, "");
			}
			
			// SQL文を実行し、結果表を取得する
			if (stmt.executeUpdate() == 1) {
				result = true;
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}
	
	//deleteを実装(テストデータの削除用)
	
	}
	