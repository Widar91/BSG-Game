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

public class OfficeObjectManager : MonoBehaviour {

	public Item[] items = 
	{
		new Item("TableSimple", new Vector3 (-3.97f,1.04f,-9.741f) , 5),
		new Item("VintagePC", new Vector3(-9.5f, 0.29f, -10.24f), 5),
		new Item("Lamp", new Vector3(-3.12f, 2.16f, -9.48f), 1),
		new Item("Lamp", new Vector3(-7.38f, 1.93f, -10.92f), 1),
		new Item("OfficeChair", new Vector3(-5.92f, 0.5f, -9.38f), 1.3f),
		new Item("Carpet", new Vector3(-4.5f, 2.57f, -10.03f), 1),
		new Item("LowTable", new Vector3(-0.25f, 3.85f, -14.7f), 1),
		new Item("SofaChair01", new Vector3(-0.25f, 3.92f, -14.66f), 1),
		new Item("Sofa01", new Vector3(1.26f, 0.51f, -8.74f), 1.8f),
		new Item("OrangeSofa", new Vector3(-1.44f, 0.5f, -10.86f), 1.2f),
		new Item("FloorLamp", new Vector3(-9.07f, 1.94f, -6.68f), 2f),
	};

	// Use this for initialization
	void Start () {
		LoadItems (items);
	}
	
	// Update is called once per frame
	void Update () {
	
	}


	public void LoadItem(Item item)
	{
		GameObject instance = (GameObject) Instantiate(Resources.Load(item.resource));
		instance.transform.localScale = item.scale;
		instance.transform.position = item.position;
		//instance.renderer.material.color = Color.cyan;
	}

	public void LoadItems(IEnumerable items)
	{
		foreach (Item item in items)
		{
			LoadItem(item);
		}
	}
}
