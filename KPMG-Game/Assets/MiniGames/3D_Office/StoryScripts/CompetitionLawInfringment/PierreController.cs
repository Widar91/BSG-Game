using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class PierreController : PersonController {

	// Audio variables
	public AudioClip IntroSpeech;
	public AudioClip TakeASeat;

	protected override void Start() {
		base.Start ();
		storyName = "pierre";
	}

	// ------------ Trigger Functions ---------------

	void OnTriggerEnter(Collider col) {

		if (!currentCollideCallback.Equals(""))
			Invoke (currentCollideCallback, 0f);

	}
	
	void OnTriggerExit(Collider col) {

	}

	// ------------ Actions ---------------
	
	// Put pierre in the office and tell the player to go meet
	public void Action1() {

		this.transform.localPosition = new Vector3 (-10.39676f, 0.8675663f, -20.46594f);
		this.transform.localRotation = Quaternion.Euler(0f, -5.828735f, 0f);

		storyController.setObjective("Go and meet Pierre");

		currentCollideCallback = "Action3";

	}

	// Pierre says hi
	public void Action2() {

		currentCollideCallback = "";

		storyController.setObjective("");
		this.audio.PlayOneShot (IntroSpeech);

		GoToAction (3, 17f);

	}

	// Pierre moonwalks to the board room awkwardly
	public void Action3() {

		currentCollideCallback = "";

		storyController.setObjective("Follow Pierre to the meeting in the board room");

		List<Vector3> waypoints = new List<Vector3> () {	
			new Vector3 (-10.76238f, 0f, -41.02417f),
			new Vector3(-0.8059567f, 0f, -52.51234f),
			new Vector3(9.253447f, 0f, -50.91179f),
			new Vector3(7.253447f, 0f, -50.91179f)
		};													
		WalkWaypoints (waypoints, "Action4");

	}

	// Pierre waits for the player in the board room
	public void Action4() {

		storyController.setObjective("Meet with Pierre in the board room");

		// the wait for the player to reach Pierre
		currentCollideCallback = "Action5";

	}

	// Pierre demands that the player will sit down
	public void Action5() {

		currentCollideCallback = "";

		this.audio.PlayOneShot (TakeASeat);
		GoToAction ("player", 1, 3f);

	}

	public void Action6() {

	}

}
