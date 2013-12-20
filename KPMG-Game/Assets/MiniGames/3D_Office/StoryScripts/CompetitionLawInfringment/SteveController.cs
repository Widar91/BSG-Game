using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class SteveController : MonoBehaviour {
	
	// Story Tracking variables
	private StoryController storyController;
	private int currentAction = 0;
	
	// Movement variables
	Vector3 targetPoint = Vector3.zero;
	float 	moveSpeed = 6f;
	
	private int wpTarget = -1;
	private List<Vector3> wpWaypoints;
	private string wpCallback;

	// Audio variables
	public AudioClip HiHowAreYouDoing;
	public AudioClip LetsDoTheMeeting;
	public AudioClip MaybeYouShouldGoHome;
	
	void Start() {
		
		// get the game controller
		GameObject CLI = GameObject.Find ("CompetitionLawInfringeMent");
		storyController = CLI.GetComponent<StoryController> ();
		
	}
	
	void Update() {
		
		// waypoint reached detector
		if (wpWaypoints != null && wpTarget > -1 && wpTarget < wpWaypoints.Count) {
			if (Vector3.Distance (wpWaypoints [wpTarget], transform.position) < 1f)
				NextWaypoint ();
			moveToPoint(wpWaypoints[wpTarget]);
		}
		
		// movement
		if (targetPoint != Vector3.zero) {
			Vector3 targetDirection = targetPoint - transform.position;
			Quaternion targetRotation = Quaternion.LookRotation(new Vector3(targetDirection.x, 0, targetDirection.z));
			transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, Time.deltaTime * moveSpeed);
			transform.position = Vector3.MoveTowards (transform.position, targetPoint, Time.deltaTime * moveSpeed);
		}
		
		
	}
	
	void OnGUI() {
		
		
		
	}
	
	// ------------ Movement Functions ---------------
	
	void moveToPoint(Vector3 target) {
		target.y = this.transform.localPosition.y;
		targetPoint = target;
	}
	
	void WalkWaypoints (List<Vector3> waypoints, string callback) {
		wpTarget = 0;
		wpWaypoints = waypoints;
		wpCallback = callback;
	}
	
	void NextWaypoint() {
		if (wpWaypoints != null && wpTarget + 1 < wpWaypoints.Count) {
			wpTarget++;
		} else {
			wpWaypoints = null;
			wpTarget = -1;
			if (!wpCallback.Equals(""))
				Invoke (wpCallback, 0f);
			wpCallback = "";
		}
	}
	
	// ------------ Actions Functions ---------------
	
	void ActionReady() {
		storyController.ActionReady("player", currentAction);
	}
	
	public int NextAction() {
		currentAction++;
		Invoke ("Action" + currentAction, 0f);
		return currentAction;
	}
	
	public int GoToAction(int action) {
		currentAction = action;
		Invoke ("Action" + action, 0f);
		return currentAction;
	}
	
	// ------------ Actions ---------------
	
	// Put pierre in the office and tell the player to go meet
	public void Action1() {
		
		this.audio.PlayOneShot (HiHowAreYouDoing);
		Invoke ("ActionReady", 3f);
		
	}
	
	public void Action2() {

		string question = "How are you doing?";
		List<string> answers = new List<string> ()
		{
			"Fine, thank you how are you doing?",
			"I'm oke, could be better"
		};
		List<Action> callbacks = new List<Action> ()
		{
			new Action("steve", 3),
			new Action("steve", 4)
		};

		storyController.askQuestion (question, answers, callbacks);

	}

	public void Action3() {
		
		this.audio.PlayOneShot (LetsDoTheMeeting);
		Invoke ("Action5", 4f);
		
	}

	public void Action4() {
		
		this.audio.PlayOneShot (MaybeYouShouldGoHome);
		Invoke ("Action5", 4f);
		
	}
	
	public void Action5() {
		
		//TODO: show scores; for now: close the training
		Application.LoadLevel("Office");
		
	}
	
	
}