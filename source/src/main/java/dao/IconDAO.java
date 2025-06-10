package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Icon;

public class IconDAO {

	public List<Icon> findAll() {
		Connection conn = null;
		List<Icon> iconList = new ArrayList<Icon>();

		try {
			// JDBCドライバを読み込む
			Class.forName("com.mysql.cj.jdbc.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");

			// SQL文を準備する
			String sql = "SELECT * FROM iconList";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				Icon icon = new Icon(
					rs.getInt("id"),
					rs.getInt("days"),
					rs.getString("pass")
				);
				iconList.add(icon);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			iconList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			iconList = null;
		} finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					iconList = null;
				}
			}
		}

		// 結果を返す
		return iconList;
	}
}
