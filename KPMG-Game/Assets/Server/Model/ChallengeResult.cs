using System.Collections.Generic;

public class ChallengeResult {

	private long time;
	private int correctAnswers;

	public ChallengeResult (long time, int correctAnswers) {
		this.time = time;
		this.correctAnswers = correctAnswers;
	}

	public long getTime() {
		return time;
	}
	public void setTime(long t) {
		time = t,
	}
	public int getCorrectAnswers() {
		return correctAnswers;
	}
	public void setcorrectAnswers(int ca) {
		correctAnswers = ca;
	}

}
