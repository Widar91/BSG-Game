using UnityEngine;
using System.Collections;


public class Item
{
	public string resource;
	public Vector3 position;
	public Vector3 scale;
	public Vector3 rotation;

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

	public GameObject CreateGameObject (Item item)
	{
		GameObject instance = (GameObject)Instantiate (Resources.Load (item.resource));
		return instance;
	}

	public void PositionGameObject (Item item, GameObject instance, GameObject inParent = null)
	{
		if (inParent != null)
			instance.transform.parent = inParent.transform;
		else
			if (ParentObject != null)
				instance.transform.parent = ParentObject.transform;
		instance.transform.localScale = item.scale;
		instance.transform.localPosition = item.position;
	}

	public void LoadItem(Item item, GameObject inParent = null)
	{
		var instance = CreateGameObject (item);

		// Place uner another gameobject, if provided
		PositionGameObject (item, inParent, instance);

	}

	public void LoadItems(IEnumerable items, Vector3 shift, GameObject inParent = null)
	{
		foreach (Item item in items) 
		{
			Vector3 p = item.position;
			item.position = new Vector3(p.x + shift.x, p.y + shift.y, p.z + shift.z);
			PositionGameObject(item, inParent);
		}
	}

	public void LoadItems(IEnumerable items, GameObject inParent = null)
	{
		foreach (Item item in items)
		{
			LoadItem(item, inParent);
		}
	}

 
}
