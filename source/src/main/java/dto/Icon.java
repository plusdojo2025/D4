package dto;

import java.io.Serializable;

public class Icon implements Serializable{
	private int days;    /*報酬配布日数*/
	private int id;      /*アイコンid*/
	private String path; /*画像のパス*/

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
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
	/*コンストラクタ*/
	public Icon(int id, int days, String path) {
		this.id = id;
		this.days = days;
		this.path = path;
	}
	
	public Icon() {
		this.id = 0;
		this.days = 0;
		this.path="";
	}
}
