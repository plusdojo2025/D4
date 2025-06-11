package dto;

import java.io.Serializable;

public class Friend implements Serializable{
	private String myId;       /*自分のid*/
	private String friendId;   /*相手のid*/
	private String friendName; /*相手のニックネーム*/ 
	private int state;         /*承認状態*/

	
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
	public String getFriendName() {
		return friendName;
	}
	public void setFriendName(String friendName) {
		this.friendName = friendName;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
	
	/*コンストラクタ*/
	public Friend(String myId, String friendId, String friendName, int state){
		this.myId = myId;
		this.friendId = friendId;
		this.friendName = friendName;
		this.state = state;
	}
	public Friend(String myId, String friendId, int state){
		this.myId = myId;
		this.friendId = friendId;
		this.friendName = "";
		this.state = state;
	}
	public Friend(String myId, String friendId) {
		this.myId = myId;
		this.friendId = friendId;
		this.friendName = "";
		this.state = 0;
	}
	public Friend(String myId) {
		this.myId = myId;
		this.friendId = "";
		this.friendName = "";
		this.state = 0;
	}
	public Friend() {
		this.myId = "";
		this.friendId = "";
		this.friendName = "";
		this.state = 0;
	}
}
