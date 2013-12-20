using UnityEngine;
using System;
using System.Collections.Generic;

public class QuestionsScript : MonoBehaviour {
	
	public GUISkin ChallengeSkin;
	
	public Texture2D QuestionButton;
	public Texture2D QuestionButton_h;

	public Texture2D AnswerButton;
	public Texture2D AnswerButton_h;

	private int round;
	private int correctAnswers;
	private float challengeTime;
	private bool challengeEnded;

	private ChallengeQuestion[] questions;

	void Start() {

		round = 0;
		correctAnswers = 0;
		challengeEnded = false;
		challengeTime = Time.time;

		try {
			questions = ServerConnector.getInstance().getNewChallengeQuestions();
		} catch (System.Net.WebException) {
			questions = null;
		}

	}
	
	void OnGUI() {
		if (PreGUI.preFlag) {

						if (questions == null) {
								ButtonstyleGUI_CS.ChallengeButtonStyle (QuestionButton, QuestionButton_h);
								GUI.Button (new Rect (Screen.width / 2 - 250, 50, 500, 50), "Error: No connection to the server");
						}

						if (challengeEnded) {
								ButtonstyleGUI_CS.ChallengeButtonStyle (QuestionButton, QuestionButton_h);
								GUI.Button (new Rect (Screen.width / 2 - 250, 50, 500, 50), "Correct answers: " + correctAnswers + " (" + challengeTime + " s)");
								
								ButtonstyleGUI_CS.ChallengeButtonStyle (QuestionButton, QuestionButton_h);
								if(GUI.Button (new Rect (Screen.width / 2 - 250, 500, 500, 50), "Return to Office"))
									Application.LoadLevel("Office");

					
								return;
						}

						if (round == 5) {
								challengeEnded = true;
								challengeTime = Time.time - challengeTime;

								challengeEnded = true;
								//end timer

								handleResults ();
						}


						GUI.skin = ChallengeSkin;

						//Question Button
						ButtonstyleGUI_CS.ChallengeButtonStyle (QuestionButton, QuestionButton_h);
						GUI.Button (new Rect (Screen.width / 2 - 250, 50, 500, 50), questions [round].getQuestion ());

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

	private void handleAnswer(bool answer) {

		if(answer)
			correctAnswers++;

		round++;
	}

	private void handleResults() {

		Debug.Log("Sending challenge results to the Server: " + correctAnswers.ToString());
		Debug.Log("Sending challenge time to the Server: " + challengeTime);
		//send to server answers + challenge time
		
	}

	
	
	
}