package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Friend;

public class FriendDAO {
	
	//自分のidで検索して、自分のフレンドデータを作成する
	public List<Friend> select(Friend friend) throws Exception {
		
		Connection conn = null;
		List<Friend> friendList = new ArrayList<Friend>();

		try {
			// JDBCドライバを読み込む
			Class.forName("com.mysql.cj.jdbc.Driver");
			String sql;
			
			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");
			
			// SQL文を準備する
			sql = "select * from friendList WHERE myId = ?";
			
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成
			if (friend.getMyId() != null) {
				pStmt.setString(1, friend.getMyId());
			} else {
				pStmt.setString(1, "%");
			}
			
			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				Friend fr = new Friend(
						rs.getString("myId"), 
						rs.getString("friendId"), 
						rs.getInt("state")
				);
		
				friendList.add(fr);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			friendList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			friendList = null;
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					friendList = null;
				}
			}
		}

		// 結果を返す
		return friendList;
	}

	//相手のidを使って申請を送信する
	public boolean insert(Friend friend) throws Exception {
	    Connection conn = null;
	    boolean result = false;

	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection(
	            "jdbc:mysql://localhost:3306/d4?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
	            "root", "password"
	        );

	        conn.setAutoCommit(false);  // トランザクション開始

	        // 自分から相手への申請（状態1）
	        String mSql = "INSERT INTO friendList VALUES (?, ?, 1)";
	        PreparedStatement mStmt = conn.prepareStatement(mSql);
	        mStmt.setString(1, friend.getMyId());
	        mStmt.setString(2, friend.getFriendId());

	        // 相手から自分への状態（状態2）
	        String fSql = "INSERT INTO friendList VALUES (?, ?, 2)";
	        PreparedStatement fStmt = conn.prepareStatement(fSql);
	        fStmt.setString(1, friend.getFriendId());
	        fStmt.setString(2, friend.getMyId());

	        // 両方実行
	        int rows1 = mStmt.executeUpdate();
	        int rows2 = fStmt.executeUpdate();

	        if (rows1 == 1 && rows2 == 1) {
	            conn.commit();  // 成功時コミット
	            result = true;
	        } else {
	            conn.rollback();  // 失敗時ロールバック
	        }

	    } catch (Exception e) {
	        if (conn != null) {
	            try {
	                conn.rollback();  // エラー時ロールバック
	            } catch (SQLException se) {
	                se.printStackTrace();
	            }
	        }
	        e.printStackTrace();
	    } finally {
	        if (conn != null) {
	            try {
	                conn.setAutoCommit(true);  // 忘れず元に戻す
	                conn.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    return result;
	}

	//申請状態を更新(承認)する
	public boolean update(Friend friend) throws Exception {
	    Connection conn = null;
	    boolean result = false;

	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection(
	            "jdbc:mysql://localhost:3306/d4?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
	            "root", "password"
	        );
	        
	        conn.setAutoCommit(false);  // トランザクション開始
		        
	        // 自分から相手への承認（状態1）
	        String mSql = "UPDATE friendList SET state = 3 WHERE myId = ? AND friendId = ?;";
	        PreparedStatement mStmt = conn.prepareStatement(mSql);
	        mStmt.setString(1, friend.getMyId());
	        mStmt.setString(2, friend.getFriendId());
	        
	        // 相手から自分への承認（状態2）
	        String fSql = "UPDATE friendList SET state = 3 WHERE myId = ? AND friendId = ?;";
	        PreparedStatement fStmt = conn.prepareStatement(fSql);
	        fStmt.setString(1, friend.getFriendId());
	        fStmt.setString(2, friend.getMyId());
	        
	        // 両方実行
	        int rows1 = mStmt.executeUpdate();
	        int rows2 = fStmt.executeUpdate();
	
	        if (rows1 == 1 && rows2 == 1) {
	            conn.commit();  // 成功時コミット
	            result = true;
	        } else {
	            conn.rollback();  // 失敗時ロールバック
	        }

	    } catch (Exception e) {
	        if (conn != null) {
	            try {
	                conn.rollback();  // エラー時ロールバック
	            } catch (SQLException se) {
	                se.printStackTrace();
	            }
	        }
	        e.printStackTrace();
	    } finally {
	        if (conn != null) {
	            try {
	                conn.setAutoCommit(true);  // 忘れず元に戻す
	                conn.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    return result;
	}
	
	//申請を削除(拒否)する
	public boolean delete(Friend friend) throws Exception {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("com.mysql.cj.jdbc.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");

			conn.setAutoCommit(false);  // トランザクション開始
	        
	        // 自分から相手への拒否（状態1）
	        String mSql = "DELETE FROM friendList WHERE myId = ? AND friendId = ?;";
	        PreparedStatement mStmt = conn.prepareStatement(mSql);
	        mStmt.setString(1, friend.getMyId());
	        mStmt.setString(2, friend.getFriendId());
	        
	        // 相手から自分への承認（状態2）
	        String fSql = "DELETE FROM friendList WHERE myId = ? AND friendId = ?;";
	        PreparedStatement fStmt = conn.prepareStatement(fSql);
	        fStmt.setString(1, friend.getFriendId());
	        fStmt.setString(2, friend.getMyId());
	        
	        // 両方実行
	        int rows1 = mStmt.executeUpdate();
	        int rows2 = fStmt.executeUpdate();
	
	        if (rows1 == 1 && rows2 == 1) {
	            conn.commit();  // 成功時コミット
	            result = true;
	        } else {
	            conn.rollback();  // 失敗時ロールバック
	        }

	    } catch (Exception e) {
	        if (conn != null) {
	            try {
	                conn.rollback();  // エラー時ロールバック
	            } catch (SQLException se) {
	                se.printStackTrace();
	            }
	        }
	        e.printStackTrace();
	    } finally {
	        if (conn != null) {
	            try {
	                conn.setAutoCommit(true);  // 忘れず元に戻す
	                conn.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    return result;
	}
}