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

	private bool showCountryData = false;
	private Rect cdRect;
	private string cdName;
	private int cdWidth = 350;
	private int cdHeight = 400;

	
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

		// set the country data window size
		cdRect = new Rect (Screen.width / 2 - cdWidth / 2, (Screen.height - 100) / 2 - cdHeight / 2, cdWidth, cdHeight);
	}
	
	void Update () {
		
		// check for the tooltip
		if (!showCountryData) {
				RaycastHit hit;
				if (Physics.Raycast (camera.ScreenPointToRay (Input.mousePosition), out hit)) {
						if (hit.collider.gameObject.name.Equals ("Earth")) {
								tooltip = "";
								cdName = tooltip;
						} else {
								tooltip = hit.collider.gameObject.transform.parent.name;
								cdName = tooltip;
		
								if (Input.GetMouseButtonDown (0)) {
										showCountryData = true;
								}
						}
				} else {
						tooltip = "";
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
				//ButtonstyleGUI_CS.buttonstyle(null, null);
				if (GUI.Button (new Rect(25, top, 200, 25), entry.Key)) {
					earth.transform.localEulerAngles = entry.Value;
				}
				top += 30;
			}
		}
		
		
		// show tooltip if neccesary
		showCountryTooltip();

		// show the country info if neccesary
		if (showCountryData) {
			cdRect = GUI.Window (0, cdRect, countryDataScreen, cdName);
		}
		
	}

	private void countryDataScreen(int windowID) {

		// get the country object
		WorldCountry country = data.Countries [cdName];

		// create the labels
		List<string> labels = new List<string> () {
			"Country",
			"Number of Offices",
			""
		};

		// create the values
		List<string> values = new List<string> () {
			cdName,
			country.Cities.Count.ToString(),
			""
		};

		// add building scores to labels and values
		List<WorldBuilding> buildings = new List<WorldBuilding> (country.Buildings.Values);
		foreach (WorldBuilding building in buildings) {
			labels.Add(building.Category + " score");
			values.Add(building.Score.ToString());
		}

		// display labels and values
		int top = 50;
		int offset = 25;
		for (int i = 0; i < labels.Count; i++) {
			GUI.Label (new Rect ( 50, top + i * offset, cdWidth - 100, 25), labels[i]);
			GUI.Label (new Rect (200, top + i * offset, cdWidth - 100, 25), values[i]);
		}

		// display close button
		if (GUI.Button(new Rect(cdWidth / 2 - 75, cdHeight - 75, 150, 25), "Close")) {
			showCountryData = false;
			cdName = "";
		}

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
