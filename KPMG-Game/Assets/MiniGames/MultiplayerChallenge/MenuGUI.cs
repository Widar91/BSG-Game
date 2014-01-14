using UnityEngine;
using System;
using System.Collections.Generic;


public class MenuGUI : MonoBehaviour {

	public static bool beginChallenge = false;
	public static bool toogleChallengesWindow = true;
	public static bool toogleNewChallengeWindow = false;
	public static List<MinigameChallenge> challenges = new List<MinigameChallenge>();
	public static List<string> players = new List<string>();

	public Texture2D challengeButton;
	public Texture2D challengeButton_h;
	public Texture2D playButton;
	public Texture2D playButton_h;
	public Texture2D backButton;
	public Texture2D backButton_h;

	public Vector2 scrollPosition = Vector2.zero;


	void OnStart() {

		beginChallenge = false;
		toogleChallengesWindow = true;
		toogleNewChallengeWindow = false;
	
	}

	void OnGUI(){
		if (toogleChallengesWindow) {
			if(challenges.Count == 0) {
				Debug.Log("cs: " + challenges.Count);
				challenges = ServerConnector.getInstance().getMinigameChallenges();
				Debug.Log("cs2: " + challenges.Count);
			}

			GUI.Window (0, new Rect (Screen.width*0.2f, 30, Screen.width*0.6f, Screen.height*0.75f), ChallengesWindow, "Challenges");
			//Time.timeScale = 0;
		}
		if (toogleNewChallengeWindow) {
			if(players.Count == 0) {
				Debug.Log("ps: " + players.Count);
				players = ServerConnector.getInstance().getPlayersNames();
				Debug.Log("ps2: " + players.Count);
			}
			GUI.Window (0, new Rect (Screen.width * 0.2f, 30, Screen.width * 0.6f, Screen.height * 0.75f), NewChallengeWindow, "Pick Opponent");
			//Time.timeScale = 0;
		}
	}

	void ChallengesWindow (int windowID){

		//Titles
		GUI.Label (new Rect (Screen.width*0.02f, 40, 60, 50), "N.");
		GUI.Label (new Rect (Screen.width*0.05f, 40, 60, 50), "Player 1");
		GUI.Label (new Rect (Screen.width*0.1f, 40, 120, 50), "Correct Answers");
		GUI.Label (new Rect (Screen.width*0.18f, 40, 60, 50), "Elapsed Time");
		GUI.Label (new Rect (Screen.width*0.25f, 40, 120, 50), "Player 2");
		GUI.Label (new Rect (Screen.width*0.3f, 40, 120, 50), "Correct Answers");
		GUI.Label (new Rect (Screen.width*0.38f, 40, 120, 50), "Elapsed Time");
		GUI.Label (new Rect (Screen.width*0.505f, 40, 120, 50), "Status");
		//GUI.Label (new Rect (Screen.width*0.5f, 40, 120, 50), "Score");
		
		scrollPosition = GUI.BeginScrollView (new Rect (0, 75, Screen.width*0.58f, Screen.height*0.6f),
		                                      scrollPosition, 
		                                      new Rect (0, 0, Screen.width*0.58f-100, Screen.height*0.25f+(30*challenges.Count)));

		ButtonstyleGUI_CS.buttonstyle (challengeButton, challengeButton_h);

		//Content
		int i = 0;
		foreach (MinigameChallenge p in challenges){

			GUI.Label(new Rect(Screen.width*0.02f,(i+1)*30,60,40),(i+1).ToString());
			GUI.Label(new Rect(Screen.width*0.05f,(i+1)*30,120,50),p.getPlayer1());

			ChallengeResult r = p.getChallengeResult1();
			if(r != null) {
				GUI.Label(new Rect(Screen.width*0.1f,(i+1)*30,60,50), ""+r.getCorrectAnswers());
				GUI.Label(new Rect(Screen.width*0.18f,(i+1)*30,60,50), ""+r.getTime());
			}

			GUI.Label(new Rect(Screen.width*0.25f,(i+1)*30,60,50),p.getPlayer2());

			r = p.getChallengeResult2();
			if(r != null) {
				GUI.Label(new Rect(Screen.width*0.3f,(i+1)*30,60,50),""+r.getCorrectAnswers());
				GUI.Label(new Rect(Screen.width*0.38f,(i+1)*30,60,50),""+r.getTime());
			}

			if(p.getStatus().Equals("ACTIVE")) {
				if(GUI.Button(new Rect(Screen.width*0.48f,(i+1)*30,120,25), "Play")){
					QuestionsScript.setChallenge(p);
					toogleChallengesWindow = false;
					beginChallenge = true;
					Time.timeScale = 1;
				}
			}

			if(p.getStatus().Equals("WAITING_FOR_OPPONENT")) {
				if(p.getPlayer1().Equals(ServerConnector.getInstance().playerName)) {
					GUI.Label(new Rect(Screen.width*0.48f,(i+1)*30,160,50), "Waiting for Opponent");
				}
				else {
					if(GUI.Button(new Rect(Screen.width*0.48f,(i+1)*30,120,25), "Play")){
						QuestionsScript.setChallenge(p);
						toogleChallengesWindow = false;
						beginChallenge = true;
						Time.timeScale = 1;
					}
				}
			}

			if(p.getStatus().Equals("WAITING_FOR_RESULTS")) {
				if(p.getPlayer2().Equals(ServerConnector.getInstance().playerName)) {
					GUI.Label(new Rect(Screen.width*0.48f,(i+1)*30,160,50), "Waiting for Opponent");
				}
				else {
					if(GUI.Button(new Rect(Screen.width*0.48f,(i+1)*30,120,25), "Play")){
						QuestionsScript.setChallenge(p);
						toogleChallengesWindow = false;
						beginChallenge = true;
						Time.timeScale = 1;
					}
				}
			}

			i++;
			
		}
		GUI.EndScrollView ();

		ButtonstyleGUI_CS.buttonstyle (challengeButton, challengeButton_h);
		if (GUI.Button (new Rect (Screen.width * 0.4f, Screen.height * 0.7f, 200, 30), "Start new Challenge")) {
			toogleChallengesWindow=false;
			toogleNewChallengeWindow=true;
		}
		ButtonstyleGUI_CS.buttonstyle (backButton, backButton_h);
		if (GUI.Button (new Rect (Screen.width * 0.05f, Screen.height * 0.7f, 200, 30), "Return to the Office")) {
			challenges = new List<MinigameChallenge>();
			toogleChallengesWindow = false;
			toogleNewChallengeWindow = false;
			beginChallenge = false;
			Time.timeScale = 1;
			Application.LoadLevel("Office");
			toogleChallengesWindow = true;
			return;
		}
	}

	void NewChallengeWindow (int windowID) {
		
		scrollPosition = GUI.BeginScrollView (new Rect (0, 75, Screen.width*0.58f, Screen.height*0.6f),
		                                      scrollPosition, 
		                                      new Rect (0, 0, Screen.width*0.58f-100, Screen.height*0.25f+(30*players.Count)));
		
		ButtonstyleGUI_CS.buttonstyle (challengeButton, challengeButton_h);
		
		//Content
		int i = 0;
		foreach (String p in players){

			GUI.Label(new Rect(Screen.width*0.18f,(i+1)*30,160,25), "" + p);
			if(GUI.Button(new Rect(Screen.width*0.38f,(i+1)*30,160,25),"" + "Challenge")) {
				string json = ServerConnector.getInstance().newMinigameChallenge(p);
				Debug.Log("json: " + json);
				MinigameChallenge c = JSONConverter.getInstance().convertMinigameChallenge(json);
				QuestionsScript.setChallenge(c);
				toogleNewChallengeWindow = false;
				beginChallenge = true;
				Time.timeScale = 1;
			}
			
			i++;
			
		}
		GUI.EndScrollView ();

		ButtonstyleGUI_CS.buttonstyle (backButton, backButton_h);
		if (GUI.Button (new Rect (Screen.width * 0.05f, Screen.height * 0.7f, 75, 30), "Cancel")) {
			toogleNewChallengeWindow=false;
			toogleChallengesWindow=true;
		}
	}
}
