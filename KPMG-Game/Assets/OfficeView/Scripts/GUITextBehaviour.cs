using UnityEngine;
using System.Collections;

public class GUITextBehaviour : MonoBehaviour {
	

	// Use this for initialization
	void Start () {
		gameObject.guiText.text = "...";
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void ShowText(string message)
	{
		gameObject.guiText.text = message;
	}

	public string GetText()
	{
		return gameObject.guiText.text;
	}
}
