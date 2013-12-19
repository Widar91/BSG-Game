using System.Collections.Generic;

public class ChallengeQuestion {

	private string question;
	private KeyValuePair<string, bool>[] answers;

	public ChallengeQuestion (string question, KeyValuePair<string, bool>[] answers) {
		this.question = question;
		this.answers = answers;
	}

	public string getQuestion() {
		return this.question;
	}

	public KeyValuePair<string, bool>[] getAnswers() {
		return this.answers;
	}
	

}
