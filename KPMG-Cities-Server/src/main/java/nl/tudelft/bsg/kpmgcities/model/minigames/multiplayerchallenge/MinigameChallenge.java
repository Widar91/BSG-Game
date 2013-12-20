package nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import nl.tudelft.bsg.kpmgcities.utils.MinigameChallengeStatus;

@Entity
public class MinigameChallenge implements Serializable {

	private static final long serialVersionUID = -501835055891610384L;
	
	@Id
	@GeneratedValue
	private int id;
	@Enumerated
	private MinigameChallengeStatus status;
	@OneToMany
	private ChallengeQuestion[] question;
	@ManyToOne
	private ChallengeResult result1;
	@ManyToOne
	private ChallengeResult result2;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public MinigameChallengeStatus getStatus() {
		return status;
	}
	public void setStatus(MinigameChallengeStatus status) {
		this.status = status;
	}
	public ChallengeQuestion[] getQuestion() {
		return question;
	}
	public void setQuestion(ChallengeQuestion[] question) {
		this.question = question;
	}
	public ChallengeResult getResult1() {
		return result1;
	}
	public void setResult1(ChallengeResult result1) {
		this.result1 = result1;
	}
	public ChallengeResult getResult2() {
		return result2;
	}
	public void setResult2(ChallengeResult result2) {
		this.result2 = result2;
	}

}
