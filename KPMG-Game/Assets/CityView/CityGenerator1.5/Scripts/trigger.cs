using UnityEngine;
using System.Collections;

public class trigger : MonoBehaviour {
	
	
	
public GameObject Button;
public string direction = "";	


	
	
	
	
	
	
	
	
	
void OnTriggerStay(Collider other){
	

		
if(other.gameObject.name == "Road"){	

if(direction == "frontCollided"){
Button.gameObject.GetComponent<BuildRoadScheme>().frontCollided = true;				
}

if(direction == "backCollided"){
Button.gameObject.GetComponent<BuildRoadScheme>().backCollided = true;				
}
			
if(direction == "leftCollided"){
Button.gameObject.GetComponent<BuildRoadScheme>().leftCollided = true;				
}
			
if(direction == "rightCollided"){
Button.gameObject.GetComponent<BuildRoadScheme>().rightCollided = true;				
}
}
		
		
		
		
if(other.gameObject.name == "3DButton(Clone)" || other.gameObject.name == "3DButton"){
			
if(direction == "frontCollided"){
Button.gameObject.GetComponent<BuildRoadScheme>().frontCollided = false;				
}

if(direction == "backCollided"){
Button.gameObject.GetComponent<BuildRoadScheme>().backCollided = false;				
}
			
if(direction == "leftCollided"){
Button.gameObject.GetComponent<BuildRoadScheme>().leftCollided = false;				
}
			
if(direction == "rightCollided"){
Button.gameObject.GetComponent<BuildRoadScheme>().rightCollided = false;				
}
}	
	
}	
	
	
	
}