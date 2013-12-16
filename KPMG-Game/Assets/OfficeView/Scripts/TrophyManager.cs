using UnityEngine;
using System.Collections;

public class TrophyManager : MonoBehaviour {

	public int trophiesPerRow = 14;
	public float distanceBetweenTrophies = 2.7f;
	public GameObject defaultModel;
	Vector3 startngPosition;

	public class OfficeTrophy
	{
		long type;
	}

	
	GUITextBehaviour gui;
	GameObject lastTrophy = null;
	
	// Use this for initialization
	void Start () {
		GameObject ogo = GameObject.Find ("GUI Text");
		gui = ogo.GetComponent<GUITextBehaviour> ();

		lastTrophy = GameObject.Find ("TrophyCup");
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void displayTrophies(OfficeTrophy[] trophies)
	{

	}

	public void createAnother()
	{
		Vector3 newpos = lastTrophy.transform.position;
		newpos.x += 0.27f;
		lastTrophy = (GameObject) GameObject.Instantiate(lastTrophy, newpos, lastTrophy.transform.rotation);
	}
}
