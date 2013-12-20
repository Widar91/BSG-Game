using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class TrophyManager : MonoBehaviour {

	//public int trophiesPerRow = 14;
	public float distanceBetweenTrophies = 2.7f;
	//public GameObject defaultModel;
	public Vector3 startingPosition;
	public int showCount = 0;

	public GameObject deamon = null;
	public GameObject devgui = null;


	public class OfficeTrophy : Item
	{
		public OfficeTrophy(Vector3 position)
			: base("TrophyCup", position, 0.01f)
		{
		}
	}

	
	GUITextBehaviour gui;
	OfficeObjectManager manager;
	//GameObject lastTrophy = null;
	
	// Use this for initialization
	void Start () {
		//GameObject ogo = GameObject.Find ("GUI Text");
		gui = devgui.GetComponent<GUITextBehaviour> ();

		//GameObject deamon = GameObject.Find ("Deamon");
		manager = deamon.GetComponent<OfficeObjectManager> ();

		//lastTrophy = GameObject.Find ("TrophyCup");

		this.displayTrophies (showCount);
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void displayTrophies(IEnumerable<OfficeTrophy> trophies)
	{
		manager.LoadItems (trophies);
	}

	public void displayTrophies(int count)
	{
		Vector3 pos = startingPosition;
		ICollection<OfficeTrophy> trophies = new List<OfficeTrophy>();
		for (int i=0; i<count; i++) 
		{
			OfficeTrophy trophy = new OfficeTrophy(pos);
			trophies.Add(trophy);
			pos.x += distanceBetweenTrophies;
		}
		displayTrophies (trophies);
	}

	public void createAnother()
	{
//		Vector3 newpos = lastTrophy.transform.position;
//		newpos.x += 0.27f;
//		lastTrophy = (GameObject) GameObject.Instantiate(lastTrophy, newpos, lastTrophy.transform.rotation);
	}
}
