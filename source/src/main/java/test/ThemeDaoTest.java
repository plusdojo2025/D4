package test;

import java.util.List;

import dao.ThemeDAO;
import dto.Theme;

public class ThemeDaoTest {
	public static void main(String[] args) {
        ThemeDAO dao = new ThemeDAO();

        System.out.println("=== テーマ一覧の取得テスト ===");

        // DAOのselectメソッドを呼び出す
        List<Theme> themeList = dao.select();

        // 結果の出力
        if (themeList != null && !themeList.isEmpty()) {
            for (Theme theme : themeList) {
                System.out.println("ID: " + theme.getId() + ", Name: " + theme.getName());
            }
        } else {
            System.out.println("テーマが見つかりませんでした。");
        }
    }
}
