using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class WorldCityManager : MonoBehaviour {

	private WorldData data;
	private GameObject baseCity;
	private GameObject earth;

	// Use this for initialization
	void Start () {
		
		// get the data class
		GameObject scripts = GameObject.Find ("Scripts");
		data = scripts.GetComponent<WorldData> ();
	
		// start loading the rest
		baseCity = GameObject.FindGameObjectWithTag("BaseCity");
		earth = GameObject.FindGameObjectWithTag("Earth");
		LoadCities();
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	//Loads the city data
	void LoadCities() {
			
			// Draw the cities in the game world
			foreach (KeyValuePair<string, WorldCountry> entry in data.Countries) {		
				
				GameObject newCity;
				newCity = (GameObject)Instantiate ( baseCity );
				newCity.name = entry.Value.Name;
				newCity.transform.parent = earth.transform;
				newCity.transform.position = baseCity.transform.position;			
				newCity.transform.localScale = baseCity.transform.localScale;
				newCity.transform.localEulerAngles = entry.Value.Rotation; 
					
				foreach (Transform building in newCity.transform)
					foreach (string color in data.Categories)
						if (building.name.Equals(color))
							building.localScale = new Vector3(0.01f, 0.01f, entry.Value.Buildings[color].Scale);
				
			}
			
			// Destroy the city template
			Destroy(baseCity);
			
			// Destroy the coordinates finder
			GameObject coordCity = GameObject.FindGameObjectWithTag("CoordCity");
			Destroy(coordCity);

	}
}