package nl.tudelft.bsg.kpmgcities.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;


@Entity
public class Player implements Serializable {
	
	private static final long serialVersionUID = 4952620723643645983L;
	
	@Id
	@GeneratedValue
	private int id;
	
	private String name;
	private String office;
	private String department;
	private int office3DScore;

	@OneToMany
	private List<SceneObj> sceneObjs;
	
	@OneToMany
	private List<Achievement> achievements;
	@OneToMany
	private List<Trophy> trophies;
	
	
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
	public List<SceneObj> getSceneObjs() {
		return sceneObjs;
	}
	public void setSceneObjs(List<SceneObj> sceneObjs) {
		this.sceneObjs = sceneObjs;
	}
	public int getOffice3DScore() {
		return office3DScore;
	}
	public void setOffice3DScore(int office3dScore) {
		office3DScore = office3dScore;
	}
	public List<Achievement> getAchievements() {
		return achievements;
	}
	public void setAchievements(List<Achievement> achievements) {
		this.achievements = achievements;
	}
	public List<Trophy> getTrophies() {
		return trophies;
	}
	public void setTrophies(List<Trophy> trophies) {
		this.trophies = trophies;
	}
	
}
