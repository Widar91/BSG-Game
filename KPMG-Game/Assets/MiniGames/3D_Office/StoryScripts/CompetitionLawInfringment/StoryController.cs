using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class StoryController : MonoBehaviour {

	// Character variables
	private GameObject player;
	private PlayerController playerController;

	private GameObject pierre;
	private PierreController pierreController;

	private GameObject steve;
	private SteveController steveController;

	// Story tracking variables
	private List<Action> story;
	private string objective;
	private int currentAction;

	// Question variables
	private bool questionAsked = false;
	private string qQuestion;
	private List<string> qAnswers;
	private List<Action> qCallbacks;

	// Use this for initialization
	void Start () {

		objective = "";

		player = GameObject.FindGameObjectWithTag("Player");
		playerController = player.GetComponent<PlayerController> ();

		pierre = GameObject.Find ("Pierre");
		pierreController = pierre.GetComponent<PierreController> ();

		steve = GameObject.Find ("Steve");
		steveController = steve.GetComponent<SteveController> ();

		currentAction = -1;

		// Story
		story = new List<Action> () {
			new Action("pierre", 1),
			new Action("pierre", 2),
			new Action("pierre", 3),
			new Action("pierre", 4),
			new Action("pierre", 5),
			new Action("player", 1),
			new Action("player", 2),
			new Action("steve",  1),
			new Action("steve",  2)
		};

		ActionReady ("", 1);

	}

	void OnGUI() {

		// shows objective
		GUI.Label (new Rect (25, 25, 400, 25), objective);

		// shows question
		if (questionAsked)
			GUI.Window (0, new Rect (Screen.width/2-150, 100, Screen.width - 360, Screen.height - 250), leaderWindow, "Question");
		
	}

	//GUI Window Questions
	void leaderWindow (int windowID) {

			GUI.BeginGroup (new Rect (10, 50, Screen.width - 360, Screen.height - 250), "");
	
			//Titles
			GUI.Label (new Rect (0, 0, 500, 50), qQuestion);
			int top = 40;

			//Content
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
	
	// Update is called once per frame
	void Update () {
			
	}

	public void ActionReady(string controller, int action) {
		currentAction++;
		if (currentAction < story.Count)
			GoToAction (story[currentAction]);
	}

	private void GoToAction(Action action) {

		switch (action.person) {
			case "player": playerController.GoToAction(action.action); break;
			case "pierre": pierreController.GoToAction(action.action); break;
			case "steve":  steveController.GoToAction(action.action); break;
		}

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

	public void toggleCameraPosition() {
		//TODO
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
