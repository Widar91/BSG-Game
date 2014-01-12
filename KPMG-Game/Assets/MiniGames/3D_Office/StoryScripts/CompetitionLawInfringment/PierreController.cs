using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class PierreController : PersonController {

	// Audio variables
	public AudioClip pierre1; // hi, are you ready for the meeting
	public AudioClip pierre2; // please take a seat
	public AudioClip pierre3; // okay, let's start
	public AudioClip pierre4; // *phone rings* I have to take this
	public AudioClip pierre5; // pierre on the phone talking stock
	public AudioClip pierre6; // oh hi, let's go back to the meeting
	public AudioClip pierre7; // i'm sorry for that, let's resume
	public AudioClip pierre8; // okay, i'll walk you out

	protected override void Start() {
		base.Start ();
		storyName = "pierre";
		isAnimated = true;

		Stand ();
	}

	// ------------ Actions ---------------
	
	// Tell the player to go meet Pierre and wait for him/her to do so
	public void Action1() {

		// set the objective to meet and wait for that to happen
		storyController.setObjective("Go and meet Pierre");
		currentCollideCallback = "Action2";

	}

	// Pierre says hi
	public void Action2() {

		currentCollideCallback = "";

		storyController.setObjective("");
		this.audio.PlayOneShot (pierre1);

		GoToAction (3, 8f);

	}

	// Pierre walks to the board room
	public void Action3() {

		currentCollideCallback = "";

		storyController.setObjective("Follow Pierre to the meeting in the board room");

		List<Vector3> waypoints = new List<Vector3> () {	
			new Vector3 (-10.76238f, 0f, -41.02417f),
			new Vector3(-0.8059567f, 0f, -52.51234f),
			new Vector3(10.253447f, 0f, -50.91179f),
			new Vector3(7.253447f, 0f, -50.91179f)
		};													
		WalkWaypoints (waypoints, "Action4");

	}

	// Pierre waits for the player in the board room
	public void Action4() {

		storyController.setObjective("Meet with Pierre in the board room");

		// then wait for the player to reach Pierre
		currentCollideCallback = "Action5";

	}

	// Pierre demands that the player will sit down
	public void Action5() {

		currentCollideCallback = "";

		this.audio.PlayOneShot (pierre2);
		GoToAction ("player", 1, 2f);
		GoToAction (6, 2f);

	}

	// Walk up to the front of the meeting room
	public void Action6() {

		List<Vector3> waypoints = new List<Vector3> () {	
			new Vector3 (10.64957f, 0f, -46.82451f),
			new Vector3(10.31618f, 0f, -33.39981f),
			new Vector3(6.579431f, 0f, -32.89644f),
			new Vector3(6.579431f, 0f, -35.46146f)
		};													
		WalkWaypoints (waypoints, "Action7");

	}

	// Just pause for a moment
	public void Action7() {
		GoToAction (8, 1f);
	}

	// Pierre starts the meeting and asks steve to begin	
	public void Action8() {
			
		this.audio.PlayOneShot (pierre3);
		GoToAction ("steve", 1, 5.5f);

	}

	// Pierre's phone rings and he leaves the meeting to take the call
	public void Action9() {
		
		this.audio.PlayOneShot (pierre4);
		GoToAction (10, 9f);
		GoToAction ("john", 1, 12f);
		
	}

	// Steve leaves the room to take his phone call
	public void Action10() {
		List<Vector3> waypoints = new List<Vector3> () {
			
			new Vector3(6.579431f, 0f, -35.46146f),
			new Vector3(6.579431f, 0f, -32.89644f),
			new Vector3(10.31618f, 0f, -33.39981f),
			new Vector3(10.64957f, 0f, -46.82451f),
			new Vector3(7.253447f, 0f, -50.91179f),
			new Vector3(-0.8059567f, 0f, -52.51234f),
			new Vector3(-0.8059567f, 0f, -52.51234f),
			new Vector3 (-10.76238f, 0f, -41.02417f)
		};	
		WalkWaypoints (waypoints, "");
	}


	public void Action11() {

		// wait for the player to reach Pierre
		storyController.setObjective ("Go to Pierre");
		currentCollideCallback = "Action12";

	}

	public void Action12() {

		// stop all the colliding part
		storyController.setObjective ("");
		currentCollideCallback = "";

		storyController.LockPlayerMovement (true, false);

		this.audio.PlayOneShot (pierre5);
		GoToAction (13, 13f);

	}

	public void Action13() {


		this.transform.Rotate (0f, 180f, 0f);
		this.audio.PlayOneShot (pierre6);
		GoToAction (14, 4f);


	}

	public void Action14() {

		GoToAction (15, 4f);

		List<Vector3> waypoints = new List<Vector3> () {
			new Vector3 (-10.76238f, 0f, -41.02417f),
			new Vector3(-0.8059567f, 0f, -52.51234f),
			new Vector3(-0.8059567f, 0f, -52.51234f),
			new Vector3(7.253447f, 0f, -50.91179f),
			new Vector3(10.64957f, 0f, -46.82451f),
			new Vector3(10.31618f, 0f, -33.39981f),
			new Vector3(6.579431f, 0f, -32.89644f),
			new Vector3(6.579431f, 0f, -35.46146f)
		};	
		WalkWaypoints (waypoints, "Action15");

	}

	public void Action15() {

		storyController.setObjective("Follow Pierre back into the meeting room");
		storyController.LockPlayerMovement (false);
		currentCollideCallback = "Action16";

	}

	public void Action16() {

		// stop all the colliding part
		storyController.setObjective ("");
		currentCollideCallback = "";

		this.audio.PlayOneShot (pierre7);
		GoToAction("steve", 4, 6f);

	}


	public void Action17() {

		this.audio.PlayOneShot (pierre8);
		GoToAction ("player", 4, 7f);

	}

}
