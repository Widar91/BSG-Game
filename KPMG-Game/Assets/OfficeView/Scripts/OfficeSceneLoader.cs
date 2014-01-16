using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

public class OfficeSceneLoader : MonoBehaviour 
{
	public bool GoingLive = false;
	
	public bool Interactive = true;
	
	public GameObject deamon;
	public GameObject OfficeParentObject;
	public OfficeObjectManager manager;
	public Vector3 shift = new Vector3(0,0,0);

	public static ICollection<GameObject> loadedGameObjects = new List<GameObject>();
	public static ICollection<String>     loadedObjectNames = new List<string>();

	public static IDictionary<int, string> objects = new Dictionary<int, string>
	{
		{1, "VintagePC"},
		{2, "Lamp1"},
		{3, "Lamp2"},
		{4, "Sofa01"},
		{5, "OrangeSofa"},

	};

	public static IDictionary<string, Item> singletons = new Dictionary<string, Item>
	{
		{"TableSimple", 		new Item("TableSimple", 		new Vector3(-3.97f, 1.04f, -9.741f), 	5)},
		{"TableSimple_Dead", 	new Item("TableSimple_Dead", 	new Vector3(-3.97f, 1.04f, -9.741f), 	5)},
		{"VintagePC", 			new Item("VintagePC", 			new Vector3(-9.50f, 0.29f, -10.24f), 	5)},
		{"Lamp1", 				new Item("Lamp", 				new Vector3(-3.12f, 2.16f, -9.48f) , 	1)},
		{"Lamp2", 				new Item("Lamp", 				new Vector3(-7.38f, 1.93f, -10.92f), 	1)},
		{"OfficeChair", 		new Item("OfficeChair", 		new Vector3(-5.92f, 0.5f , -9.38f) , 	1.3f)},
		{"Carpet", 				new Item("Carpet", 				new Vector3(-4.5f , 2.57f, -10.03f), 	1)},
		{"LowTable", 			new Item("LowTable", 			new Vector3(-0.25f, 3.85f, -14.7f) , 	1)},
		{"SofaChair01", 		new Item("SofaChair01", 		new Vector3(-0.25f, 3.92f, -14.66f), 	1)},
		{"Sofa01", 				new Item("Sofa01", 				new Vector3(1.26f , 0.51f, -8.74f) , 	1.8f)},
		{"OrangeSofa", 			new Item("OrangeSofa", 			new Vector3(-1.44f, 0.5f , -10.86f), 	1.2f)},
		{"FloorLamp", 			new Item("FloorLamp", 			new Vector3(-9.07f, 1.94f, -6.68f) , 	2f)},
		{"TrophyTable", 		new Item("TrophyTable", 		new Vector3(-0.74f, 1.38f, -6.49f) , 	5)},
		{"GreenSofaChair", 		new Item("GreenSofaChair", 		new Vector3(2.48f , 0.48f, -6.84f) , 	1.3f)},
	};

	/// <summary>
	/// A basic setup for the office, mocked
	/// </summary>
	public String[] defaultScene =
	{
		"TableSimple", 	
		"VintagePC", 
		"Lamp1",
		"Lamp2",
		"OfficeChair", 
		"Carpet", 		
		"LowTable", 	
		"SofaChair01", 
		"Sofa01", 		
		"OrangeSofa", 
		"FloorLamp", 
		"TrophyTable",
		"GreenSofaChair",
	};
//	public Item[] defaultScene = 
//	{
//		new Item("TableSimple", 	new Vector3(-3.97f, 1.04f, -9.741f) , 	5),
//		new Item("VintagePC", 		new Vector3(-9.50f, 0.29f, -10.24f), 	5),
//		new Item("Lamp", 			new Vector3(-3.12f, 2.16f, -9.48f), 	1),
//		new Item("Lamp", 			new Vector3(-7.38f, 1.93f, -10.92f), 	1),
//		new Item("OfficeChair", 	new Vector3(-5.92f, 0.5f, -9.38f), 		1.3f),
//		new Item("Carpet", 			new Vector3(-4.5f , 2.57f, -10.03f), 	1),
//		new Item("LowTable", 		new Vector3(-0.25f, 3.85f, -14.7f), 	1),
//		new Item("SofaChair01", 	new Vector3(-0.25f, 3.92f, -14.66f), 	1),
//		new Item("Sofa01", 			new Vector3(1.26f , 0.51f, -8.74f), 	1.8f),
//		new Item("OrangeSofa", 		new Vector3(-1.44f, 0.5f, -10.86f), 	1.2f),
//		new Item("FloorLamp", 		new Vector3(-9.07f, 1.94f, -6.68f), 	2f),
//		new Item("TrophyTable", 	new Vector3(-0.74f, 1.38f, -6.49f), 	5),
//		new Item("GreenSofaChair", 	new Vector3(2.48f , 0.48f, -6.84f), 	1.3f),
//	};
	
	
	
	/// <summary>
	/// Use this for initialization
	/// </summary>
	void Start ()
	{
		if ( deamon==null ) 
			this.deamon = this.gameObject; // If no deamon supplied, assume this is the deamon
		manager = deamon.GetComponent<OfficeObjectManager> ();	

		this.ReloadScene ();
	}
	
	
	
	/// <summary>
	/// Update is called once per frame
	/// </summary>
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
		
		//Debug.Log ("Loading scene");

		// Reload
		IEnumerable<Item> items = this.DesignScene ();
		loadedGameObjects = new List<GameObject>(manager.LoadItems (items, shift, OfficeParentObject));
		
		// Kill interaction
		if ( !this.Interactive )
		{
			foreach ( GameObject go in loadedGameObjects )
			{
				Component.Destroy(go.GetComponent<TicklesBehaviour>());
				Component.Destroy(go.GetComponent<ShopGUI>());
			}
		}
	}



	/// <summary>
	/// Destroys all the previously GameObjects
	/// </summary>
	public void UnloadScene()
	{
		//Debug.Log ("Nuking scene");
		foreach ( GameObject go in loadedGameObjects )
		{
			UnityEngine.Object.Destroy(go);
		}
	}



	/// <summary>
	/// Removes the object from the server and the scene.
	/// </summary>
	/// <param name="objectname">The object to be removed.</param>
	/// <param name="reload">If set to <c>true</c> reload to show the changes.</param>
	public void RemoveObject(string objectName, bool reload = true)
	{
		Debug.Log("Removing " + objectName);
		
		// Update local cache
		loadedObjectNames.Remove(objectName);
		
		// Remove from server
		if ( this.GoingLive )
			ServerConnector.getInstance ().RemoveOfficeObject (objectName);

		// Reload scene from server;
		if ( reload )
			this.ReloadScene ();
	}



	/// <summary>
	/// Updates the server and the scene with a new object
	/// </summary>
	/// <param name="objectname">The object to be reloaded.</param>
	/// <param name="reload">If set to <c>true</c> reload the scene to show changes.</param>
	public void AddObject(string objectName, bool reload = true)
	{
		Debug.Log ("Adding " + objectName);
	
		// Update local cache
		loadedObjectNames.Add(objectName);
		
		// Add to server
		if ( this.GoingLive )
			ServerConnector.getInstance ().AddOfficeObject (objectName);

		// Reload scene from server
		if (reload)
			this.ReloadScene ();
	}



	/// <summary>
	/// Adds or removes the given object from the scene.
	/// </summary>
	/// <param name="objectname">the object name.</param>
	/// <param name="reload">If set to <c>true</c> reload the scene.</param>
	public void ToggleObject(string objectname, bool reload = true)
	{
		if (loadedObjectNames.Contains (objectname)) 
		{
			this.RemoveObject (objectname, reload);
		} 
		else
		{
			this.AddObject (objectname, reload);
		}
	}



	/// <summary>
	/// Designs the scene.
	/// </summary>
	/// <returns>The scene.</returns>
	public IEnumerable<Item> DesignScene()
	{
		ICollection<Item> items = new List<Item> ();

		// Get scene from server
		if ( this.GoingLive )
		{
			loadedObjectNames = ServerConnector.getInstance ().GetOfficeObjects ();
			
			string s = "[";
			foreach ( string n in loadedObjectNames )
			{
				s += n + ", ";
			}
			s += "]";
			Debug.Log("Loaded " + loadedObjectNames.Count + " objects from server: " + s);
		}

		// If scene is empty, load default scene
		if (loadedObjectNames.Count == 0)
		{
			Debug.Log("Scene from server was empty. Loading default scene");
			
			foreach ( String item in this.defaultScene )
				this.AddObject(item, false);
			loadedObjectNames = new List<string>(this.defaultScene);		
		}

		// Load scene
		foreach (string objectname in loadedObjectNames)
		{
			string name = GetObjectName (objectname, this.Interactive);
			items.Add(new Item(singletons[name]));
		}

		Debug.Log ("Designed scene with " + items.Count + " items");
		return items;
	}
	
	
	
	/// <summary>
	/// Returns the appropriate name for the object, choosing between interactive and non-interactive objects if they exist
	/// </summary>
	/// <returns>The item.</returns>
	/// <param name="objectName">Object name.</param>
	/// <param name="interactive">If set to <c>false</c> get non-interactive version, if possible.</param>
	public string GetObjectName(string objectName, bool interactive = true)
	{
		if ( interactive )
			return objectName;
		else
		{
			string deadName = objectName + "_Dead";
			if ( singletons.ContainsKey(deadName) )
				return deadName;
			else
				return objectName;
		}
	}
}
