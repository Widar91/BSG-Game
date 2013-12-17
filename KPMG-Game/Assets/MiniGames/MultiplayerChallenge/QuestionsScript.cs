using UnityEngine;
using System.Collections;

public class QuestionsScript : MonoBehaviour {
	
	public GUISkin ChallengeSkin;
	
	public Texture2D QuestionButton;
	public Texture2D QuestionButton_h;

	public Texture2D AnswerButton;
	public Texture2D AnswerButton_h;

	private bool [] answers;

	void OnStart() {
		answers = new bool[6];
	}
	
	void OnGUI() {
		GUI.skin = ChallengeSkin;
		
		ButtonstyleGUI_CS.buttonstyle(QuestionButton,QuestionButton_h);
		GUI.Button( new Rect(Screen.width/2 - 250, 50, 500, 50), "PUT QUESTION HERE" );

		ButtonstyleGUI_CS.buttonstyle(AnswerButton,AnswerButton);

		if(GUI.Button( new Rect(Screen.width/2 - 250, 200, 500, 50), "ANSWER 1" ))
			answers[0] = true;

		if(GUI.Button( new Rect(Screen.width/2 - 250, 275, 500, 50), "ANSWER 2" ))
			answers[1] = true;

		if(GUI.Button( new Rect(Screen.width/2 - 250, 350, 500, 50), "ANSWER 3" ))
			answers[2] = true;

		if(GUI.Button( new Rect(Screen.width/2 - 250, 425, 500, 50), "ANSWER 4" ))
			answers[3] = true;

		if(GUI.Button( new Rect(Screen.width/2 - 250, 500, 500, 50), "ANSWER 5" ))
			answers[4] = true;

		if(GUI.Button( new Rect(Screen.width/2 - 250, 575, 500, 50), "ANSWER 6" ))
			answers[5] = true;

	}
	
	
	//GUI Window
	void leaderWindow (int windowID) {
		
		//GUI.BeginGroup (new Rect (10, 50, Screen.width - 360, Screen.height - 250), "");
		

		//GUI.EndGroup();
		
	}
	
	
	
}