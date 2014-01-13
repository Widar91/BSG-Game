using System.Collections.Generic;

public class ChallengeResult {

	private float time;
	private int correctAnswers;

	public ChallengeResult (float time, int correctAnswers) {
		this.time = time;
		this.correctAnswers = correctAnswers;
	}

	public float getTime() {
		return time;
	}
	public void setTime(float t) {
		time = t;
	}
	public int getCorrectAnswers() {
		return correctAnswers;
	}
	public void setcorrectAnswers(int ca) {
		correctAnswers = ca;
	}

}
