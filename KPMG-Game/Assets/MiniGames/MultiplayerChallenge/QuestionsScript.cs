using UnityEngine;
using System;
using System.Collections.Generic;

public class QuestionsScript : MonoBehaviour {
	
	public GUISkin ChallengeSkin;
	
	public Texture2D QuestionButton;
	public Texture2D QuestionButton_h;

	public Texture2D AnswerButton;
	public Texture2D AnswerButton_h;

	private static int round;
	private static int correctAnswers;
	private static float challengeTime;
	private static bool challengeEnded = false;
	private static MinigameChallenge challenge;
	private static List<ChallengeQuestion> questions;

	void Start() {

		round = 0;
		correctAnswers = 0;
		challengeTime = Time.time;

	}
	
	void OnGUI() {
		if (MenuGUI.beginChallenge) {
						

						if (challengeEnded) {

								ButtonstyleGUI_CS.ChallengeButtonStyle (QuestionButton, QuestionButton_h);
								GUI.Button (new Rect (Screen.width / 2 - 250, 50, 500, 50), "Correct answers: " + correctAnswers + " (" + challengeTime + " s)");
								
								ButtonstyleGUI_CS.ChallengeButtonStyle (QuestionButton, QuestionButton_h);
								if(GUI.Button (new Rect (Screen.width / 2 - 250, 500, 500, 50), "Return to Lobby")) {
									MenuGUI.beginChallenge = false;
									MenuGUI.toogleChallengesWindow = true;
									challengeEnded = false;
									correctAnswers = 0;
									challengeTime = Time.time;
					
									MenuGUI.challenges = new List<MinigameChallenge>();
									//Time.timeScale = 0;
								}

								return;

						}

						if (round == 5) {
							challengeTime = Time.time - challengeTime;
							handleResults ();

							round = 0;
							challengeEnded = true;

							return;

						}
													

						GUI.skin = ChallengeSkin;

						if (questions == null) {
							ButtonstyleGUI_CS.ChallengeButtonStyle (QuestionButton, QuestionButton_h);
							GUI.Button (new Rect (Screen.width / 2 - 250, 50, 500, 50), "Error: No connection to the server");
						return;
						}

						//Question Button
						if(round < 5) {
							ButtonstyleGUI_CS.ChallengeButtonStyle (QuestionButton, QuestionButton_h);
							GUI.Button (new Rect (Screen.width / 2 - 250, 50, 500, 50), questions[round].getQuestion());
						}

						KeyValuePair<string, bool>[] answers = questions [round].getAnswers ();

						//Answers Buttons
						ButtonstyleGUI_CS.ChallengeButtonStyle (AnswerButton, AnswerButton);
						if (GUI.Button (new Rect (Screen.width / 2 - 250, 200, 500, 50), answers [0].Key))
								handleAnswer (answers [0].Value);


						if (GUI.Button (new Rect (Screen.width / 2 - 250, 275, 500, 50), answers [1].Key))
								handleAnswer (answers [1].Value);


						if (GUI.Button (new Rect (Screen.width / 2 - 250, 350, 500, 50), answers [2].Key))
								handleAnswer (answers [2].Value);


						if (GUI.Button (new Rect (Screen.width / 2 - 250, 425, 500, 50), answers [3].Key))
								handleAnswer (answers [3].Value);


						if (GUI.Button (new Rect (Screen.width / 2 - 250, 500, 500, 50), answers [4].Key))
								handleAnswer (answers [4].Value);

				}
	}

	public static void setChallenge(MinigameChallenge c) {
		challenge = c;
		questions = c.getChallengeQuestions();
		round = 0;
		correctAnswers = 0;
		challengeTime = Time.time;
	}

	private void handleAnswer(bool answer) {

		if(answer)
			correctAnswers++;

		round++;
	}

	private void handleResults() {

		Debug.Log("Sending challenge results to the Server: " + correctAnswers.ToString());
		Debug.Log("Sending challenge time to the Server: " + challengeTime);
		ServerConnector.getInstance().sendMinigameResult(challenge.getId(), correctAnswers, challengeTime);
		
	}

}