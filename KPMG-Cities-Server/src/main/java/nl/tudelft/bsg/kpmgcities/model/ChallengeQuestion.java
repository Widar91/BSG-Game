package nl.tudelft.bsg.kpmgcities.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class ChallengeQuestion implements Serializable {

	private static final long serialVersionUID = 7309926246926226560L;
	
	@Id
	@GeneratedValue
	int questionID;
	String question;
	@OneToMany
	List<ChallengeAnswer> answers;
	
	
	
	public int getQuestionID() {
		return questionID;
	}
	public void setQuestionID(int questionID) {
		this.questionID = questionID;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public List<ChallengeAnswer> getAnswers() {
		return answers;
	}
	public void setAnswers(List<ChallengeAnswer> answers) {
		this.answers = answers;
	}
	
}
