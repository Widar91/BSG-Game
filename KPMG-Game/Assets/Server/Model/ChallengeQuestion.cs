using System.Collections.Generic;

public class ChallengeQuestion {

	private string question;
	private List<string> answers;

	public ChallengeQuestion (string question, List<string> answers) {
		this.question = question;
		this.answers = answers;
	}

	public string getQuestion() {
		return this.question;
	}

	public List<string> getAnswers() {
		return this.answers;
	}
	

}
