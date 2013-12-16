using UnityEngine;
using System.Collections;

public class BuildBuildingLowPoly: MonoBehaviour {


public bool generate = false;	
public bool activate = false;
private bool colored = false;	
	
public bool useBuilding = false;

	
public string usedName = "3DButton";		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
void OnMouseDown(){

		
if(useBuilding == true){
			
if(colored == false){
gameObject.renderer.material.color = Color.black;	
gameObject.name = usedName;	
colored = true;
}

else{
gameObject.renderer.material.color = Color.white;	
gameObject.name = "3DButton";
colored = false;
}
}
		
}		
	

	
	
	
	
	
	
void Update(){

if(generate == true){

if(activate == true){
StartCoroutine("Spawn");
}
}

}
	
	
	
	
	
IEnumerator Spawn (){

activate = false;
GameObject go = Instantiate(Resources.Load("BuildingSpotLowPoly")) as GameObject;
go.gameObject.transform.position = transform.position;

GameObject tmp = GameObject.Find("GeneratedCity");
go.gameObject.transform.parent = tmp.gameObject.transform;

yield return new WaitForSeconds(0.05f);
Destroy(gameObject);

}
	
	
	
}
