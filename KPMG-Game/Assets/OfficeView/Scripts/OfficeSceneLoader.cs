using UnityEngine;
using System.Collections;

public class OfficeSceneLoader : MonoBehaviour 
{
	
	public GameObject deamon;
	public GameObject OfficeParentObject = null;
	OfficeObjectManager manager = null;
	public Vector3 shift = new Vector3(0,0,0);


	public Item[] items = 
	{
		new Item("TableSimple", 	new Vector3(-3.97f, 1.04f, -9.741f) , 	5),
		new Item("VintagePC", 		new Vector3(-9.50f, 0.29f, -10.24f), 	5),
		new Item("Lamp", 			new Vector3(-3.12f, 2.16f, -9.48f), 	1),
		new Item("Lamp", 			new Vector3(-7.38f, 1.93f, -10.92f), 	1),
		new Item("OfficeChair", 	new Vector3(-5.92f, 0.5f, -9.38f), 		1.3f),
		new Item("Carpet", 			new Vector3(-4.5f, 2.57f, -10.03f), 	1),
		new Item("LowTable", 		new Vector3(-0.25f, 3.85f, -14.7f), 	1),
		new Item("SofaChair01", 	new Vector3(-0.25f, 3.92f, -14.66f), 	1),
		new Item("Sofa01", 			new Vector3(1.26f, 0.51f, -8.74f), 		1.8f),
		new Item("OrangeSofa", 		new Vector3(-1.44f, 0.5f, -10.86f), 	1.2f),
		new Item("FloorLamp", 		new Vector3(-9.07f, 1.94f, -6.68f), 	2f),
		new Item("TrophyTable", 	new Vector3(-0.74f, 1.38f, -6.49f), 	5),
		new Item("GreenSofaChair", 	new Vector3(2.48f, 0.48f, -6.84f), 		1.3f),
	};

	// Use this for initialization
	void Start ()
	{
		if ( deamon==null ) 
			this.deamon = this.gameObject; // If no deamon supplied, assume this s the deamon

		manager = deamon.GetComponent<OfficeObjectManager> ();	
		//manager.LoadItems (items, shift);
		manager.LoadItems (items, shift, OfficeParentObject);
	}
	
	// Update is called once per frame
	void Update ()
	{
	
	}
}
