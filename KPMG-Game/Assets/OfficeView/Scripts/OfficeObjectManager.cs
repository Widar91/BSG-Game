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
}

public class OfficeObjectManager : MonoBehaviour {

	Item[] items = 
	{
		new Item("TableSimple", new Vector3 (-3.97f,1.04f,-9.741f) , 5)
	};

	// Use this for initialization
	void Start () {
		LoadItems (items);
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void LoadItems(IEnumerable items)
	{
		foreach (Item item in items)
		{
			GameObject instance = (GameObject) Instantiate(Resources.Load(item.resource));
			instance.transform.localScale = item.scale;
			instance.transform.position = item.position;
			//instance.renderer.material.color = Color.cyan;
		}
	}
}
