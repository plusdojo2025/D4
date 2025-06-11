package dto;

import java.io.Serializable;

public class Users implements Serializable{
	private String id; 		/*ID*/
	private String pw; 		/*パスワード*/
	private int height; 	/*身長*/
	private String name; 	/*ニックネーム*/
	private int theme; 		/*テーマ*/
	private int icon; 		/*アイコン*/
	private int vPrivate; 	/*野菜情報の公開設定*/
	private int sPrivate; 	/*睡眠情報の公開設定*/
	private int wPrivate; 	/*運動情報の公開設定*/
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getTheme() {
		return theme;
	}
	public void setTheme(int theme) {
		this.theme = theme;
	}
	public int getIcon() {
		return icon;
	}
	public void setIcon(int icon) {
		this.icon = icon;
	}
	public int getvPrivate() {
		return vPrivate;
	}
	public void setvPrivate(int vPrivate) {
		this.vPrivate = vPrivate;
	}
	public int getsPrivate() {
		return sPrivate;
	}
	public void setsPrivate(int sPrivate) {
		this.sPrivate = sPrivate;
	}
	public int getwPrivate() {
		return wPrivate;
	}
	public void setwPrivate(int wPrivate) {
		this.wPrivate = wPrivate;
	}
	
	/*コンストラクタ*/
	public Users(String id, String pw, int height, String name,
					int theme, int icon, int vPrivate, int sPrivate, int wPrivate){
		this.id = id;
		this.pw = pw;
		this.height = height;
		this.name = name;
		this.theme = theme;
		this.icon = icon;
		this.vPrivate = vPrivate;
		this.sPrivate = sPrivate;
		this.wPrivate = wPrivate;
		
	}
	
	public Users(String id){
		
		this.id = id;
		this.pw = "";
		this.height = 0;
		this.name = "";
		this.theme = 1;
		this.icon =  1;
		this.vPrivate = 0;
		this.sPrivate = 0;
		this.wPrivate = 0;
	}
	
	public Users(){
		
		this.id = "";
		this.pw = "";
		this.height = 0;
		this.name = "";
		this.theme = 1;
		this.icon =  1;
		this.vPrivate = 0;
		this.sPrivate = 0;
		this.wPrivate = 0;
	}
}
