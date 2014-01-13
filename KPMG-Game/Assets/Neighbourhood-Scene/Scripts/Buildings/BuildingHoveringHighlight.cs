using UnityEngine;
using System.Collections;

public class BuildingHoveringHighlight : MonoBehaviour {

	private bool highlightBuilding;
	private Color defaultColor;

	private GUIStyle hoveringMessageStyle;
	private string name;

	// Use this for initialization
	void Start () {
		highlightBuilding = false;
		defaultColor = renderer.material.color;

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
		renderer.material.color = Color.green;
	}
	
	void OnMouseExit()
	{
		highlightBuilding = false;
		renderer.material.color = defaultColor;
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
