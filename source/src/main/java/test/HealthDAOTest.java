package test;

import java.util.List;

import dao.HealthDAO;
import dto.Health;

public class HealthDAOTest {
	public static void showAllData(List<Health> cardList) {
		for (Health card : cardList) {
			System.out.println("プレイヤーID：" + card.getId());
			System.out.println("日付：" + card.getDate());
			System.out.println("野菜：" + card.getVegetable());
			System.out.println("睡眠：" + card.getSleep());
			System.out.println("運動：" + card.getWalk());
			System.out.println("ストレス：" + card.getStress());
			System.out.println("体重：" + card.getWeight());		
			System.out.println();
		}
	}

	public static void main(String[] args) {
		// TODO 自動生成されたメソッド・スタブ
		HealthDAO dao = new HealthDAO();
		

		// select()のテスト1
		System.out.println("---------- select()のテスト1 ----------");
		List<Health> healthListSel1 = dao.select(new Health("user001", "2025-06-09", 0, 0, 8000, 0, 0.0));
		HealthDAOTest.showAllData(healthListSel1);


		// insert()のテスト
		System.out.println("---------- insert()のテスト ----------");
		Health insRec = new Health("user001", "2025-06-01", 3, 7, 8000, 2, 60.5);
		if (dao.insert(insRec)) {
			System.out.println("登録成功！");
			List<Health> healthListIns = dao.select(new Health("user001","2025-06-01", 0, 0, 8000, 0 , 0.0));
			HealthDAOTest.showAllData(healthListIns);
		} else {
			System.out.println("登録失敗！");
		}
		
		// update()のテスト
		System.out.println("---------- update()のテスト ----------");
		List<Health> healthListUp = dao.select(new Health("user001", "2025-06-01", 0,0,0,0,0.0));
		Health upRec = new Health("user001","2025-06-01",0 ,0,0,0,0.0);
		if (dao.update(upRec)) {
			System.out.println("更新しました！");
			healthListUp = dao.select(new Health("user001","2025-06-01",0 ,0,0,0,0.0));
			HealthDAOTest.showAllData(healthListUp);
		} else {
			System.out.println("更新失敗！");
		}
	}

}
