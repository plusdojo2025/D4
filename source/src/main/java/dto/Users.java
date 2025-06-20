package dto;

import java.io.Serializable;

public class Users implements Serializable{
	private String id; 		/*ID*/
	private String pw; 		/*パスワード*/
	private int height; 	/*身長*/
	private String name; 	/*ニックネーム*/
	private String theme; 	/*テーマのパス*/
	private String icon; 	/*アイコンのパス*/
	private int vPrivate; 	/*野菜情報の公開設定*/
	private int sPrivate; 	/*睡眠情報の公開設定*/
	private int wPrivate; 	/*運動情報の公開設定*/
	private int mLogin;     /*合計ログイン日数*/
	private int nLogin;     /*最新連続ログイン日数*/
	
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
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
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
	public int getmLogin() {
		return mLogin;
	}
	public void setmLogin(int mLogin) {
		this.mLogin = mLogin;
	}
	public int getnLogin() {
		return nLogin;
	}
	public void setnLogin(int nLogin) {
		this.nLogin = nLogin;
	}
	/*コンストラクタ*/
	public Users(String id, String pw, int height, String name,
			String theme, String icon, int vPrivate, int sPrivate, int wPrivate, int mLogin, int nLogin){
		this.id = id;
		this.pw = pw;
		this.height = height;
		this.name = name;
		this.theme = theme;
		this.icon = icon;
		this.vPrivate = vPrivate;
		this.sPrivate = sPrivate;
		this.wPrivate = wPrivate;
		this.mLogin = mLogin;
		this.nLogin = nLogin;
	}
	
	public Users(String id, String pw, int height, String name,
			String theme, String icon, int vPrivate, int sPrivate, int wPrivate){
		this.id = id;
		this.pw = pw;
		this.height = height;
		this.name = name;
		this.theme = theme;
		this.icon = icon;
		this.vPrivate = vPrivate;
		this.sPrivate = sPrivate;
		this.wPrivate = wPrivate;
		this.mLogin = 0;
		this.nLogin = 0;
	}
	
	public Users(String id, String pw, int height, String name){
		this.id = id;
		this.pw = pw;
		this.height = height;
		this.name = name;
		this.theme = "";
		this.icon = "";
		this.vPrivate = 0;
		this.sPrivate = 0;
		this.wPrivate = 0;
		this.mLogin = 0;
		this.nLogin = 0;
	}
	
	public Users(String id){
		
		this.id = id;
		this.pw = "";
		this.height = 0;
		this.name = "";
		this.theme = "";
		this.icon =  "";
		this.vPrivate = 0;
		this.sPrivate = 0;
		this.wPrivate = 0;
		this.mLogin = 0;
		this.nLogin = 0;
	}
	
	public Users(){
		
		this.id = "";
		this.pw = "";
		this.height = 0;
		this.name = "";
		this.theme = "";
		this.icon =  "";
		this.vPrivate = 0;
		this.sPrivate = 0;
		this.wPrivate = 0;
		this.mLogin = 0;
		this.nLogin = 0;
	}
}
