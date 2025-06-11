package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Health;
import dto.Ranking;

public class RankingDAO {

	public List<Ranking> select(String startDate) {
		Connection conn = null;
		List<Ranking> rankingList = new ArrayList<Ranking>();
		Map<String, Ranking> rankingMap = new HashMap<String, Ranking>();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
				+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9",
				"root", "password");

			String sql = "SELECT users.id, users.name, healthList.date, "
			           + "healthList.vegetable, healthList.sleep, healthList.walk, "
			           + "healthList.stress, healthList.weight "
			           + "FROM healthList "
			           + "JOIN users ON healthList.id = users.id "
			           + "WHERE users.id = ? "
			           + "AND healthList.date BETWEEN ? AND DATE_ADD(?, INTERVAL 6 DAY)";

			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, startDate);
			pStmt.setString(2, startDate);

			ResultSet rs = pStmt.executeQuery();

			while (rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				String date = rs.getString("date");
				int vegetable = rs.getInt("vegetable");
				int sleep = rs.getInt("sleep");
				int walk = rs.getInt("walk");
				int stress = rs.getInt("stress");
				double weight = rs.getDouble("weight");

				Health health = new Health(id, date, vegetable, sleep, walk, stress, weight);

				if (!rankingMap.containsKey(id)) {
					List<Health> healthList = new ArrayList<Health>();
					Ranking ranking = new Ranking(0, name, 0.0, 0, healthList);
					rankingMap.put(id, ranking);
				}

				rankingMap.get(id).getHealthList().add(health);
			}

			rs.close();
			pStmt.close();

			rankingList.addAll(rankingMap.values());

		} catch (SQLException e) {
			e.printStackTrace();
			rankingList = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			rankingList = null;
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					rankingList = null;
				}
			}
		}

		return rankingList;
	}
}
