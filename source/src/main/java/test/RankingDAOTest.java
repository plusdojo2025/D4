package test;

import java.util.List;

import dao.FriendDAO;
import dao.RankingDAO;
import dto.Friend;
import dto.Health;
import dto.Ranking;

public class RankingDAOTest {
	
	public static void showAllData(List<Ranking> rankingList) {
	    for (Ranking ranking : rankingList) {
	        System.out.println("順位は" + ranking.getRank());
	        System.out.println("IDは" + ranking.getId());
	        System.out.println("名前は" + ranking.getName());
	        System.out.println("平均スコアは" + ranking.getScore());

	        // 1週間の健康データを表示
	    for (Health health : ranking.getHealthList()) {
	         System.out.println("日付は" + health.getDate());
	         System.out.println("野菜は" + health.getVegetable());
	         System.out.println("睡眠は" + health.getSleep());
	         System.out.println("歩数は" + health.getWalk());
	    }
	    System.out.println();
	    }
	}
	
	public static void main(String[] args) {
		// TODO 自動生成されたメソッド・スタブ
		RankingDAO dao = new RankingDAO();
		FriendDAO frDao = new FriendDAO(); 
		
		try {
			// select()のテスト
			System.out.println("---------- select()のテスト ----------");
			List<Friend> friendListSel1 = frDao.select(new Friend("user001", "user002", 0));
			List<Ranking> rankingListSel = dao.makeRanking(friendListSel1);
			showAllData(rankingListSel);
			
		}catch (Exception e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
	}

}

