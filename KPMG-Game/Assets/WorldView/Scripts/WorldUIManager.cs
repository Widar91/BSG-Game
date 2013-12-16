using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class WorldUIManager : MonoBehaviour {

	private WorldData data;
	public Camera camera;
	private string tooltip;
	private GameObject earth;
		
	private string searchWord;
	private Dictionary<string, Vector3> searchResults;
	private string searchResponse;
	
	// Use this for initialization
	void Start () {
	
		// get the data class
		GameObject scripts = GameObject.Find ("Scripts");
		data = scripts.GetComponent<WorldData> ();
	
		// find earth
		earth = GameObject.Find("Earth");
	
		// set the keyword to be empty
		searchWord = "";
		searchResults = new Dictionary<string, Vector3>();
		searchResponse = "";
	}
	
	void Update () {
		
		// check for the tooltip
		RaycastHit hit;
		if (Physics.Raycast(camera.ScreenPointToRay(Input.mousePosition), out hit)) {
			if (hit.collider.gameObject.name.Equals("Earth")) {
				tooltip = "";
			} else {
				tooltip = hit.collider.gameObject.transform.parent.name;

				//TODO: This instruction loads the neighbourhood view
				//when a city is clicked. Later it will have to
				//be adapted to distinguish between player's city
				//or an external one.
				if(Input.GetMouseButtonDown(0))
					Application.LoadLevel("Neighbourhood");
			}
		} else {
			tooltip = "";
		}
		
	}
	
	// Update is called once per frame
	void OnGUI () {
	
		// execute a search on enter
		searchWord = GUI.TextField(new Rect(25, 25, 125, 25), searchWord);
		if (Event.current.keyCode == KeyCode.Return) {
			searchResults = data.findPlaces(searchWord);
		
			if (searchResults.Count == 0)
				searchResponse = "No results have been found for keyword(s) '" + searchWord + "'";
			else if (searchResults.Count > 10) 
				searchResponse = "Too many results for keyword(s) '" + searchWord + "' (count: " + searchResults.Count + ")";
			else
				searchResponse = "";
		}
		
		// draw the search results
		GUI.Label (new Rect(25, 50, 400, 25), searchResponse);
		if (searchResponse.Equals("")) {
			int top = 75;
			foreach (KeyValuePair<string, Vector3> entry in searchResults) {
				if (GUI.Button (new Rect(25, top, 200, 25), entry.Key)) {
					earth.transform.localEulerAngles = entry.Value;
				}
				top += 30;
			}
		}
		
		
		// show tooltip if neccesary
		showCountryTooltip();
		
	}
	
	void showCountryTooltip() {
	
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
