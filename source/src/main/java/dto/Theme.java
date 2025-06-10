package dto;

import java.io.Serializable;


public class Theme implements Serializable {

    private int id;                  // テーマID
    private String name;             // テーマ名


    public Theme() {
    	this.id = 0;
    	this.name = "";
    	}

    public Theme(int id, String name) {
        this.id = id;
        this.name = name;        
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}

