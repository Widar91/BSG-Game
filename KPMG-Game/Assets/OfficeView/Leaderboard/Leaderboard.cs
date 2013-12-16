using UnityEngine;
using System.Collections;

public class Leaderboard : MonoBehaviour {

	public int toggleLeader = 0;
	public GUISkin LeaderSkin;
	//public Transform target;
	Vector3 point;

	//Content
	int[] Scores = {87987,45155,56825};
	string[] empName = { "one", "two", "three" };
	int numPlayers = 3;

	public Texture2D[] badgeTextures;
	string[] badgeTips = {"You did something", "You completed something", "You rock", "You own the world"};
	int[,] Badges = new int[,] { { 0, 0, 0, 1 }, { 1, 0, 1, 0 }, { 1, 1, 1, 0 } };
	int numBadges = 4;

	public Texture2D Close;
	public Texture2D Close_h;

	string[] temp = {"Good","BAD","NICE"};



	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

		//point.x = Event.current.mousePosition.x;
		//point.y = Event.current.mousePosition.y;
	
	}

	void OnMouseDown(){

		toggleLeader = 1;

	}

	void OnGUI(){
		GUI.skin = LeaderSkin;

		//point.x = Event.current.mousePosition.x;
		//point.y = Event.current.mousePosition.y;

		if (toggleLeader == 1) {
						Time.timeScale = 0; //Remember to set 1 for resuming.
						GUI.Window (0, new Rect (Screen.width/2-450, 100, Screen.width - 360, Screen.height - 250), leaderWindow, "Leader Boards");
						
				}


	}


	//GUI Window
	void leaderWindow (int windowID) {


		GUI.BeginGroup (new Rect (10, 50, Screen.width - 360, Screen.height - 250), "");

		//Titles
		GUI.Label (new Rect (0, 0, 60, 50), "Rank");
		GUI.Label (new Rect (100, 0, 60, 50), "Name");
		GUI.Label (new Rect (400, 0, 60, 50), "Score");
		GUI.Label (new Rect (600, 0, 120, 50), "Achievements");

		//Content
		for (int i=0; i<numPlayers; i++) {

			int flag = 0;//To offset badges

			GUI.Label(new Rect(10,(i+1)*60,60,40),(i+1).ToString());
			GUI.Label(new Rect(110,(i+1)*60,60,50),empName[i]);
			GUI.Label(new Rect(400,(i+1)*60,60,50),Scores[i].ToString());

			//Badges correspond to j and player to i
			for(int j=0; j<numBadges; j++){



				if(Badges[i,j] == 1){

					flag = flag + 1;

					GUI.Label(new Rect(600+flag*30,(i+1)*60,30,30),new GUIContent(badgeTextures[j], badgeTips[j]));



						}


					}

				}
		//Tooltip for badges
		GUI.Label(new Rect(800,200,150,30),GUI.tooltip);

		GUI.EndGroup();

		//Close Button
		ButtonstyleGUI_CS.buttonstyle(Close,Close_h);
		if(GUI.Button(new Rect(950,10,40,40),"")){
			toggleLeader = 0;
		}


				
	}


			
}