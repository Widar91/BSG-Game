using UnityEngine;
using System.Collections;

public class WorldUIManager : MonoBehaviour {

	public Camera camera;
	private string tooltip;

	// Use this for initialization
	void Start () {
	
	}
	
	void Update () {
		
		RaycastHit hit;
		if (Physics.Raycast(camera.ScreenPointToRay(Input.mousePosition), out hit)) {
			if (hit.collider.gameObject.name.Equals("Earth"))
				tooltip = "";
			else
				tooltip = hit.collider.gameObject.transform.parent.name;
		} else {
			tooltip = "";
		}
		
	}
	
	// Update is called once per frame
	void OnGUI () {
	
		GUIStyle guiStyleFore = new GUIStyle();
		guiStyleFore.normal.textColor = Color.white;  
		guiStyleFore.alignment = TextAnchor.UpperCenter ;
		guiStyleFore.wordWrap = true;
		guiStyleFore.fontStyle = FontStyle.Bold;
		
		
		Rect box = new Rect(	Event.current.mousePosition.x - 50f,
								Event.current.mousePosition.y - 50f,
								200f,
								200f
							);
		
		GUI.Label (box, tooltip, guiStyleFore);

			
	
	}
}
