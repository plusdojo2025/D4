package dto;

import java.io.Serializable;

public class Friend implements Serializable{
	private String myId;
	private String friendId;
	private int state;
	
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
