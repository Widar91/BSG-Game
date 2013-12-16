using UnityEngine;
using System.Collections;

public class BuildingGeneratorHighPoly : MonoBehaviour {

	
public Transform Marker;

public bool nightMode = false;
	
public int shopPercentage = 50;
	
private int floors = 0;

public int minFloors = 2;
public int maxFloors = 6;
	
private float randomMain = 0;
	
private float randomMin = 1;
private float randomMax = 101;
	
GameObject goMain;
	
private bool buildFloors = false;


	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
void Start () {

		
randomMain = Random.Range(randomMin, randomMax);
		
InvokeRepeating("FloorBuild", 0, 0.01f);
		
StartCoroutine("Initialize");

}		
		

	
	
IEnumerator Initialize (){
		
yield return new WaitForSeconds(Random.Range(0, 2));
StartCoroutine("Generate");		
}
	
	
	
	
	
	
	
	
	
IEnumerator Generate (){

		
	yield return new WaitForSeconds(0.5f);

	if(randomMain <= shopPercentage && randomMain > 0){
    StartCoroutine("BuildingCommercial");
	}
			
	if(randomMain > shopPercentage && randomMain > 0){
	StartCoroutine("BuildingApartment");
	}
	
    if(randomMain == 0){
	StartCoroutine("BuildingApartment");
	}

}	
	
	
	
	
	
	

	
	
	
	
	
IEnumerator BuildingApartment(){
	

	
		
floors = Random.Range(minFloors, maxFloors);

		
      goMain = (GameObject)Instantiate(Resources.Load("ApartmentEntranceHighPoly"));
      
	if(nightMode == true){
     goMain.gameObject.GetComponent<FacadeGeneratorMainHighPoly>().lights = true;
	}	
	   goMain.gameObject.transform.position = Marker.transform.position;
       goMain.gameObject.transform.rotation = Marker.transform.rotation;
		


		
	   goMain.gameObject.transform.Translate(0, 0, Random.Range(0, 0.01f));
		
		
       Marker.transform.position = goMain.gameObject.transform.position;
		
       GameObject tmp = GameObject.Find("GeneratedCity");
	   goMain.gameObject.transform.parent = tmp.gameObject.transform;
					
   yield return new WaitForSeconds(0.5f);
		
Marker.transform.Translate(0, 0.5f, 0);		
	
buildFloors = true;
}
	
	
	
	
	
	
	
	
	
	

IEnumerator BuildingCommercial(){
	


floors = Random.Range(minFloors, maxFloors);


      goMain = (GameObject)Instantiate(Resources.Load("CommercialEntranceHighPoly"));

	if(nightMode == true){
     goMain.gameObject.GetComponent<FacadeGeneratorMainHighPoly>().lights = true;
	}	
	   goMain.gameObject.transform.position = Marker.transform.position;
       goMain.gameObject.transform.rotation = Marker.transform.rotation;
		
		
	   goMain.gameObject.transform.Translate(0, 0, Random.Range(0, 0.01f));

		
	   Marker.transform.position = goMain.gameObject.transform.position;
	   
	   GameObject tmp = GameObject.Find("GeneratedCity");
	   goMain.gameObject.transform.parent = tmp.gameObject.transform;

   yield return new WaitForSeconds(0.2f);
		
Marker.transform.Translate(0, 0.5f, 0);
		
buildFloors = true;
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
void FloorBuild(){

if(buildFloors == true){
if(floors > 0){
								
Marker.transform.Translate(0, 1f, 0);
				

GameObject go2 = (GameObject)Instantiate(Resources.Load("FloorHighPoly"));

go2.transform.position = Marker.transform.position;
go2.transform.rotation = Marker.transform.rotation;
go2.transform.parent = goMain.gameObject.transform;	
floors --;
}
			
if(floors <= 0){
					
RoofBuild();
}
	
}
	
}
	
	
	
	
	
	
	
	
void RoofBuild(){

buildFloors = false;
		
Marker.transform.Translate(0, 1f, 0);
		
GameObject go3 = (GameObject)Instantiate(Resources.Load("RoofHighPoly"));


		
go3.transform.position = Marker.transform.position;					
go3.transform.rotation = Marker.transform.rotation;
go3.transform.parent = goMain.gameObject.transform;	

StartCoroutine("FinalDestroy");
}
	
	
	
	
	
	
	
	
	
	
IEnumerator FinalDestroy (){
		
yield return new WaitForSeconds(4);	
		
Destroy(Marker.transform.gameObject);
Destroy(gameObject);
}
	
	
	
	
	
	
	
	
}