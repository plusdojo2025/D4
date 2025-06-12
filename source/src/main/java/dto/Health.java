package dto;

import java.io.Serializable;

public class Health implements Serializable {
	private String id;   //プレイヤーID
	private String date;   //日付
	
	private int vegetable; //野菜
	private int sleep;	   //睡眠
	private int walk;      //運動
	private int stress;    //ストレス
	private double weight; //体重
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getVegetable() {
		return vegetable;
	}
	public void setVegetable(int vegetable) {
		this.vegetable = vegetable;
	}
	public int getSleep() {
		return sleep;
	}
	public void setSleep(int sleep) {
		this.sleep = sleep;
	}
	public int getWalk() {
		return walk;
	}
	public void setWalk(int walk) {
		this.walk = walk;
	}
	public int getStress() {
		return stress;
	}
	public void setStress(int stress) {
		this.stress = stress;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	
	public Health() {
		this.id = "";
		this.date = "";
		this.vegetable = 0;
		this.sleep = 0;
		this.walk = 0;
		this.stress = 0;
		this.weight = 0;
	}
	
	public Health(String id, String date) {
		this.id = id;
		this.date= date;
		this.vegetable = 0;
		this.sleep = 0;
		this.walk = 0;
		this.stress = 0;
		this.weight = 0;
		
	}
	
	public Health(String id, String date, int vegetable, int sleep, int walk, int stress,
			double weight) {
		this.id = id;
		this.date= date;
		this.vegetable = vegetable;
		this.sleep = sleep;
		this.walk = walk;
		this.stress = stress;
		this.weight = weight;
		
	}
	

}
