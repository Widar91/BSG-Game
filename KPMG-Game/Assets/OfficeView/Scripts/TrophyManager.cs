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
		public string label;
		public OfficeTrophy(Vector3 position, string inLabel = "This is not your trophy")
			: base("TrophyCup", position, 0.01f)
		{
			label = inLabel;
		}
	}	

	
	GUITextBehaviour gui;
	OfficeObjectManager manager;
	//GameObject lastTrophy = null;
	
	// Use this for initialization
	void Start () 
	{
		gui = devgui.GetComponent<GUITextBehaviour> ();
		manager = deamon.GetComponent<OfficeObjectManager> ();

		IEnumerable<string> trophies = ServerConnector.getInstance ().GetTrophies ();
		this.displayTrophies (trophies);
	}
	
	// Update is called once per frame
	void Update () 
	{
	
	}

	public void displayTrophies(IEnumerable<OfficeTrophy> trophies)
	{
		manager.LoadItems (trophies);
	}

	public void displayTrophies(IEnumerable<string> trophyNames)
	{
		Vector3 pos = startingPosition;
		ICollection<OfficeTrophy> trophies = new List<OfficeTrophy>();

		foreach ( string trophyName in trophyNames )
		//for (int i=0; i<count; i++) 
		{
			OfficeTrophy trophy = new OfficeTrophy(pos, trophyName);
			trophies.Add(trophy);
			pos.x += distanceBetweenTrophies;
		}
//		displayTrophies (trophies);
		foreach (OfficeTrophy trophy in trophies)
		{

			GameObject trophyGO = manager.CreateGameObject(trophy);
			TicklesBehaviour tick = trophyGO.GetComponent<TicklesBehaviour>();
			tick.tickleMessage = trophy.label;
			manager.PositionGameObject(trophy, trophyGO);
		}
	}
}
