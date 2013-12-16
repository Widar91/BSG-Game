using UnityEngine;
using System.Collections;

public class OnDistrictHovering : MonoBehaviour {

	private GameObject hoverlight;
	private bool highlightBuilding;

	private GUIStyle hoveringMessageStyle;
	private string name;
	
	// Use this for initialization
	void Start () {
		this.gameObject.transform.Find("Light1").gameObject.light.enabled = false;
		this.gameObject.transform.Find("Light2").gameObject.light.enabled = false;

		highlightBuilding = false;

		hoveringMessageStyle = new GUIStyle();
		hoveringMessageStyle.normal.textColor = Color.white;  
		hoveringMessageStyle.alignment = TextAnchor.UpperCenter ;
		hoveringMessageStyle.wordWrap = true;
		hoveringMessageStyle.fontStyle = FontStyle.Bold;
		
		name = this.gameObject.name;
		
		
	}
	
	void OnMouseEnter()
	{
		highlightBuilding = true;
		this.gameObject.transform.Find("Light1").gameObject.light.enabled = true;
		this.gameObject.transform.Find("Light2").gameObject.light.enabled = true;
	}
	
	void OnMouseExit()
	{
		highlightBuilding = false;
		this.gameObject.transform.Find("Light1").gameObject.light.enabled = false;
		this.gameObject.transform.Find("Light2").gameObject.light.enabled = false;
	}
	
	void OnGUI()
	{
		if (highlightBuilding) {
			Rect position = new Rect(	Event.current.mousePosition.x - 50f,
			                         Event.current.mousePosition.y - 50f,
			                         200f,
			                         200f
			                         );
			GUI.Label(position, name, hoveringMessageStyle);		
		}
	}
}
