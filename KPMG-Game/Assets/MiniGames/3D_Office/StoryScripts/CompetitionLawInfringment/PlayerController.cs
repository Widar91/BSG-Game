using UnityEngine;
using System.Collections;
using System.Collections.Generic;
[RequireComponent (typeof (CharacterMotor))]

public class PlayerController : PersonController {

	private bool sitStandToggle = true;

	protected override void Start() {
		base.Start ();
		storyName = "player";
	}

	// ------------ Movement Locking Function ---------------

	public void LockMovementAndMouse(bool doLock) {
			LockMovementAndMouse (doLock, doLock);
	}

	public void LockMovementAndMouse(bool doLockMove, bool doLockLook) {

		CharacterController wasd = this.GetComponent<CharacterController>();	
		wasd.enabled = !doLockMove;

		MouseLook mouseLookX = this.GetComponent<MouseLook>();
		mouseLookX.enabled = !doLockLook;	
		MouseLook mouseLookY = Camera.main.GetComponent<MouseLook> ();
		mouseLookY.enabled = !doLockLook;

	}

	private void ToggleSitStand() {
		float yTransf = 0.7f;
		if (sitStandToggle)
			yTransf *= -1;
		Camera.main.transform.Translate(0f, yTransf, 0f);
		sitStandToggle = !sitStandToggle;
	}
	
	// ------------ Actions ---------------

	// Let the player read a message
	public void Action0() {

		string message = @"You are an KPMG employee that is about to have a meeting with a company called CleanIt. As part of the CleanIt team, you are asked to attend the meeting. Two KPMG colleagues are joining you: Pierre, the engagement partner; and Mia, an advisor. Steve and John will attend the meeting as representatives of CleanIt. 

Go and meet with Pierre.";


		storyController.showMessage(message, new Action("pierre", 1));
	}

	// Seats the player
	public void Action1() {

		List<Vector3> waypoints = new List<Vector3> () {	
			new Vector3(2.020578f, 0f, -50.56942f),
			new Vector3(1.768536f, 0f, -39.07871f),
			new Vector3(4.712274f, 0f, -35.89474f)
		};													
		WalkWaypoints (waypoints, "Action2");
		
	}
	
	public void Action2() {

		ToggleSitStand ();
		storyController.LockPlayerMovement (true, false);	

	}

	public void Action3() {
		
		ToggleSitStand ();
		storyController.LockPlayerMovement (false, false);	
		
	}

	public void Action4() {

		string message = "This is the end of the situation simulation. You will now receive four questions reagarding the situation that you justed experienced.";
		storyController.showMessage ("Einde training", new Action ("player", 5));

	}



	public void Action5() {

		string question = "Pierre left the office during the meeting. What will you do about this?";
		List<string> answers = new List<string> ()
		{
			"Confront Pierre about this",
			"Report to the engagement partner (Pierre)",
			"Report Pierre to the risk management partner",
			"Report Pierre to the senior partner",
			"Nothing, the call must have been important"
		};
		List<Action> callbacks = new List<Action> ()
		{
			new Action("player", 6),
			new Action("player", 6),
			new Action("player", 6),
			new Action("player", 6),
			new Action("player", 6)
		};
		List<int> scores = new List<int> ()
		{
			5,
			0,
			0,
			0,
			25
		};
		
		storyController.askQuestion (question, answers, callbacks, scores);

	}

	public void Action6() {
		
		string question = "Pierre was giving stock information to someone on the phone when he was out of the meeting. What will you do about this?";
		List<string> answers = new List<string> ()
		{
			"Report to the engagement partner (Pierre)",
			"Report Pierre to the risk management partner",
			"Report Pierre to the senior partner",
			"Nothing, it was probably unrelated information"
		};
		List<Action> callbacks = new List<Action> ()
		{
			new Action("player", 7),
			new Action("player", 7),
			new Action("player", 7),
			new Action("player", 7)
		};
		List<int> scores = new List<int> ()
		{
			0,
			25,
			0,
			0
		};
		
		storyController.askQuestion (question, answers, callbacks, scores);
		
	}

	public void Action7() {
		
		string question = "Someone in CleanIt went to the super bowl with a client. What will you do with this information?";
		List<string> answers = new List<string> ()
		{
			"Report to the engagement partner (Pierre)",
			"Report Pierre to the risk management partner",
			"Report Pierre to the senior partner",
			"Nothing, it was probably an innocent gift	"
		};
		List<Action> callbacks = new List<Action> ()
		{
			new Action("player", 8),
			new Action("player", 8),
			new Action("player", 8),
			new Action("player", 8)
		};
		List<int> scores = new List<int> ()
		{
			0,
			0,
			0,
			25
		};
		
		storyController.askQuestion (question, answers, callbacks, scores);
		
	}

	public void Action8() {
		
		string question = "CleanIt is not going to bid on the new contract because TRID is going to. What will you do with this information?";
		List<string> answers = new List<string> ()
		{
			"Report to the engagement partner (Pierre)",
			"Report Pierre to the risk management partner",
			"Report Pierre to the senior partner",
			"Nothing, the companies just respect each other"
		};
		List<Action> callbacks = new List<Action> ()
		{
			new Action("player", 98),
			new Action("player", 98),
			new Action("player", 98),
			new Action("player", 98)
		};
		List<int> scores = new List<int> ()
		{
			25,
			0,
			0,
			0
		};
		
		storyController.askQuestion (question, answers, callbacks, scores);
		
	}




	public void Action98() {
		storyController.showMessage("End of training. Your score is: " + storyController.Score, new Action("player", 99));
	}

	public void Action99() {
		Application.LoadLevel("Office");
	}

	
}
