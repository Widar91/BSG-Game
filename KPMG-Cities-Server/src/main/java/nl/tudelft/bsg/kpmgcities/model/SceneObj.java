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
	
	private double posx;
	private double posy;
	private double posz;
	
	private double rotx;
	private double roty;
	private double rotz;
	
	private double sclx;
	private double scly;
	private double sclz;
	
	
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
	public double getPosx() {
		return posx;
	}
	public void setPosx(double posx) {
		this.posx = posx;
	}
	public double getPosy() {
		return posy;
	}
	public void setPosy(double posy) {
		this.posy = posy;
	}
	public double getPosz() {
		return posz;
	}
	public void setPosz(double posz) {
		this.posz = posz;
	}
	public double getRotx() {
		return rotx;
	}
	public void setRotx(double rotx) {
		this.rotx = rotx;
	}
	public double getRoty() {
		return roty;
	}
	public void setRoty(double roty) {
		this.roty = roty;
	}
	public double getRotz() {
		return rotz;
	}
	public void setRotz(double rotz) {
		this.rotz = rotz;
	}
	public double getSclx() {
		return sclx;
	}
	public void setSclx(double sclx) {
		this.sclx = sclx;
	}
	public double getScly() {
		return scly;
	}
	public void setScly(double scly) {
		this.scly = scly;
	}
	public double getSclz() {
		return sclz;
	}
	public void setSclz(double sclz) {
		this.sclz = sclz;
	}

}
