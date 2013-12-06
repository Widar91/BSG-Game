using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class WorldCityManager : MonoBehaviour {

	private Dictionary<string, WorldCity> cities;
	private GameObject baseCity;
	private GameObject earth;

	// Use this for initialization
	void Start () {
		baseCity = GameObject.FindGameObjectWithTag("BaseCity");
		earth = GameObject.FindGameObjectWithTag("Earth");
		LoadCities();
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	//Loads the city data
	void LoadCities() {
		
		//TODO: this needs to be replaced by a real loading function
		//begin: data to be loaded
		string[] colors = new string[] {"Blue", "Green", "Pink", "Red", "Yellow"};
		
		List<string> cityNames = new List<string>() { 	"Amsterdam",
														"Paris",
														"Barcelona",
														"New York"
													};
		
		List<Vector2> rotations = new List<Vector2>() {	new Vector2(53.10925f, -112.7088f),
														new Vector2(48.79163f, -109.6368f),
														new Vector2(39.80872f, -108.277f),
														new Vector2(41.04829f, -33.99554f)
													  };
										  											  											  
		List<int[]> scores = new List<int[]>() {	new int[] {10, 30, 20, 80, 70},
													new int[] {45, 30, 80, 40, 50},
													new int[] {60, 53, 80, 10, 5},
													new int[] {40, 63, 20, 40, 80}
											   };														
		//end: data to be loaded

		
		
		// Create and store the cities from the loaded data
		cities = new Dictionary<string, WorldCity>();
		for (int i = 0; i < cityNames.Count; i++)
			cities.Add(cityNames[i], new WorldCity(cityNames[i], rotations[i], colors, scores[i]));
		
		// Draw the cities in the game world
		foreach (KeyValuePair<string, WorldCity> entry in cities) {		
			
			GameObject newCity;
			newCity = (GameObject)Instantiate ( baseCity );
			newCity.name = entry.Value.Name;
			newCity.transform.parent = earth.transform;
			newCity.transform.position = baseCity.transform.position;			
			newCity.transform.localScale = baseCity.transform.localScale;
			
			Vector3 euler = baseCity.transform.localEulerAngles;
				euler.x = (euler.x + entry.Value.Rotation.x) % 360;
				euler.y = (euler.y + entry.Value.Rotation.y) % 360;
			newCity.transform.localEulerAngles = euler; 
				
			foreach (Transform building in newCity.transform)
				foreach (string color in colors)
					if (building.name.Equals(color))
						building.localScale = new Vector3(0.01f, 0.01f, entry.Value.Buildings[color].Scale);
			
		}
		
		// Destroy the city template
		Destroy(baseCity);
	}
}

public class WorldCity {

	private string name;
	private Vector3 rotation;
	private Dictionary<string, WorldBuilding> buildings;
	
	public WorldCity(string lName, Vector3 lRotation, string[] lColors, int[] lScores) {
		name = lName;
		rotation = lRotation;
		buildings = new Dictionary<string, WorldBuilding>();
		if (lColors.Length == lScores.Length)
			for (int i = 0; i < lColors.Length; i++)
				buildings.Add(lColors[i], new WorldBuilding(lColors[i], lScores[i]));
	}
	
	public string Name {
		get { return name; }
	}
	
	public Vector3 Rotation {
		get { return rotation; }
	}
	
	public List<string> BuildingColors {
		get { 
		 	List<string> colors = new List<string>();
		 	foreach (string key in buildings.Keys)
		 		colors.Add(key);
		 	return colors; 
		 }
	}
	
	public Dictionary<string, WorldBuilding> Buildings {
		get { return buildings; }
	}

}

public class WorldBuilding {

	private string color;
	private int score;
	
	public WorldBuilding(string lColor, int lScore) {
		color = lColor;
		score = lScore;
	}
	
	public string Color {
		get { return color; }
	}
	
	public int Score {
		get { return score; }
	}
	
	public float Scale {
		get { return (0.1f + ((float)score * 0.0015f)); }
	}
	
}