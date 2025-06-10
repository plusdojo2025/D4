package dto;

import java.io.Serializable;

public class Icon implements Serializable{
	private int days;    /*報酬配布日数*/
	private int id;      /*アイコンid*/
	private String pass; /*画像のパス*/
	
	public int getDays() {
		return days;
	}
	public void setDays(int days) {
		this.days = days;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
	/*コンストラクタ*/
	public Icon(int id, int days, String pass) {
		this.id = id;
		this.days = days;
		this.pass = pass;
	}
	
	public Icon() {
		this.id = 0;
		this.days = 0;
		this.pass="";
	}
}
