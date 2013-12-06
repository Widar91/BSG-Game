using UnityEngine;
using System.Collections;

public class Trophy : MonoBehaviour {

	GUITextBehaviour gui;
	TrophyManager trophyManager;
	
	// Use this for initialization
	void Start () {
		GameObject ogo = GameObject.Find ("GUI Text");
		gui = ogo.GetComponent<GUITextBehaviour> ();

		ogo = GameObject.Find ("Deamon");
		trophyManager = ogo.GetComponent<TrophyManager> ();
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnMouseDown()
	{
		trophyManager.createAnother ();

	}
}
