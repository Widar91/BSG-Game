using UnityEngine;
using System.Collections;
using System.Collections.Generic;
[RequireComponent (typeof (CharacterMotor))]

public class PlayerController : MonoBehaviour {
	
	// Story Tracking variables
	private StoryController storyController;
	private int currentAction = 0;
	
	// Movement variables
	Vector3 targetPoint = Vector3.zero;
	float 	moveSpeed = 5f;
	
	private int wpTarget = -1;
	private List<Vector3> wpWaypoints;
	private string wpCallback;

	
	void Start() {
		
		// get the game controller
		GameObject CLI = GameObject.Find ("CompetitionLawInfringeMent");
		storyController = CLI.GetComponent<StoryController> ();
		
	}
	
	void Update() {

		// waypoint reached detector
		if (wpWaypoints != null && wpTarget > -1 && wpTarget < wpWaypoints.Count) {
			if (Vector3.Distance (wpWaypoints [wpTarget], transform.position) < 2f)
				NextWaypoint ();
			moveToPoint(wpWaypoints[wpTarget]);
		}
		
		// movement
		if (targetPoint != Vector3.zero) {
			Vector3 targetDirection = targetPoint - transform.position;
			if (!targetDirection.Equals(Vector3.zero)) {
				Quaternion targetRotation = Quaternion.LookRotation(new Vector3(targetDirection.x, 0, targetDirection.z));
				transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, Time.deltaTime * moveSpeed);
			}
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

	public void LockMovementAndMouse(bool doLock) {
		CharacterController wasd = this.GetComponent<CharacterController>();	
		wasd.enabled = false;
		MouseLook mouseLookX = this.GetComponent<MouseLook>();
		mouseLookX.enabled = false;	
		MouseLook mouseLookY = Camera.main.GetComponent<MouseLook> ();
		mouseLookY.enabled = false;
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

		List<Vector3> waypoints = new List<Vector3> () {	
			new Vector3(2.020578f, 0f, -50.56942f),
			new Vector3(1.768536f, 0f, -39.07871f),
			new Vector3(3.712274f, 0f, -36.39474f)
		};													
		WalkWaypoints (waypoints, "ActionReady");
		
	}
	
	public void Action2() {

		GameObject tv = GameObject.FindGameObjectWithTag ("BoardRoomTV");
		Camera.main.transform.LookAt (tv.transform);
		LockMovementAndMouse (true);	

		ActionReady ();
	}

	
}
