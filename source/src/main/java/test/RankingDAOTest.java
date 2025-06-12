package test;

import java.util.List;

import dao.FriendDAO;
import dao.RankingDAO;
import dto.Friend;
import dto.Health;
import dto.Ranking;

public class RankingDAOTest {

    // 全ランキングデータを表示する（順位、ID、名前、スコア、1週間の健康情報）
    public static void showAllData(List<Ranking> rankingList) {
        for (Ranking ranking : rankingList) {
            System.out.println("【順位】" + ranking.getRank());
            System.out.println("【ID】" + ranking.getId());
            System.out.println("【名前】" + ranking.getName());
            System.out.println("【平均スコア】" + ranking.getScore());

            System.out.println("【1週間の健康データ】");
            for (Health health : ranking.getHealthList()) {
                System.out.println("日付:" + health.getDate());
                System.out.println("野菜:" + health.getVegetable());
                System.out.println("睡眠:" + health.getSleep());
                System.out.println("歩数:" + health.getWalk());
                System.out.println();
            }
            System.out.println("--------------------------------------------------");
        }
    }

    public static void main(String[] args) {
        // DAOの初期化
        RankingDAO rankingDao = new RankingDAO();
        FriendDAO friendDao = new FriendDAO();

        try {
            System.out.println("---------- select()のテスト ----------");

            // フレンド関係取得 user001がuser002を登録しているケースを想定
            List<Friend> friendList = friendDao.select(new Friend("user001", "user002", 3));

            // ランキング生成処理を呼び出す（select → makeRanking → addRankToRankingList）
            List<Ranking> rankingList = rankingDao.makeRanking(friendList);

            // 結果の表示
            showAllData(rankingList);

        } catch (Exception e) {
            // 例外が発生した場合はスタックトレースを表示
            e.printStackTrace();
        }
    }
}
