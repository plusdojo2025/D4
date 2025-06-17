package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Health;

public class HealthDAO {

	public List<Health> select(Health health) {
		Connection conn = null;
		List<Health> healthList = new ArrayList<Health>();
		
		try {
			//JDBCドライバ読み込み
			Class.forName("com.mysql.cj.jdbc.Driver");
		
			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");
			// SQL文を準備する
			String sql = "SELECT * FROM healthList "
					+ "WHERE id = ? AND date = ? ";
			PreparedStatement pStmt = conn.prepareStatement(sql);


			// SQL文を完成させる
			if (health.getId() != null) {
				pStmt.setString(1, health.getId() );
			} else {
				pStmt.setString(1,"");
			}
			if (health.getDate() != null) {
				pStmt.setString(2, health.getDate());
			} else {
				pStmt.setString(2, "");
			}

				// SQL文を実行し、結果表を取得する
				ResultSet rs = pStmt.executeQuery();

				// 結果表をコレクションにコピーする
				while (rs.next()) {
					Health newHealth = new Health(rs.getString("id"), rs.getString("date"), rs.getInt("vegetable"),
							rs.getInt("sleep"), rs.getInt("walk"), rs.getInt("stress"),rs.getInt("weight"));
					healthList.add(newHealth);
				}
		} catch (SQLException e) {
			e.printStackTrace();
			healthList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			healthList = null;
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					healthList = null;
			}
		}
	}

		// 結果を返す

		return healthList;
	}		

	
	// レコードの登録 insert

	public boolean insert(Health card) {
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
			String sql = "INSERT INTO healthList VALUES (?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			
			// SQL文を完成させる
			pStmt.setString(1, card.getId());
			pStmt.setString(2, card.getDate());
			pStmt.setInt(3, card.getVegetable());
			pStmt.setInt(4, card.getSleep());
			pStmt.setInt(5, card.getWalk());
			pStmt.setInt(6, card.getStress());
			pStmt.setDouble(7, card.getWeight());
		
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



	// 引数cardで指定されたレコードを更新し、成功したらtrueを返す
	public boolean update(Health card) {
		Connection conn = null;
		boolean result = false;
			
		try {
			// JDBCドライバを読み込む
			Class.forName("com.mysql.cj.jdbc.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");

			// SQL文を準備する
			String sql = "UPDATE healthList SET id=?, date=?,vegetable=?, sleep=?, walk=?, stress=?, weight=?" + "WHERE id=? AND date=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			
			// SQL文を完成させる
			pStmt.setString(1, card.getId());
			pStmt.setString(2, card.getDate());
			pStmt.setInt(3, card.getVegetable());
			pStmt.setInt(4, card.getSleep());
			pStmt.setInt(5, card.getWalk());
			pStmt.setInt(6, card.getStress());
			pStmt.setDouble(7, card.getWeight());
			pStmt.setString(8, card.getId());
			pStmt.setString(9, card.getDate());
			


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
	
	
	
	public boolean delete(String Id, String date) {
	    String sql = "DELETE FROM healthlist WHERE id = ? AND date = ?";
	    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
	    		+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
	    		"root", "password");
	    	PreparedStatement stmt = conn.prepareStatement(sql)) {
	    	stmt.setString(1, Id);
	    	stmt.setString(2, date);
	        int result = stmt.executeUpdate();
	        return result > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}	

}			

	

