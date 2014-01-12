using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class StoryController : MonoBehaviour {

	// Character variables
	private GameObject player;
	private PlayerController playerController;
	private bool playerLockedMove = false;
	private bool playerLockedLook = false;

	private GameObject pierre;
	private PierreController pierreController;

	private GameObject steve;
	private SteveController steveController;

	private GameObject mia;
	private MiaController miaController;

	private GameObject john;
	private JohnController johnController;

	// Story tracking variables
	private string objective = "";
	private int score = 0;

	// Question variables
	private bool questionAsked = false;
	private string qQuestion;
	private List<string> qAnswers;
	private List<Action> qCallbacks;
	private List<int> qScores;
	private int qWindowWidth = 600;
	private int qWindowHeight = 400;
	private bool qBigAnswers = false;

	// Message variables
	private bool messageAsked = false;
	private string mMessage;
	private Action mCallback;
	private int mWindowWidth = 500;
	private int mWindowHeight = 300;

	// Use this for initialization
	void Start () {

		// get all character controllers
		player = GameObject.FindGameObjectWithTag("Player");
		playerController = player.GetComponent<PlayerController> ();

		pierre = GameObject.Find ("Pierre");
		pierreController = pierre.GetComponent<PierreController> ();

		steve = GameObject.Find ("Steve");
		steveController = steve.GetComponent<SteveController> ();

		mia = GameObject.Find ("Mia");
		miaController = mia.GetComponent<MiaController> ();

		john = GameObject.Find ("John");
		johnController = john.GetComponent<JohnController> ();

		// start first action
		GoToAction ("player", 0);
		//GoToAction ("john", 1);

	}

	void OnGUI() {

		// shows objective
		GUI.Label (new Rect (25, 25, 500, 25), objective);

		// shows question
		if (questionAsked)
			GUI.Window (0, new Rect (Screen.width / 2 - qWindowWidth / 2, Screen.height / 2 - qWindowHeight / 2, qWindowWidth, qWindowHeight), questionWindow, "Question");

		// shows message
		if (messageAsked)
			GUI.Window (0, new Rect (Screen.width / 2 - mWindowWidth / 2, Screen.height / 2 - mWindowHeight / 2, mWindowWidth, mWindowHeight), messageWindow, "Message");
		
	}

	//GUI Window Questions
	void questionWindow (int windowID) {

			//GUI.BeginGroup (new Rect (50, 50, Screen.width - 100, Screen.height - 100), "");
	
			//Titles
			GUI.Label (new Rect (20, 40, mWindowWidth - 40, 50), qQuestion);
			int top = 90;


			int answerOffset = 30;	
			Rect answerBox = new Rect (20, top, 300, 25);
			if (qBigAnswers) {
				answerOffset = 55;
				answerBox.width = 460;
				answerBox.height = 50;
			}
				

			//Content
			if (qAnswers != null) {
				for (int i=0; i<qAnswers.Count; i++) {
			
					if (GUI.Button(new Rect(answerBox.x, top, answerBox.width, answerBox.height), qAnswers[i])) {
						score += qScores[i];
						GoToAction(qCallbacks[i]);
						questionAsked = false;
						qQuestion = "";
						qAnswers = null;	
						qCallbacks= null;
						qBigAnswers = false;
					}
					
					top+= answerOffset;
				}
			}
	}

	//GUI Window Message
	void messageWindow (int windowID) {
		
		//GUI.BeginGroup (new Rect (Screen.width / 2 - 400, Screen.height / 2 - 200, 800, 400), "");
		
		//Titles
		GUI.Label (new Rect (20, 20, mWindowWidth - 40, mWindowHeight - 65), mMessage);
			
		if (GUI.Button(new Rect(20, mWindowHeight - 45, 300, 25), "Close Message")) {
			GoToAction(mCallback);
			messageAsked = false;
			mMessage = "";
			mCallback = null;
		}

	}
	
	// Update is called once per frame
	void Update () {

		if (messageAsked || questionAsked)
			playerController.LockMovementAndMouse (true);
		else
			playerController.LockMovementAndMouse (playerLockedMove, playerLockedLook);
		
	}

	public void LockPlayerMovement(bool doLockMove, bool doLockLook) {
		playerLockedMove = doLockMove;	
		playerLockedLook = doLockLook;
	}

	public void LockPlayerMovement(bool doLock) {
		playerLockedMove = doLock;	
		playerLockedLook = doLock;	
	}

	public void GoToAction(Action action, float delay) {

		switch (action.person) {
			case "player": playerController.GoToAction(action.action, delay); break;
			case "pierre": pierreController.GoToAction(action.action, delay); break;
			case "steve":  steveController.GoToAction(action.action, delay); break;
			case "mia":    miaController.GoToAction(action.action, delay); break;
			case "john":   johnController.GoToAction(action.action, delay); break;
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

	public void askQuestion(string question, List<string> answers, List<Action> callbacks, List<int> scores, bool bigAnswers) {
		
		if (answers.Count == callbacks.Count && answers.Count == scores.Count) {
			qQuestion = question;
			qAnswers = answers;
			qCallbacks = callbacks;
			qScores = scores;
			qBigAnswers = bigAnswers;
			questionAsked = true;
			
		}
		
	}

	public void askQuestion(string question, List<string> answers, List<Action> callbacks, List<int> scores) {

		askQuestion (question, answers, callbacks, scores, false);

	}

	public void showMessage(string message, Action callback) {

			mMessage = message;
			mCallback = callback;
			messageAsked = true;
		
	}

	public int Score {
		get { return score; }
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
