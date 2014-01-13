using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class SteveController : PersonController {

	// Audio variables
	public AudioClip steve1; // steve talks about CleanIt
	public AudioClip steve2; // did you hear about Dina and the superbowl
	public AudioClip steve3; // how was the birthday yesterday
	public AudioClip steve4; // we will not bid on the new contract

	protected override void Start() {
		base.Start ();
		storyName = "steve";

		Sit ();
	}

	// ------------ Actions ---------------
	
	// 
	public void Action1() {
		
		this.audio.PlayOneShot (steve1);
		GoToAction("pierre", 9, 15f);
		
	}
	
	public void Action2() {
		
		this.audio.PlayOneShot (steve2);
		GoToAction ("john", 8, 11f);
		
	} 

	public void Action3() {
		
		this.audio.PlayOneShot (steve3);
		//do nothing
		
	} 
	
	public void Action4() {
		
		this.audio.PlayOneShot (steve4);
		GoToAction ("pierre", 17, 20f);

	}
	
	
}