package test;

import java.util.List;

import dao.IconDAO;
import dto.Icon;

public class IconDAOTest {

    public static void showAllData(List<Icon> iconList) {
    	
        for (Icon icon : iconList) {
            System.out.println("ID: " + icon.getId());
            System.out.println("Days: " + icon.getDays());
            System.out.println("Path: " + icon.getPath());
            System.out.println();
        }
    }

    public static void main(String[] args) {
        IconDAO dao = new IconDAO();

        // select()のテスト
        System.out.println("---------- findAll()のテスト ----------");
        List<Icon> iconList = dao.select();
        showAllData(iconList);
        
    }
}

