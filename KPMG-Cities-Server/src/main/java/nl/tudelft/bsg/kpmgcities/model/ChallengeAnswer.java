package nl.tudelft.bsg.kpmgcities.model;

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
	
	@Override
	public String toString() {
		return "Answer [answer=" + answer + "]";
	}
	
	
}
