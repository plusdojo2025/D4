package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.Theme;

public class ThemeDAO {
	public List<Theme> select(Theme List) {
		Connection conn = null;
		List<Theme> themeList = new ArrayList<Theme>();

		try {
			// JDBCドライバを読み込む
			Class.forName("com.mysql.cj.jdbc.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");

			// SQL文を準備する
			String sql = "SELECT id, name FROM themeList" ;
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				
				Theme theme = new Theme(id, name);
                themeList.add(theme);
            }
				
			// リソースをクローズ
            rs.close();
            pStmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

		// 結果を返す
		return themeList;
	}
}
