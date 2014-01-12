package nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import nl.tudelft.bsg.kpmgcities.model.Player;

@Entity
public class MinigameChallenge implements Serializable {

	private static final long serialVersionUID = -501835055891610384L;
	
	@Id
	@GeneratedValue
	private int id;
	private String player1;
	private String player2;
	@Enumerated
	private MinigameChallengeStatus status;
	@OneToMany
	private List<ChallengeQuestion> questions;
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
	public String getPlayer1() {
		return player1;
	}
	public void setPlayer1(String player1) {
		this.player1 = player1;
	}
	public String getPlayer2() {
		return player2;
	}
	public void setPlayer2(String player2) {
		this.player2 = player2;
	}
	public MinigameChallengeStatus getStatus() {
		return status;
	}
	public void setStatus(MinigameChallengeStatus status) {
		this.status = status;
	}
	public List<ChallengeQuestion> getQuestions() {
		return questions;
	}
	public void setQuestions(List<ChallengeQuestion> questions) {
		this.questions = questions;
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
