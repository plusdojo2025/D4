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

	public List<Health> select(Health card) {
		Connection conn = null;
		List<Health> cardList = new ArrayList<Health>();
		
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
			if (card.getId() != null) {
				pStmt.setString(1, card.getId() );
			} else {
				pStmt.setString(1,"");
			}
			if (card.getDate() != null) {
				pStmt.setString(2, card.getDate());
			} else {
				pStmt.setString(2, "");
			}

				// SQL文を実行し、結果表を取得する
				ResultSet rs = pStmt.executeQuery();

				// 結果表をコレクションにコピーする
				while (rs.next()) {
					Health health = new Health(rs.getString("id"), rs.getString("date"), rs.getInt("vegetable"),
							rs.getInt("sleep"), rs.getInt("walk"), rs.getInt("stress"),rs.getInt("weight"));
					cardList.add(health);
				}
		} catch (SQLException e) {
			e.printStackTrace();
			cardList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			cardList = null;
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					cardList = null;
			}
		}
	}

		// 結果を返す
		return cardList;

     }
	}
