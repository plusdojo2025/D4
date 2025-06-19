package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import dto.Friend;
import dto.Health;
import dto.Ranking;

public class RankingDAO {

    // 指定ユーザーの1週間分の健康データを取得し、スコア平均を計算してRankingオブジェクトを返す
	public Ranking select(String userid, String startDate) {
	    Connection conn = null;
	    Ranking ranking = new Ranking();
	    int sumScore = 0;
	    int dayCount = 0;

	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection(
	            "jdbc:mysql://localhost:3306/d4?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9",
	            "root", "password"
	        );

	        String sql =
	            "SELECT users.id, users.name, healthList.date, " +
	            "healthList.vegetable, healthList.sleep, healthList.walk, " +
	            "healthList.stress, healthList.weight " +
	            "FROM healthList " +
	            "JOIN users ON healthList.id = users.id " +
	            "WHERE users.id = ? " +
	            "AND healthList.date BETWEEN ? AND DATE_ADD(?, INTERVAL 6 DAY)";

	        String sql2 =
	            "SELECT id, name FROM users WHERE id = ?";

	        PreparedStatement pStmt = conn.prepareStatement(sql);
	        pStmt.setString(1, userid);
	        pStmt.setString(2, startDate);
	        pStmt.setString(3, startDate);

	        PreparedStatement pStmt2 = conn.prepareStatement(sql2);
	        pStmt2.setString(1, userid);

	        ResultSet rs = pStmt.executeQuery();

	        // 結果をマップに格納
	        java.util.Map<String, Health> healthMap = new java.util.HashMap<>();
	        String name = "";
	        String id = "";

	        while (rs.next()) {
	            id = rs.getString("id");
	            name = rs.getString("name");
	            String date = rs.getString("date");
	            int vegetable = rs.getInt("vegetable");
	            int sleep = rs.getInt("sleep");
	            int walk = rs.getInt("walk");
	            int stress = rs.getInt("stress");
	            double weight = rs.getDouble("weight");

	            Health h = new Health(id, date, vegetable, sleep, walk, stress, weight);
	            healthMap.put(date, h);
	        }

	        // 7日分（日曜～土曜）で穴埋め
	        List<Health> healthList = new ArrayList<>();
	        LocalDate baseDate = LocalDate.parse(startDate);
	        for (int i = 0; i < 7; i++) {
	            LocalDate targetDate = baseDate.plusDays(i);
	            String dateStr = targetDate.format(DateTimeFormatter.ISO_LOCAL_DATE);

	            if (healthMap.containsKey(dateStr)) {
	                Health h = healthMap.get(dateStr);
	                sumScore += calSum(h.getVegetable(), h.getSleep(), h.getWalk());
	                dayCount++;
	                healthList.add(h);
	                id = h.getId();
	                name = name.isEmpty() ? h.getId() : name;
	            } else {
	                // データなし → 空データで0埋め
	                healthList.add(new Health(userid, dateStr, 0, 0, 0, 0, 0));
	            }
	        }

	        // 名前とID取得（データがなかった場合に備える）
	        if (name.isEmpty()) {
	            ResultSet rs2 = pStmt2.executeQuery();
	            if (!rs2.next()) return null;
	            id = rs2.getString("id");
	            name = rs2.getString("name");
	        }

	        double avgScore = (dayCount > 0) ? (double) sumScore / dayCount : 0.0;
	        ranking = new Ranking(0, name, avgScore, id, healthList);

	        rs.close();
	        pStmt.close();
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return ranking;
	}

    // ランキングリストに順位を追加する（スコアが高い順）
    public List<Ranking> addRankToRankingList(List<Ranking> rankingList) {
        // バブルソートでスコアの降順に並べ替え
        for (int i = 0; i < rankingList.size() - 1; i++) {
            for (int j = 0; j < rankingList.size() - 1 - i; j++) {
                if (rankingList.get(j).getScore() < rankingList.get(j + 1).getScore()) {
                    Collections.swap(rankingList, j, j + 1);
                }
            }
        }

        // 同スコアは同順位として順位を付与
        int rank = 1;
        int sameCount = 1;
        double prevScore = -1;

        for (int index = 0; index < rankingList.size(); index++) {
            Ranking current = rankingList.get(index);
            double score = current.getScore();

            if (index == 0) {
                current.setRank(rank);
            } else if (score == prevScore) {
                current.setRank(rank);
                sameCount++;
            } else {
                rank += sameCount;
                current.setRank(rank);
                sameCount = 1;
            }

            prevScore = score;
        }

        return rankingList;
    }

    // 1日分の健康スコアを計算する（野菜 + 睡眠スコア + 歩数スコア）
    public int calSum(int vegetable, int sleep, int walk) {
        int sleepScore = (sleep < 300) ? 1 :
                         (sleep < 350) ? 2 :
                         (sleep < 400) ? 3 :
                         (sleep < 450) ? 4 : 5;

        int walkScore = (walk < 2000) ? 1 :
                        (walk < 3500) ? 2 :
                        (walk < 5000) ? 3 :
                        (walk < 6500) ? 4 : 5;

        return vegetable + sleepScore + walkScore;
    }

    // フレンド＋自分のランキングを1週間分生成し、順位を付けて返す
    public List<Ranking> makeRanking(List<Friend> friendList) {
        List<Ranking> rankingList = new ArrayList<>();

        // 今週の日曜日の日付を取得
        String startDate = LocalDate.now()
                .with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY))
                .format(DateTimeFormatter.ISO_LOCAL_DATE);
        
        // テスト用に特定日から開始
        /* String startDate = LocalDate.of(2025, 6, 30)
                .with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY))
                .format(DateTimeFormatter.ISO_LOCAL_DATE); */

        // フレンドリストから状態3のユーザーを対象にランキングデータを取得
        for (Friend friend : friendList) {
            if (friend.getState() == 3) {
            	Ranking r = select(friend.getFriendId(), startDate);
            	if (r != null) {
            	    rankingList.add(r);
            	}
            }
        }

        // 自分自身のランキングも追加
        Ranking me = select(friendList.get(0).getMyId(), startDate);
        if (me != null) {
            rankingList.add(me);
        }

        // 順位を付けて返す
        return addRankToRankingList(rankingList);
    }
}
