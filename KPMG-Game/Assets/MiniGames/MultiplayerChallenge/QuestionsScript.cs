using UnityEngine;
using System.Collections.Generic;

public class QuestionsScript : MonoBehaviour {
	
	public GUISkin ChallengeSkin;
	
	public Texture2D QuestionButton;
	public Texture2D QuestionButton_h;

	public Texture2D AnswerButton;
	public Texture2D AnswerButton_h;

	private int round;
	private bool challengeEnded;
	private ChallengeQuestion[] questions;
	private bool [] answers;

	void Start() {
		answers = new bool[5];

		round = 0;
		challengeEnded = false;
		questions = ServerConnector.getInstance().getNewChallengeQuestions();

	}
	
	void OnGUI() {

		if(challengeEnded) 
			return;

		if(round == 5) {
			challengeEnded = true;
			handleResults();
		}


		GUI.skin = ChallengeSkin;

		//Question Button
		ButtonstyleGUI_CS.ChallengeButtonStyle(QuestionButton, QuestionButton_h);
		GUI.Button( new Rect(Screen.width/2 - 250, 50, 500, 50), questions[round].getQuestion());

		//Answers Buttons
		ButtonstyleGUI_CS.ChallengeButtonStyle(AnswerButton,AnswerButton);
		if(GUI.Button( new Rect(Screen.width/2 - 250, 200, 500, 50), questions[round].getAnswers()[0] ))
			handleAnswer(0);

		if(GUI.Button( new Rect(Screen.width/2 - 250, 275, 500, 50), questions[round].getAnswers()[1] ))
			handleAnswer(1);

		if(GUI.Button( new Rect(Screen.width/2 - 250, 350, 500, 50), questions[round].getAnswers()[2] ))
			handleAnswer(2);

		if(GUI.Button( new Rect(Screen.width/2 - 250, 425, 500, 50), questions[round].getAnswers()[3] ))
			handleAnswer(3);

		if(GUI.Button( new Rect(Screen.width/2 - 250, 500, 500, 50), questions[round].getAnswers()[4] ))
			handleAnswer(4);

	}

	private void handleAnswer(int answerNumber) {

		//if()

		round++;
	}

	private void handleResults() {
		
	}

	
	
	
}