using UnityEngine;
using System.Collections;

public class TicklesBehaviour : MonoBehaviour {

	public string tickleMessage = "It tickles!";
	private string revertMessage = "-_-";

	private Color defaultColor;
	
	GUITextBehaviour gui;

	// Use this for initialization
	void Start () {
		GameObject ogo = GameObject.Find ("GUI Text");
		gui = ogo.GetComponent<GUITextBehaviour> ();
		defaultColor = renderer.material.color;
	}
	
	// Update is called once per frame
	void Update () 
	{
		
	}

	
	void OnMouseEnter()
	{
		revertMessage = gui.GetText ();
		gui.ShowText(tickleMessage);
		renderer.material.color = Color.green;
	}

	void OnMouseExit()
	{
		gui.ShowText (revertMessage);
		renderer.material.color = defaultColor;
	}
}
