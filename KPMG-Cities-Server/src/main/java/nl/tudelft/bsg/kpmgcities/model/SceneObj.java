package nl.tudelft.bsg.kpmgcities.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class SceneObj implements Serializable {

	private static final long serialVersionUID = -8344480967442885693L;
	
	@Id
	@GeneratedValue
	private int id;
	private String name;
	private String scene;
	
	
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
	public String getScene() {
		return scene;
	}
	public void setScene(String scene) {
		this.scene = scene;
	}
	
	@Override
	public boolean equals(Object o) {
		if(this.getName() == ((SceneObj) o).getName() && this.getScene() == ((SceneObj)  o).getScene())
			return true;
		
		return false;
	}
	
}
