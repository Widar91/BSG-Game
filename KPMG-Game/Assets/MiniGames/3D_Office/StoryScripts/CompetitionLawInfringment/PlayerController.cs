using UnityEngine;
using System.Collections;
using System.Collections.Generic;
[RequireComponent (typeof (CharacterMotor))]

public class PlayerController : PersonController {
		
	protected override void Start() {
		base.Start ();
		storyName = "player";
	}

	// ------------ Movement Locking Function ---------------
	
	public void LockMovementAndMouse(bool doLock) {

		CharacterController wasd = this.GetComponent<CharacterController>();	
		wasd.enabled = !doLock;

		MouseLook mouseLookX = this.GetComponent<MouseLook>();
		mouseLookX.enabled = !doLock;	
		MouseLook mouseLookY = Camera.main.GetComponent<MouseLook> ();
		mouseLookY.enabled = !doLock;

	}
	
	// ------------ Actions ---------------

	// Let the player read a message
	public void Action0() {
		storyController.showMessage("Hallo blablabla", new Action("pierre", 1));
	}

	// Seats the player
	public void Action1() {

		List<Vector3> waypoints = new List<Vector3> () {	
			new Vector3(2.020578f, 0f, -50.56942f),
			new Vector3(1.768536f, 0f, -39.07871f),
			new Vector3(3.712274f, 0f, -36.39474f)
		};													
		WalkWaypoints (waypoints, "Action2");
		
	}

	// Let the player look at steve and have him start his talk
	public void Action2() {

		GameObject tv = GameObject.FindGameObjectWithTag ("BoardRoomTV");
		Camera.main.transform.LookAt (tv.transform);
		storyController.LockPlayerMovement (true);	

		GoToAction ("steve", 1);
	}

	
}
