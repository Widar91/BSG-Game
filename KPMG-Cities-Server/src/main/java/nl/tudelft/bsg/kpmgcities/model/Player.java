package nl.tudelft.bsg.kpmgcities.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Player implements Serializable {
	
	private static final long serialVersionUID = 3634843961492433604L;
			
	@Id
	@GeneratedValue
	int id;
	int [] scores;
	String name;
	String office;
	String department;
	String [] achievements;
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int[] getScores() {
		return scores;
	}
	public void setScores(int[] scores) {
		this.scores = scores;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOffice() {
		return office;
	}
	public void setOffice(String office) {
		this.office = office;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String[] getAchievements() {
		return achievements;
	}
	public void setAchievements(String[] achievements) {
		this.achievements = achievements;
	}
	
}
