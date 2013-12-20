using UnityEngine;
using System.Collections;

public class MinigameStarter : MonoBehaviour {

	// The minigame to start
	public string Minigame = "";
	
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	void OnMouseDown()
	{
		Application.LoadLevel (Minigame);
	}
}
