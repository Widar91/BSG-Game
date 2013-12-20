package nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class ChallengeResult implements Serializable {

	private static final long serialVersionUID = -7989449479111904319L;
	
	@Id
	@GeneratedValue
	private int id;
	private int playerId;
	private float time;
	private int correctAnswers;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPlayerId() {
		return playerId;
	}
	public void setPlayerId(int playerId) {
		this.playerId = playerId;
	}
	public float getTime() {
		return time;
	}
	public void setTime(float time) {
		this.time = time;
	}
	public int getCorrectAnswers() {
		return correctAnswers;
	}
	public void setCorrectAnswers(int correctAnswers) {
		this.correctAnswers = correctAnswers;
	}

}
