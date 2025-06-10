package test;

import java.util.List;

import dao.FriendDAO;
import dto.Friend;


public class FriendDAOTest {
	public static void showAllData(List<Friend> friendList) {
		for (Friend friend : friendList) {				
			System.out.println("myId：" + friend.getMyId());
			System.out.println("friendId：" + friend.getFriendId());
			System.out.println("state：" + friend.getState());
			System.out.println();
		}
	}
	
	public static void main(String[] args) {
		FriendDAO dao = new FriendDAO();
		try {
			// select()のテスト1
			System.out.println("---------- select()のテスト1 ----------");
			List<Friend> friendListSel1 = dao.select(new Friend("user001", "user002", 0));
			FriendDAOTest.showAllData(friendListSel1);
		
			// select()のテスト2
			System.out.println("---------- select()のテスト2 ----------");
			List<Friend> friendListSel2 = dao.select(new Friend("user001", "", 0));
			FriendDAOTest.showAllData(friendListSel2);
		
			// insert()のテスト
			System.out.println("---------- insert()のテスト ----------");
			Friend insRec = new Friend("user001","user003",1);
			if (dao.insert(insRec)) {
				System.out.println("登録成功！");
				List<Friend> friendListIns = dao.select(new Friend());
				FriendDAOTest.showAllData(friendListIns);
			} else {
				System.out.println("登録失敗！");
			}
		
			// update()のテスト
			System.out.println("---------- update()のテスト ----------");
			List<Friend> friendListUp = dao.select(new Friend("user003", "user001", 2));
			Friend upRec = friendListUp.get(0);
			if (dao.update(upRec)) {
				System.out.println("更新成功！");
				friendListUp = dao.select(new Friend("user001", "", 0));
				FriendDAOTest.showAllData(friendListUp);
			} else {
				System.out.println("更新失敗！");
			}
		
				
			// delete()のテスト
			System.out.println("---------- delete()のテスト ----------");
			List<Friend> friendListDel = dao.select(new Friend("user001", "", 0));
			Friend delRec = friendListDel.get(0);
			if (dao.delete(delRec)) {
				System.out.println("削除成功！");
				friendListDel = dao.select(new Friend("user001", "user003", 0));
				FriendDAOTest.showAllData(friendListDel);
			} else {
				System.out.println("削除失敗！");
			}
		}catch (Exception e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
	}
}
