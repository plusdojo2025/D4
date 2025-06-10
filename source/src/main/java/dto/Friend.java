package dto;

import java.io.Serializable;

public class Friend implements Serializable{
	private String myId;     /*自分のid*/
	private String friendId; /*相手のid*/
	private int state;       /*承認状態*/
	
	public String getMyId() {
		return myId;
	}
	public void setMyId(String myId) {
		this.myId = myId;
	}
	public String getFriendId() {
		return friendId;
	}
	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
	/*コンストラクタ*/
	public Friend(String myId, String friendId, int state){
		this.myId = myId;
		this.friendId = friendId;
		this.state = state;
	}
	public Friend() {
		this.myId = "";
		this.friendId = "";
		this.state = 0;
	}
}
