using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class SteveController : PersonController {

	// Audio variables
	public AudioClip HiHowAreYouDoing;
	public AudioClip LetsDoTheMeeting;
	public AudioClip MaybeYouShouldGoHome;

	protected override void Start() {
		base.Start ();
		storyName = "steve";
	}

	// ------------ Actions ---------------
	
	// Put pierre in the office and tell the player to go meet
	public void Action1() {
		
		this.audio.PlayOneShot (HiHowAreYouDoing);
		GoToAction(2, 3f);
		
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
		GoToAction (5, 4f);
		
	}

	public void Action4() {
		
		this.audio.PlayOneShot (MaybeYouShouldGoHome);
		GoToAction (5, 4f);
		
	}
	
	public void Action5() {
		
		//TODO: show scores; for now: close the training
		Application.LoadLevel("Office");
		
	}
	
	
}