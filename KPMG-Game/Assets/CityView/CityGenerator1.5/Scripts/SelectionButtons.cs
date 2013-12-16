using UnityEngine;
using System.Collections;

public class SelectionButtons : MonoBehaviour {

	
public GUIStyle customGUI;	

public GameObject generator;
	
public Texture Road;
public Texture Building;
public Texture Park;
public Texture Parking;
	
public Texture GenerateTex;
	
bool bt1 = false;
bool bt2 = false;
bool bt3 = false;
bool bt4 = false; 
	
Transform currentButton;	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	

bool setMeOnly (){
 
   bt1 = bt2 = bt3 = bt4 = false;
  return true;
}	
	
	
	
	

	
	
	
	
	
	
	
	

 
void OnGUI () {
 	
 GUI.DrawTexture(new Rect(280,10,150,100), GenerateTex,  ScaleMode.StretchToFill, true, 0);	
 GUI.DrawTexture(new Rect(10,10,60,60), Road,  ScaleMode.StretchToFill, true, 0);
 GUI.DrawTexture(new Rect(70,10,60,60), Building,  ScaleMode.StretchToFill, true, 0);
 GUI.DrawTexture(new Rect(140,10,60,60), Park,  ScaleMode.StretchToFill, true, 0);
 GUI.DrawTexture(new Rect(200,10,60,60), Parking,  ScaleMode.StretchToFill, true, 0);

		
		
  if (GUI.Toggle (new Rect(10,70,60,60), bt1, "Road", customGUI)){
  bt1 = setMeOnly();
			
Transform[] ts = gameObject.transform.GetComponentsInChildren<Transform>();
foreach (Transform t in ts) {
if(t.transform.gameObject.layer == 8){
t.transform.gameObject.GetComponent<BuildRoadScheme>().usedName = "Road";
					
t.transform.gameObject.GetComponent<BuildPark>().usePark = false;
t.transform.gameObject.GetComponent<BuildParking>().useParking = false;
t.transform.gameObject.GetComponent<BuildBuilding>().useBuilding = false;
t.transform.gameObject.GetComponent<BuildRoadScheme>().useRoad = true;

}
}
}

  if (GUI.Toggle (new Rect(70,70,60,60), bt2, "Building", customGUI)){
  bt2 = setMeOnly();
			
Transform[] ts = gameObject.transform.GetComponentsInChildren<Transform>();
foreach (Transform t in ts) {
if(t.transform.gameObject.layer == 8){
t.transform.gameObject.GetComponent<BuildBuilding>().usedName = "Building";
					
t.transform.gameObject.GetComponent<BuildPark>().usePark = false;
t.transform.gameObject.GetComponent<BuildParking>().useParking = false;
t.transform.gameObject.GetComponent<BuildBuilding>().useBuilding = true;
t.transform.gameObject.GetComponent<BuildRoadScheme>().useRoad = false;

}
}				
}
	
  if (GUI.Toggle (new Rect(140,70,60,60), bt3, "Park", customGUI)){
  bt3 = setMeOnly();
			
Transform[] ts = gameObject.transform.GetComponentsInChildren<Transform>();
foreach (Transform t in ts) {
if(t.transform.gameObject.layer == 8){		
t.transform.gameObject.GetComponent<BuildPark>().usedName = "Park";

t.transform.gameObject.GetComponent<BuildPark>().usePark = true;
t.transform.gameObject.GetComponent<BuildParking>().useParking = false;
t.transform.gameObject.GetComponent<BuildBuilding>().useBuilding = false;
t.transform.gameObject.GetComponent<BuildRoadScheme>().useRoad = false;

}
}			
}

  if (GUI.Toggle (new Rect(200,70,60,60), bt4, "Parking", customGUI)){
  bt4 = setMeOnly();
			
Transform[] ts = gameObject.transform.GetComponentsInChildren<Transform>();
foreach (Transform t in ts) {
if(t.transform.gameObject.layer == 8){
t.transform.gameObject.GetComponent<BuildParking>().usedName = "Parking";
					
t.transform.gameObject.GetComponent<BuildPark>().usePark = false;
t.transform.gameObject.GetComponent<BuildParking>().useParking = true;
t.transform.gameObject.GetComponent<BuildBuilding>().useBuilding = false;
t.transform.gameObject.GetComponent<BuildRoadScheme>().useRoad = false;

}
}			
}
		
		
		
if (GUI.Button(new Rect(280,10,150,100), "")){
			
if(generator.GetComponent<CityGenerator>().end == true){		
			
			
Transform[] ts = gameObject.GetComponentsInChildren<Transform>();
foreach (Transform t in ts) {
				
if(t.transform.gameObject.name == "Road"){
t.transform.gameObject.GetComponent<BuildRoadScheme>().enabled = true;
t.transform.gameObject.GetComponent<BuildRoadScheme>().generate = true;
t.transform.gameObject.GetComponent<BuildRoadScheme>().activate = true;
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
t.transform.gameObject.GetComponent<BuildPark>().activate = true;
}

if(t.transform.gameObject.name == "Parking"){
t.transform.gameObject.GetComponent<BuildParking>().enabled = true;
t.transform.gameObject.GetComponent<BuildParking>().generate = true;
t.transform.gameObject.GetComponent<BuildParking>().activate = true;
}
				
}
}			
}
		

		
		
		
		
		
		
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
