package dto;

import java.io.Serializable;
import java.util.List;

public class Ranking implements Serializable {
	private int rank;
	private String name;
	private double score;
	private int id;
	private List<Health> healthList;
	
	
	//ゲッター・セッター
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public List<Health> getHealthList() {
		return healthList;
	}
	public void setHealthList(List<Health> healthList) {
		this.healthList = healthList;
	}
	
	//コンストラクタ
	public Ranking(int rank, String name, double score, int id, List<Health> healthList) {
		super();
		this.rank = rank;
		this.name = name;
		this.score = score;
		this.id = id;
		this.healthList = healthList;
	}
	
	
}
