using UnityEngine;
using System.Collections;

public class SelectionButtonsLowPoly : MonoBehaviour {

	
public GUIStyle customGUI;	

public GameObject generator;

public Texture Building;
	
public Texture GenerateTex;
	
bool bt1 = true;
	
Transform currentButton;	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	

	
	
	
	
	
	
	
	

 
void OnGUI () {
 	
 GUI.DrawTexture(new Rect(280,10,150,100), GenerateTex,  ScaleMode.StretchToFill, true, 0);	
 GUI.DrawTexture(new Rect(10,10,60,60), Building,  ScaleMode.StretchToFill, true, 0);



  if (GUI.Toggle (new Rect(10,70,60,60), bt1, "Building", customGUI)){
			
Transform[] ts = gameObject.transform.GetComponentsInChildren<Transform>();
foreach (Transform t in ts) {
if(t.transform.gameObject.layer == 8){
t.transform.gameObject.GetComponent<BuildBuildingLowPoly>().usedName = "Building";
t.transform.gameObject.GetComponent<BuildBuildingLowPoly>().useBuilding = true;

}
}				
}
	
 

		
		
		
if (GUI.Button(new Rect(280,10,150,100), "")){
			
if(generator.GetComponent<CityGeneratorLowPoly>().end == true){		
			
			
Transform[] ts = gameObject.GetComponentsInChildren<Transform>();
foreach (Transform t in ts) {
				
				
if(t.transform.gameObject.name == "3DButtonLowPoly" || t.transform.gameObject.name == "3DButtonLowPoly(Clone)" || t.transform.gameObject.name == "3DButton(Clone)" || t.transform.gameObject.name == "3DButton"){	
Destroy(t.transform.gameObject);
}
				
if(t.transform.gameObject.name == "Building"){	
t.transform.gameObject.GetComponent<BuildBuildingLowPoly>().enabled = true;
t.transform.gameObject.GetComponent<BuildBuildingLowPoly>().generate = true;
t.transform.gameObject.GetComponent<BuildBuildingLowPoly>().activate = true;
}

				
}
}			
}
		

		
		
		
		
		
		
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
