using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class WorldData : MonoBehaviour {

	private Dictionary<string, WorldCountry> countries;
	private string[] categories;

	void Start() {
	
	}

	//Loads the city data
	void Awake() {
		
		//TODO: this needs to be replaced by a real loading function
		//begin: data to be loaded
		categories = new string[] {
			"Risk", 
			"Compliance", 
			"Management", 
			"Tax", 
			"Audit"
		};
		
		List<string> countryNames = new List<string>();
		countryNames.Add("The Netherlands");
		countryNames.Add("France");
		countryNames.Add("Spain");
		countryNames.Add("United States");
		countryNames.Add("India");

		Dictionary<string, int> cityNames = new Dictionary<string, int>();
		cityNames.Add("Amsterdam", 0);
		cityNames.Add("Rotterdam", 0);
		cityNames.Add("The Hague", 0);
		cityNames.Add("Paris", 1);
		cityNames.Add("Lyon", 1);
		cityNames.Add("Madrid", 2);
		cityNames.Add("Barcelona", 2);
		cityNames.Add("New York", 3);
		cityNames.Add("San Diego", 3);
		cityNames.Add("Houston", 3);
		cityNames.Add("Seattle", 3);
		cityNames.Add("Denver", 3);
		cityNames.Add("Delhi", 4);
		
		List<List<string>> cities = new List<List<string>>();
		for (int i = 0; i < countryNames.Count; i++)
			cities.Add(cityNames.Where (x => x.Value == i).Select(x => x.Key).ToList());
		
		List<Vector3> rotations = new List<Vector3>();
		rotations.Add(new Vector3(52.80031f, 246.9781f, 0f));
		rotations.Add(new Vector3(47.80031f, 247.7784f, 0f));
		rotations.Add(new Vector3(40.00034f, 255.3768f, 0f));
		rotations.Add(new Vector3(38.80033f, 350.5898f, 0f));
		rotations.Add(new Vector3(20.80047f, 173.5766f, 0f));
		
		List<Vector3> earthCoords = new List<Vector3>();
		earthCoords.Add(new Vector3(6.956102f, 103.8067f, 306.9957f));
		earthCoords.Add(new Vector3(4.958158f, 105.1836f, 312.1825f));
		earthCoords.Add(new Vector3(3.211749f, 101.2425f, 320.9749f));
		earthCoords.Add(new Vector3(321.0987f, 356.6528f, 16.71077f));
		earthCoords.Add(new Vector3(20.95520f, 186.4439f, 0.5283973f));

		List<int[]> scores = new List<int[]>();	
		scores.Add(new int[] {10, 30, 20, 80, 70});
		scores.Add(new int[] {45, 30, 80, 40, 50});
		scores.Add(new int[] {60, 53, 80, 10, 5});
		scores.Add(new int[] {40, 63, 20, 40, 80});
		scores.Add(new int[] {50, 30, 65, 90, 90});												
		//end: data to be loaded
		
		// Create and store the cities from the loaded data
		countries = new Dictionary<string, WorldCountry>();
		for (int i = 0; i < countryNames.Count; i++)
			countries.Add(countryNames[i], new WorldCountry(countryNames[i], cities[i], rotations[i], earthCoords[i], categories, scores[i]));
		
	}
	
	public Dictionary<string, WorldCountry> Countries {
		get { return countries; }
	}
	
	public string[] Categories {
		get { return categories; }
	}
	
	public Dictionary<string, Vector3> findPlaces(string keyword) {
		
		Dictionary<string, Vector3> locations = new Dictionary<string, Vector3>();
		foreach (WorldCountry country in countries.Values) {
			if (country.Name.ToLower().Contains(keyword))
				locations.Add(country.Name, country.EarthCoords);
			foreach (string city in country.Cities)
				if (city.ToLower().Contains(keyword))
					locations.Add(city + ", " + country.Name, country.EarthCoords);
		}
		
		return locations;
	}
}

public class WorldCountry {
	
	private string name;
	private List<string> cities;
	private Vector3 rotation;
	private Vector3 earthCoords;
	private Dictionary<string, WorldBuilding> buildings;
	
	public WorldCountry(string lName, List<string> lCities, Vector3 lRotation, Vector3 lEarth, string[] lCategories, int[] lScores) {
		name = lName;
		cities = lCities;
		rotation = lRotation;
		earthCoords = lEarth;
		buildings = new Dictionary<string, WorldBuilding>();
		if (lCategories.Length == lScores.Length)
			for (int i = 0; i < lCategories.Length; i++)
				buildings.Add(lCategories[i], new WorldBuilding(lCategories[i], lScores[i]));
	}
	
	public string Name {
		get { return name; }
	}
	
	public List<string> Cities {
		get { return cities; }
	}
	
	public Vector3 Rotation {
		get { return rotation; }
	}
	
	public Vector3 EarthCoords {
		get { return earthCoords; }
	}
	
	public List<string> BuildingColors {
		get { 
			List<string> categories = new List<string>();
			foreach (string key in buildings.Keys)
				categories.Add(key);
			return categories; 
		}
	}
	
	public Dictionary<string, WorldBuilding> Buildings {
		get { return buildings; }
	}
	
}

public class WorldBuilding {
	
	private string category;
	private int score;
	
	public WorldBuilding(string lCategory, int lScore) {
		category = lCategory;
		score = lScore;
	}
	
	public string Category {
		get { return category; }
	}
	
	public int Score {
		get { return score; }
	}
	
	public float Scale {
		get { return (0.1f + ((float)score * 0.0015f)); }
	}
	
}
