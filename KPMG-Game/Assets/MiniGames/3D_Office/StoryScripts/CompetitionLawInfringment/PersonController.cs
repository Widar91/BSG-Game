using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class PersonController : MonoBehaviour {

	// Story Tracking variables
	protected StoryController storyController;
	protected string storyName = "";
	protected string currentCollideCallback = "";
	
	// Movement variables
	protected Vector3 targetPoint = Vector3.zero;
	protected float 	moveSpeed = 5f;
	
	protected int wpTarget = -1;
	protected List<Vector3> wpWaypoints;
	protected string wpCallback;
		
	protected virtual void Start() {
		
		// get the game controller
		GameObject CLI = GameObject.Find ("CompetitionLawInfringeMent");
		storyController = CLI.GetComponent<StoryController> ();
		
	}
	
	protected void Update() {
		
		// waypoint reached detector
		if (wpWaypoints != null && wpTarget > -1 && wpTarget < wpWaypoints.Count) {
			if (Vector3.Distance (wpWaypoints [wpTarget], Position) < 1f)
				NextWaypoint ();
			else
			moveToPoint(wpWaypoints[wpTarget]);
		}

		// movement
		if (targetPoint != Vector3.zero && Vector3.Distance(targetPoint, Position) >= 1f) {
			Vector3 targetDirection = targetPoint - Position;
			Quaternion targetRotation = Quaternion.LookRotation(new Vector3(targetDirection.x, 0, targetDirection.z));
			transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, Time.deltaTime * moveSpeed);
			transform.position = Vector3.MoveTowards (transform.position, targetPoint, Time.deltaTime * moveSpeed);
		}
		
	}
	
	protected void OnGUI() {
		
		
		
	}

	// ------------ Movement Functions ---------------
	
	protected void moveToPoint(Vector3 target) {
		target.y = this.transform.localPosition.y;
		targetPoint = target;
	}
	
	protected void WalkWaypoints (List<Vector3> waypoints, string callback) {
		wpTarget = 0;
		wpWaypoints = waypoints;
		wpCallback = callback;
	}
	
	protected void NextWaypoint() {
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

	protected Vector3 Position {
		get {
				Vector3 temp = transform.position;
				temp.y = 0f;
				return temp;
			}
	}
	
	// ------------ Actions Functions ---------------
	
	public void GoToAction(int action, float delay) {
		Invoke ("Action" + action, delay);
	}

	public void GoToAction(int action) {
		GoToAction (action, 0f);
	}

	protected void GoToAction(Action action, float delay) {
		storyController.GoToAction(action, delay);		
	}

	protected void GoToAction(Action action) {
		GoToAction(action, 0f);		
	}

	protected void GoToAction(string person, int action, float delay) {
		GoToAction(new Action (person, action), delay);
	}

	protected void GoToAction(string person, int action) {
		GoToAction(new Action (person, action), 0f);
	}

}
