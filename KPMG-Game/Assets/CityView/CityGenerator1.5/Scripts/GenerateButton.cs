using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class GenerateButton : MonoBehaviour {

public GameObject mainBuilder;
public GameObject generator;

Transform currentButton;

	
	
	
	
	
	
	
	
	
	
	
	
void OnMouseDown (){


if(generator.GetComponent<CityGenerator>().end == true){		
			
			
Transform[] ts = gameObject.GetComponentsInChildren<Transform>();
foreach (Transform t in ts) {
				
if(t.transform.gameObject.name == "Road"){
t.transform.gameObject.GetComponent<BuildRoadScheme>().enabled = true;
t.transform.gameObject.GetComponent<BuildRoadScheme>().generate = true;
t.transform.gameObject.GetComponent<BuildRoadScheme>().activate = true;
Debug.Log("marche");
}
				
if(t.transform.gameObject.name == "3DButton" || t.transform.gameObject.name == "3DButton(Clone)"){	
Destroy(t.transform.gameObject);
}
				
if(t.transform.gameObject.name == "Building"){	
t.transform.gameObject.GetComponent<BuildBuilding>().enabled = true;
t.transform.gameObject.GetComponent<BuildBuilding>().generate = true;
t.transform.gameObject.GetComponent<BuildBuilding>().activate = true;
}
				
if(t.transform.gameObject.name == "Park"){	
t.transform.gameObject.GetComponent<BuildPark>().enabled = true;
t.transform.gameObject.GetComponent<BuildPark>().generate = true;
}

if(t.transform.gameObject.name == "Parking"){
t.transform.gameObject.GetComponent<BuildParking>().enabled = true;
t.transform.gameObject.GetComponent<BuildParking>().generate = true;
}
				
}
}

		

}
	
	
}
