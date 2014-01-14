﻿using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

public class OfficeSceneLoader : MonoBehaviour 
{
	
	public GameObject deamon;
	public GameObject OfficeParentObject = null;
	OfficeObjectManager manager = null;
	public Vector3 shift = new Vector3(0,0,0);

	public ICollection<GameObject> loadedGameObjects = new List<GameObject> ();
	public IDictionary<int, string> objects = new Dictionary<int, string>
	{
		{1, "TableSimple"}
	};
	public IDictionary<string, Item> singletons = new Dictionary<string, Item>
	{
		{"TableSimple", 	new Item("TableSimple", 	new Vector3(-3.97f, 1.04f, -9.741f) , 	5)},
		{"VintagePC", 		new Item("VintagePC", 		new Vector3(-9.50f, 0.29f, -10.24f), 	5)},
		{"Lamp1", 			new Item("Lamp", 			new Vector3(-3.12f, 2.16f, -9.48f), 	1)},
		{"Lamp2", 			new Item("Lamp", 			new Vector3(-7.38f, 1.93f, -10.92f), 	1)},
		{"OfficeChair", 	new Item("OfficeChair", 	new Vector3(-5.92f, 0.5f , -9.38f), 	1.3f)},
		{"Carpet", 			new Item("Carpet", 			new Vector3(-4.5f , 2.57f, -10.03f), 	1)},
		{"LowTable", 		new Item("LowTable", 		new Vector3(-0.25f, 3.85f, -14.7f), 	1)},
		{"SofaChair01", 	new Item("SofaChair01", 	new Vector3(-0.25f, 3.92f, -14.66f), 	1)},
		{"Sofa01", 			new Item("Sofa01", 			new Vector3(1.26f , 0.51f, -8.74f), 	1.8f)},
		{"OrangeSofa", 		new Item("OrangeSofa", 		new Vector3(-1.44f, 0.5f , -10.86f), 	1.2f)},
		{"FloorLamp", 		new Item("FloorLamp", 		new Vector3(-9.07f, 1.94f, -6.68f), 	2f)},
		{"TrophyTable", 	new Item("TrophyTable", 	new Vector3(-0.74f, 1.38f, -6.49f), 	5)},
		{"GreenSofaChair", 	new Item("GreenSofaChair", 	new Vector3(2.48f , 0.48f, -6.84f), 	1.3f)},
	};

	/// <summary>
	/// A basic setup for the office, mocked
	/// </summary>
	public Item[] defaultScene = 
	{
		new Item("TableSimple", 	new Vector3(-3.97f, 1.04f, -9.741f) , 	5),
		new Item("VintagePC", 		new Vector3(-9.50f, 0.29f, -10.24f), 	5),
		new Item("Lamp", 			new Vector3(-3.12f, 2.16f, -9.48f), 	1),
		new Item("Lamp", 			new Vector3(-7.38f, 1.93f, -10.92f), 	1),
		new Item("OfficeChair", 	new Vector3(-5.92f, 0.5f, -9.38f), 		1.3f),
		new Item("Carpet", 			new Vector3(-4.5f , 2.57f, -10.03f), 	1),
		new Item("LowTable", 		new Vector3(-0.25f, 3.85f, -14.7f), 	1),
		new Item("SofaChair01", 	new Vector3(-0.25f, 3.92f, -14.66f), 	1),
		new Item("Sofa01", 			new Vector3(1.26f , 0.51f, -8.74f), 	1.8f),
		new Item("OrangeSofa", 		new Vector3(-1.44f, 0.5f, -10.86f), 	1.2f),
		new Item("FloorLamp", 		new Vector3(-9.07f, 1.94f, -6.68f), 	2f),
		new Item("TrophyTable", 	new Vector3(-0.74f, 1.38f, -6.49f), 	5),
		new Item("GreenSofaChair", 	new Vector3(2.48f , 0.48f, -6.84f), 	1.3f),
	};

	// Use this for initialization
	void Start ()
	{
		if ( deamon==null ) 
			this.deamon = this.gameObject; // If no deamon supplied, assume this is the deamon
		manager = deamon.GetComponent<OfficeObjectManager> ();	

		this.ReloadScene ();
	}
	
	// Update is called once per frame
	void Update ()
	{
	
	}

	/// <summary>
	/// Destroys all the previously loaded objects and loads them again from the server
	/// </summary>
	public void ReloadScene()
	{
		// Unload
		this.UnloadScene ();

		// Reload
		IEnumerable<Item> items = this.DesignScene ();
		this.loadedGameObjects = new List<GameObject>(manager.LoadItems (items, shift, OfficeParentObject));
	}

	/// <summary>
	/// Destroys all the previously GameObjects
	/// </summary>
	public void UnloadScene()
	{
		foreach ( GameObject go in this.loadedGameObjects )
		{
			UnityEngine.Object.Destroy(go);
		}
	}

	/// <summary>
	/// Removes the object from the server and the scene.
	/// </summary>
	/// <param name="objectname">Te object to be removed.</param>
	/// <param name="reload">If set to <c>true</c> reload to show the changes.</param>
	public void RemoveObject(string objectname, bool reload = true)
	{
		// Remove from server
		ServerConnector.getInstance ().RemoveOfficeObject (objectname);

		// Reload scene from server;
		if ( reload )
			this.ReloadScene ();
	}

	/// <summary>
	/// Updates the server and the scene with a new object
	/// </summary>
	/// <param name="objectname">The object to be reloaded.</param>
	/// <param name="reload">If set to <c>true</c> reload the scene to show changes.</param>
	public void AddObject(string objectname, bool reload = true)
	{
		// Add to server
		ServerConnector.getInstance ().AddOfficeObject (objectname);

		// Reload scene from server
		if (reload)
			this.ReloadScene ();
	}

	/// <summary>
	/// Designs the scene.
	/// </summary>
	/// <returns>The scene.</returns>
	public IEnumerable<Item> DesignScene()
	{
		return this.defaultScene; // TODO remove mocked scene

		ICollection<Item> items = new List<Item> ();

		// Get scene from server
		IList<string> objectnames = ServerConnector.getInstance ().GetOfficeObjects ();

		// If scene is empty, load default scene
		if (objectnames.Count == 0) {
			Debug.Log("Scene from server was empty. Loading default scene");
			foreach ( Item item in this.defaultScene )
				this.AddObject(item.resource, false);
			return this.defaultScene;
		}

		// Load scene
		foreach (string objectname in objectnames)
		{
			items.Add(this.singletons[objectname]);
		}

		return items;
	}
}
