package test;

import dao.UsersDAO;
import dto.Users;

public class UsersDAOTest {

	public static void main(String[] args) {
		// TODO 自動生成されたメソッド・スタブ
		testIsLoginOK1(); /*ユーザーがみつかる時*/
		testIsLoginOK2(); /*ユーザーがみつからないとき時*/
		insertTest();
	}
	
	/*ユーザーが見つかるときのテスト*/
	public static void testIsLoginOK1() {
		UsersDAO dao = new UsersDAO();
		if(dao.isLoginOK(new Users("user001", "pass123",170,"Alice",1,1,0,0,0))){
			System.out.println("testIsLoginOK1：テストが成功しました");
		} else {
			System.out.println("testIsLoginOK1：テストが失敗しました");
		}
	}
	
	// ユーザーが見つからない場合のテスト
	public static void testIsLoginOK2() {
		UsersDAO dao = new UsersDAO();
		if(!dao.isLoginOK(new Users("id", "pass",165,"test",1,1,1,1,1))) {
			System.out.println("testIsLoginOK2：テストが成功しました");
		} else {
			System.out.println("testIsLoginOK2：テストが失敗しました");
		}
	}
	
	//Insert テスト
		public static void insertTest() {
		UsersDAO dao = new UsersDAO();
		if(dao.insert(new Users("users0", "password",160,"test",1,1,1,1,1))) {
			System.out.println("insertTestが成功しました");
		} else {
			System.out.println("insertTest：テストが失敗しました");
		}
	}	      
}


