package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Friend;
import dto.Health;
import dto.Ranking;

public class RankingDAO {

	public Ranking select(String startDate) {
		Connection conn = null;
		
		Ranking ranking = new Ranking();
		int sumScore = 0;
		int day = 0;

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
			
			List<Health> healthList = new ArrayList<Health>();
			
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
				
				sumScore += calSum(vegetable, sleep, walk);
				day += 1;

				Health health = new Health(id, date, vegetable, sleep, walk, stress, weight);
				
				healthList.add(health);

			}
			
			ranking = new Ranking(0, name, sumScore/day, id, healthList);
		

			rs.close();
			pStmt.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return ranking;
	}
	
	// 1週間のcalSumの平均のスコアの順位の計算をする
	public List<Ranking> addRankToRankingList(List<Ranking> rankingList) {
	    // バブルソート
	    int i = 0;
	    int j = 0;
	    while (i < rankingList.size() - 1) {
	        while (j < rankingList.size() - 1 - i) {
	            Ranking r1 = rankingList.get(j);
	            Ranking r2 = rankingList.get(j + 1);
	            if (r1.getScore() < r2.getScore()) {
	                // 入れ替え
	                rankingList.set(j, r2);
	                rankingList.set(j + 1, r1);
	            }
	            j++;
	        }
	        i++;
	    }
	    

	    // 順位を付ける
	    int index = 0;
	    int rank = 1;
	    int sameCount = 1;
	    double prevScore = -1;

	    while (index < rankingList.size()) {
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
	        index++;
	    }

	    return rankingList;
	}

	
	
	// 1日分のスコアの合計を求める
	public int calSum (int vegetable, int sleep, int walk) {
		
		int sleepScore = 0;
		int walkScore = 0;
		
		if (300 > sleep) {
			sleepScore = 1;
		}
		else if (350 > sleep) {
			sleepScore = 2;
		}
		else if (400 > sleep) {
			sleepScore = 3;
		}
		else if (450 > sleep) {
			sleepScore = 4;
		}
		else if (450 < sleep) {
			sleepScore = 5;
		}
		
		if (2000 > walk) {
			walkScore = 1;
		}
		else if (3500 > walk) {
			walkScore = 2;
		}
		else if (5000 > walk) {
			walkScore = 3;
		}
		else if (6500 > walk) {
			walkScore = 4;
		}
		else if (6500 < walk) {
			walkScore = 5;
		}
		
		return vegetable + sleepScore + walkScore;
	}
	
	//全員分のランキングのスコアをリストを作る
	public List<Ranking> makeRanking(List<Friend> friendList){
		List<Ranking> rankingList = new ArrayList<Ranking>();
		
		for(Friend friend : friendList) {
			
			if(friend.getState() == 3) {
				Ranking ranking = select(friend.getFriendId());
				rankingList.add(ranking);
			}	
		}
		Ranking ranking = select((friendList.get(0)).getMyId());
		rankingList.add(ranking);
		
		List<Ranking> rankingResult = addRankToRankingList(rankingList); 
			
		return rankingResult;
	}
	
}
