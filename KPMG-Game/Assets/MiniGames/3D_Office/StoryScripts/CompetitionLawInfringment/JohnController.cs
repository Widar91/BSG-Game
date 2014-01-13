using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class JohnController : PersonController {

	// Audio variables
	public AudioClip john1;	// is everything alright?
	public AudioClip john2; // yes, go do that
	public AudioClip john3; // thank you, that would be great
	public AudioClip john4; // wow, I wish we had that kind of clients

	protected override void Start() {
		base.Start ();
		storyName = "john";
		
		Sit ();
	}
	
	// ------------ Actions ---------------
	
	// John asks the player if everything is alright after Pierre left
	public void Action1() {

		this.audio.PlayOneShot (john1);
		GoToAction(2, 2f);
		
	}

	// John waits for the player to answer his question
	public void Action2() {

		string question = "John: Is everything alright?";
		List<string> answers = new List<string> ()
		{
			@"I am afraid we will have to wait for a minute. I will go outside to 
see Pierre and find out when we can continue the meeting.",
			"I am very sorry, I’ll go get Pierre immediately."
		};
		List<Action> callbacks = new List<Action> ()
		{
			new Action("john", 3),
			new Action("john", 5)
		};
		List<int> scores = new List<int> ()
		{
			0,
			0
		};
		
		storyController.askQuestion (question, answers, callbacks, scores, true);

	}

	// John responds to answer a
	public void Action3() {
		GoToAction (4, 1f);
	}
	public void Action4() {
		this.audio.PlayOneShot (john2);
		GoToAction (7, 2f);
	}

	// John responds to answer b
	public void Action5() {
		GoToAction (6, 1f);
	}
	public void Action6() {
		this.audio.PlayOneShot (john3);
		GoToAction (7, 2f);
	}

	// start the conversation between Steve and John
	public void Action7() {
		storyController.showMessage("Get Pierre back into the meeting room", new Action("steve", 2));

		//set the pierre collider and objective
		GoToAction("pierre", 11);

		//unlock the player
		GoToAction ("player", 3);
	}


	public void Action8() {
		this.audio.PlayOneShot (john4);
		GoToAction ("steve", 3, 4f);
	}



}