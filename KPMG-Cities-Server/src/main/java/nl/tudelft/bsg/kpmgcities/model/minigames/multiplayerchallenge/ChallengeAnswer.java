package nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class ChallengeAnswer implements Serializable {

	private static final long serialVersionUID = -3558181327604846185L;
	
	@Id
	@GeneratedValue
	private int id;
	private String answer;
	private boolean correct;

	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	public boolean isCorrect() {
		return correct;
	}

	public void setCorrect(boolean correct) {
		this.correct = correct;
	}

	@Override
	public String toString() {
		return "Answer [answer=" + answer + "]";
	}
	
	
}
