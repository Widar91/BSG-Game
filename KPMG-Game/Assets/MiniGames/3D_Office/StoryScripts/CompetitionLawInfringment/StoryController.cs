using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class StoryController : MonoBehaviour {

	// Character variables
	private GameObject player;
	private PlayerController playerController;
	private bool playerLocked;

	private GameObject pierre;
	private PierreController pierreController;

	private GameObject steve;
	private SteveController steveController;

	// Story tracking variables
	private string objective;

	// Question variables
	private bool questionAsked = false;
	private string qQuestion;
	private List<string> qAnswers;
	private List<Action> qCallbacks;

	// Message variables
	private bool messageAsked = false;
	private string mMessage;
	private Action mCallback;

	// Use this for initialization
	void Start () {

		// set the current objetice to nothing
		objective = "";
		playerLocked = false;

		// get all character controllers
		player = GameObject.FindGameObjectWithTag("Player");
		playerController = player.GetComponent<PlayerController> ();

		pierre = GameObject.Find ("Pierre");
		pierreController = pierre.GetComponent<PierreController> ();

		steve = GameObject.Find ("Steve");
		steveController = steve.GetComponent<SteveController> ();

		// start first action
		GoToAction ("player", 0);


	}

	void OnGUI() {

		// shows objective
		GUI.Label (new Rect (25, 25, 400, 25), objective);

		// shows question
		if (questionAsked)
			GUI.Window (0, new Rect (Screen.width/2-150, 100, Screen.width - 360, Screen.height - 250), questionWindow, "Question");

		// shows message
		if (messageAsked)
			GUI.Window (0, new Rect (Screen.width/2-150, 100, Screen.width - 360, Screen.height - 250), messageWindow, "Message");
		
	}

	//GUI Window Questions
	void questionWindow (int windowID) {

			GUI.BeginGroup (new Rect (10, 50, Screen.width - 360, Screen.height - 250), "");
	
			//Titles
			GUI.Label (new Rect (0, 0, 500, 50), qQuestion);
			int top = 40;

			//Content
			if (qAnswers != null) {
				for (int i=0; i<qAnswers.Count; i++) {
			
					if (GUI.Button(new Rect(10, top, 300, 25), qAnswers[i])) {
						GoToAction(qCallbacks[i]);
						questionAsked = false;
						qQuestion = "";
						qAnswers = null;	
						qCallbacks= null;
					}
					
					top+= 30;
				}
			}
	}

	//GUI Window Message
	void messageWindow (int windowID) {
		
		GUI.BeginGroup (new Rect (10, 50, Screen.width - 360, Screen.height - 250), "");
		
		//Titles
		GUI.Label (new Rect (0, 60, 500, 50), mMessage);
			
		if (GUI.Button(new Rect(10, 40, 300, 25), "Close Message")) {
			GoToAction(mCallback);
			messageAsked = false;
			mMessage = "";
			mCallback = null;
		}

	}
	
	// Update is called once per frame
	void Update () {

		if (messageAsked || questionAsked || playerLocked)
			playerController.LockMovementAndMouse (true);
		else
			playerController.LockMovementAndMouse (false);
		
	}

	public void LockPlayerMovement(bool doLock) {
		playerLocked = doLock;	
	}

	public void GoToAction(Action action, float delay) {

		switch (action.person) {
			case "player": playerController.GoToAction(action.action, delay); break;
			case "pierre": pierreController.GoToAction(action.action, delay); break;
			case "steve":  steveController.GoToAction(action.action, delay); break;
		}

	}

	public void GoToAction(Action action) {
		GoToAction (action, 0f);
	}
	
	public void GoToAction(string person, int action, float delay) {
		GoToAction(new Action (person, action), delay);
	}

	public void GoToAction(string person, int action) {
		GoToAction(new Action (person, action), 0f);
	}
	
	public void setObjective(string obj) {
		objective = obj;
	}

	public void askQuestion(string question, List<string> answers, List<Action> callbacks) {

		if (answers.Count == callbacks.Count) {
			qQuestion = question;
			qAnswers = answers;
			qCallbacks = callbacks;
			questionAsked = true;
		}

	}

	public void showMessage(string message, Action callback) {

			mMessage = message;
			mCallback = callback;
			messageAsked = true;
		
	}

}

public class Action {

	public string person;
	public int action;

	public Action(string person, int Action) {
		this.person = person;
		this.action = Action;
	}

}
