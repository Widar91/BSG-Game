using UnityEngine;
using System.Collections;

public class ExitDoor : MonoBehaviour {

	private StoryController storyController;
	private PlayerController playerController;
	private bool wannaExit;
	private bool coolingDown;

	// Use this for initialization
	void Start () {
		GameObject CLI = GameObject.Find ("CompetitionLawInfringeMent");
		storyController = CLI.GetComponent<StoryController> ();

		GameObject player = GameObject.FindGameObjectWithTag ("Player");
		playerController = player.GetComponent<PlayerController> ();

		wannaExit = false;
		coolingDown = false;
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnTriggerEnter(Collider col) {

		if (!coolingDown) {
			storyController.LockPlayerMovement (true);
			wannaExit = true;
		}
		
	}



	void OnGUI() {
				
		// shows question
		if (wannaExit)
			GUI.Window (0, new Rect (Screen.width / 2 - 200, Screen.height / 2 - 150, 400, 300), questionWindow, "Quit");

	}
	
	//GUI Window Questions
	void questionWindow (int windowID) {
		
		//GUI.BeginGroup (new Rect (50, 50, Screen.width - 100, Screen.height - 100), "");
		
		//Titles
		GUI.Label (new Rect (20, 40, 400 - 40, 50), "Do you want to quit?");

		if (GUI.Button(new Rect (20, 90, 300, 25), "Yes")) {
			Application.LoadLevel("Office");
		}
		
		if (GUI.Button(new Rect (20, 120, 300, 25), "No")) {
			wannaExit = false;
			storyController.LockPlayerMovement (false);
			coolingDown = true;
			Invoke ("coolDownOff", 3f);
		}

	}

	private void coolDownOff() {
		coolingDown = false;
	}

}
