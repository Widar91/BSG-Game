using System.Collections.Generic;

public class ChallengeQuestion {

	private string question;
	private string[] answers;

	public ChallengeQuestion (string question, string[] answers) {
		this.question = question;
		this.answers = answers;
	}

	public string getQuestion() {
		return this.question;
	}

	public string[] getAnswers() {
		return this.answers;
	}
	

}
