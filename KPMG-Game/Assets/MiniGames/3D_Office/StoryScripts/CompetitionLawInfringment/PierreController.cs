using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class PierreController : MonoBehaviour {

	// Story Tracking variables
	private StoryController storyController;
	private int currentAction = 0;

	// Movement variables
	Vector3 targetPoint = Vector3.zero;
	float 	moveSpeed = 5f;

	private int wpTarget = -1;
	private List<Vector3> wpWaypoints;
	private string wpCallback;

	// Audio variables
	public AudioClip IntroSpeech;
	public AudioClip TakeASeat;

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

	// ------------ Trigger Functions ---------------

	void OnTriggerEnter(Collider col) {

		if (currentAction == 1)
			ActionReady ();

		if (currentAction == 4)
			ActionReady ();

	}
	
	void OnTriggerExit(Collider col) {

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
		storyController.ActionReady("pierre", currentAction);
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

		this.transform.localPosition = new Vector3 (-10.39676f, 0.8675663f, -20.46594f);
		this.transform.localRotation = Quaternion.Euler(0f, -5.828735f, 0f);

		storyController.setObjective("Go and meet Pierre");

	}

	// Pierre says hi
	public void Action2() {

		//storyController.toggleCameraPosition ();

		storyController.setObjective("");
		this.audio.PlayOneShot (IntroSpeech);

		Invoke ("ActionReady", 17f);

	}

	// Pierre moonwalks to the board room awkwardly
	public void Action3() {

		storyController.setObjective("Follow Pierre to the meeting in the board room");

		List<Vector3> waypoints = new List<Vector3> () {	
			new Vector3 (-10.76238f, 0f, -41.02417f),
			new Vector3(-0.8059567f, 0f, -52.51234f),
			new Vector3(8.253447f, 0f, -50.91179f)
		};													
		WalkWaypoints (waypoints, "ActionReady");

	}

	// Pierre waits for the player in the board room
	public void Action4() {

		storyController.setObjective("Meet with Pierre in the board room");

		// the wait for the player to reach Pierre

	}

	// Pierre demands that the player will sit down
	public void Action5() {

		this.audio.PlayOneShot (TakeASeat);
		Invoke ("ActionReady", 3f );

	}

	public void Action6() {

	}

}
