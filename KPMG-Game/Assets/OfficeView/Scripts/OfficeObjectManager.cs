using UnityEngine;
using System.Collections;
using System.Collections.Generic;


public class Item
{
	public string resource;
	public Vector3 position;
	public Vector3 scale;
	public Vector3 rotation;

	public Item(Item item)
	{
		this.resource = item.resource;
		this.position = item.position;
		this.rotation = item.rotation;
		this.scale = item.scale;
	}
	public Item(string name, Vector3 position, float scale)
	{
		this.resource = name;
		this.position = position;
		this.scale = new Vector3 (scale,scale,scale);
	}
	public Item(string name, Vector3 position, Vector3 rotation, Vector3 scale)
	{
		this.resource = name;
		this.position = position;
		this.rotation = rotation;
		this.scale = scale;
	}
}

public class OfficeObjectManager : MonoBehaviour 
{
	public GameObject ParentObject = null;

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	

	/// <summary>
	/// Instantiate the item
	/// </summary>
	/// <returns>The game object.</returns>
	/// <param name="item">Item.</param>
	public GameObject CreateGameObject (Item item)
	{
		GameObject instance = (GameObject)Instantiate (Resources.Load (item.resource));
		return instance;
	}
	
	

	/// <summary>
	/// Positions the game object.
	/// </summary>
	/// <param name="item">The Item object that contains the position and scale for the object</param>
	/// <param name="instance">Instance to be positioned.</param>
	/// <param name="inParent">The parent for the instance.</param>
	public void PositionGameObject (Item item, GameObject instance, GameObject inParent = null)
	{
		if (inParent == null)
			inParent = ParentObject;
		
		if (inParent != null)
			instance.transform.parent = inParent.transform;
			
		instance.transform.localScale = item.scale;
		instance.transform.localPosition = item.position;
	}
	


	/// <summary>
	/// Loads the item.
	/// </summary>
	/// <returns>The GameObject instance</returns>
	/// <param name="item">The item to instantiate ad position</param>
	/// <param name="inParent">The parent object for the item</param>
	public GameObject LoadItem(Item item, GameObject inParent = null)
	{
		var instance = CreateGameObject (item);

		// Place uner another gameobject, if provided
		PositionGameObject (item, instance, inParent);

		return instance;
	}
	
	

	/// <summary>
	/// Loads the items.
	/// </summary>
	/// <returns>The instantiated gameobjects.</returns>
	/// <param name="items">Items.</param>
	/// <param name="shift">Shift within the parent.</param>
	/// <param name="inParent">The parent gameobject.</param>
	public List<GameObject> LoadItems(IEnumerable<Item> items, Vector3 shift, GameObject inParent = null)
	{
		List<GameObject> gos = new List<GameObject> ();

		foreach (Item item in items) 
		{
			Vector3 p = item.position;
			item.position = new Vector3(p.x + shift.x, p.y + shift.y, p.z + shift.z);
			GameObject go = LoadItem(item, inParent);

			gos.Add(go);
		}

		return gos;
	}
	
	

	/// <summary>
	/// Loads the items.
	/// </summary>
	/// <returns>The instantiated and positioned GameObjects</returns>
	/// <param name="items">Items.</param>
	/// <param name="inParent">In parent.</param>
	public List<GameObject> LoadItems(IEnumerable items, GameObject inParent = null)
	{
		List<GameObject> gos = new List<GameObject> ();

		foreach (Item item in items)
		{
			GameObject go = LoadItem(item, inParent);
			gos.Add(go);
		}

		return gos;
	}

 
}
