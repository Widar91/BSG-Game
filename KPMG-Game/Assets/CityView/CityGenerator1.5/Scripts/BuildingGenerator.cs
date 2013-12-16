using UnityEngine;
using System.Collections;

public class BuildingGenerator : MonoBehaviour {

	
public Transform Marker;
	
public int shopPercentage = 50;
	
private int floors = 0;

public int minFloors = 2;
public int maxFloors = 6;
	
public int minWeight = 2;
public int maxWeight = 4;
	
public int minLenght = 2;
public int maxLenght = 2;
	
private float randomMain = 0;
	
private float randomMin = 1;
private float randomMax = 101;
	
GameObject goMain;
	
private bool buildFloors = false;
	
private float X = 0;	
private float Y = 0;	
private float Z = 0;	

	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
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

	if(randomMain <= shopPercentage){
    StartCoroutine("BuildingCommercial");
	}
			
	if(randomMain > shopPercentage){
	StartCoroutine("BuildingApartment");
	}
	


}	
	
	
	
	
	
	

	
	
	
	
	
IEnumerator BuildingApartment(){
	

	
		
floors = Random.Range(minFloors, maxFloors);

		
      goMain = (GameObject)Instantiate(Resources.Load("ApartmentEntrance"));
      
	   goMain.gameObject.transform.localScale += new Vector3(Random.Range(minWeight, maxWeight),0 ,Random.Range(minLenght, maxLenght));
		
	   goMain.gameObject.transform.position = Marker.transform.position;
       goMain.gameObject.transform.rotation = Marker.transform.rotation;
		

	   goMain.gameObject.transform.Translate(0, 0, -goMain.gameObject.transform.localScale.z / 4);
		
	   goMain.gameObject.transform.Translate(0, 0, Random.Range(0, 1f));
		
	   X = goMain.gameObject.transform.localScale.x;
	   Y = goMain.gameObject.transform.localScale.y;
	   Z = goMain.gameObject.transform.localScale.z;
		
       Marker.transform.position = goMain.gameObject.transform.position;
		
       GameObject tmp = GameObject.Find("GeneratedCity");
	   goMain.gameObject.transform.parent = tmp.gameObject.transform;
					
   yield return new WaitForSeconds(0.5f);
		
	
buildFloors = true;
}
	
	
	
	
	
	
	
	
	
	

IEnumerator BuildingCommercial(){
	


floors = Random.Range(minFloors, maxFloors);


      goMain = (GameObject)Instantiate(Resources.Load("CommercialEntrance"));

	
	   goMain.gameObject.transform.localScale += new Vector3(Random.Range(minWeight, maxWeight),0 ,Random.Range(minWeight, maxLenght));
		
	   goMain.gameObject.transform.position = Marker.transform.position;
       goMain.gameObject.transform.rotation = Marker.transform.rotation;
		
		
	   goMain.gameObject.transform.Translate(0, 0, -goMain.gameObject.transform.localScale.z / 4);
		
	   goMain.gameObject.transform.Translate(0, 0, Random.Range(0, 1f));
		
	   X = goMain.gameObject.transform.localScale.x;
	   Y = goMain.gameObject.transform.localScale.y;
	   Z = goMain.gameObject.transform.localScale.z;
		
	   Marker.transform.position = goMain.gameObject.transform.position;
	   
	   GameObject tmp = GameObject.Find("GeneratedCity");
	   goMain.gameObject.transform.parent = tmp.gameObject.transform;

   yield return new WaitForSeconds(0.5f);


buildFloors = true;
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
void FloorBuild(){

if(buildFloors == true){
if(floors > 0){
								
Marker.transform.Translate(0, 1f, 0);
				

GameObject go2 = (GameObject)Instantiate(Resources.Load("Floor"));
					
go2.gameObject.transform.localScale = new Vector3(X, Y, Z);

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
		
GameObject go3 = (GameObject)Instantiate(Resources.Load("Roof"));


go3.gameObject.transform.localScale = new Vector3(X - 0.01f, Y - 0.01f, Z - 0.01f);
		
go3.transform.position = Marker.transform.position;					
go3.transform.rotation = Marker.transform.rotation;
go3.transform.parent = goMain.gameObject.transform;	

StartCoroutine("FinalDestroy");
}
	
	
	
	
IEnumerator FinalDestroy (){
		
yield return new WaitForSeconds(1);	
		
Destroy(Marker.transform.gameObject);
Destroy(gameObject);
}
	
	
}