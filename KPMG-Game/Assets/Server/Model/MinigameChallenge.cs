using System.Collections.Generic;

public class MinigameChallenge {

	private int id;
	private string status;

	private string player1;
	private string player2;

	private List<ChallengeQuestion> questions;

	private ChallengeResult result1;
	private ChallengeResult result2;

	public int getId() {
		return id;
	}
	public string getStatus() {
		return status;
	}
	public string getPlayer1() {
		return player1;
	}
	public string getPlayer2() {
		return player2;
	}
	public List<ChallengeQuestion> getChallengeQuestions() {
		return questions;
	}
	public ChallengeResult getChallengeResult1() {
		return result1;
	}
	public ChallengeResult getChallengeResult2() {
		return result2;
	}
	public void setId(int i) {
		id = i;
	}
	public void setStatus(string s) {
		status = s;
	}
	public void setPlayer1(string p) {
		player1 = p;
	}
	public void setPlayer2(string p) {
		player2 = p;
	}
	public void setChallengeQuestions(List<ChallengeQuestion> q) {
		questions = q;
	}
	public void setChallengeResult1(ChallengeResult r) {
		result1 = r;
	}
	public void setChallengeResult2(ChallengeResult r) {
		result2 = r;
	}
}