using UnityEngine;
using System.Collections;

public class BuildingGeneratorLowPoly : MonoBehaviour {


public float minLength = 1.0f;
public float maxLength = 1.0f;

public float minWidth = 1.0f;
public float maxWidth = 1.0f;
	
public float minHeight = 1.0f;
public float maxHeight = 1.0f;

public Material[] facades;
	
public GameObject[] buildingBase;
	
public bool highDensityMode = false;
	
public Transform Marker1;
public Transform Marker2;
public Transform Marker3;
public Transform Marker4;
public Transform Marker5;
	
private float randomLength = 1.0f;
private float randomWidth = 1.0f;
private float randomHeight = 1.0f;
	
private int randomFacade = 0;
private int randomBuilding = 0;
	
private int randomRotation = 0;
	
private GameObject goMain;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
void Start () {

randomFacade = Random.Range(0, facades.Length);
StartCoroutine("Generate");

}		
	
	
	

	
	
	
	
	
	
IEnumerator Generate (){

		
yield return new WaitForSeconds(0.2f);
		
		
		
		
		
if(highDensityMode == false){

randomBuilding = Random.Range(0, buildingBase.Length);
randomFacade = Random.Range(0, facades.Length);
randomLength = Random.Range(minLength, maxLength);
randomWidth = Random.Range(minWidth, maxWidth);
randomHeight = Random.Range(minHeight, maxHeight);
randomRotation = Random.Range(0,4);
			
GameObject goMain = (GameObject)Instantiate(buildingBase[randomBuilding]);
			
if(randomRotation == 1){
goMain.gameObject.transform.Rotate(0, 90, 0);
}
if(randomRotation == 2){
goMain.gameObject.transform.Rotate(0, -90, 0);
}
goMain.gameObject.transform.position = Marker1.transform.position;		
GameObject tmp = GameObject.Find("GeneratedCity");
goMain.gameObject.transform.parent = tmp.gameObject.transform;

goMain.gameObject.transform.localScale += new Vector3(randomWidth, randomHeight, randomLength);
			
Renderer rend = goMain.gameObject.renderer;
Material[] mats = new Material[rend.sharedMaterials.Length];	
			
mats[0] = facades[randomFacade];
rend.materials = mats;

}


		
		
		
		
		
if(highDensityMode == true){
			
randomBuilding = Random.Range(0, buildingBase.Length);
randomFacade = Random.Range(0, facades.Length);
randomLength = Random.Range(minLength, maxLength);
randomWidth = Random.Range(minWidth, maxWidth);
randomHeight = Random.Range(minHeight, maxHeight);
randomRotation = Random.Range(0,4);
			
GameObject goMain = (GameObject)Instantiate(buildingBase[randomBuilding]);
			
if(randomRotation == 1){
goMain.gameObject.transform.Rotate(0, 90, 0);
}
if(randomRotation == 2){
goMain.gameObject.transform.Rotate(0, -90, 0);
}

goMain.gameObject.transform.position = Marker2.transform.position;		
GameObject tmp = GameObject.Find("GeneratedCity");
goMain.gameObject.transform.parent = tmp.gameObject.transform;
			
goMain.gameObject.transform.localScale += new Vector3(randomWidth, randomHeight, randomLength);
			
			
Renderer rend = goMain.gameObject.renderer;
Material[] mats = new Material[rend.sharedMaterials.Length];	
			
mats[0] = facades[randomFacade];
rend.materials = mats;
		
	 			
			
randomBuilding = Random.Range(0, buildingBase.Length);
randomFacade = Random.Range(0, facades.Length);
randomLength = Random.Range(minLength, maxLength);
randomWidth = Random.Range(minWidth, maxWidth);
randomHeight = Random.Range(minHeight, maxHeight);
randomRotation = Random.Range(0,4);
		
GameObject goMain2 = (GameObject)Instantiate(buildingBase[randomBuilding]);
			
if(randomRotation == 1){
goMain2.gameObject.transform.Rotate(0, 90, 0);
}
if(randomRotation == 2){
goMain2.gameObject.transform.Rotate(0, -90, 0);
}
goMain2.gameObject.transform.position = Marker3.transform.position;		
GameObject tmp2 = GameObject.Find("GeneratedCity");
goMain2.gameObject.transform.parent = tmp2.gameObject.transform;
		
goMain2.gameObject.transform.localScale += new Vector3(randomWidth, randomHeight, randomLength);
			
Renderer rend2 = goMain2.gameObject.renderer;
Material[] mats2 = new Material[rend.sharedMaterials.Length];	

mats2[0] = facades[randomFacade];
rend2.materials = mats2;
			
			
			
			
randomBuilding = Random.Range(0, buildingBase.Length);
randomFacade = Random.Range(0, facades.Length);
randomLength = Random.Range(minLength, maxLength);
randomWidth = Random.Range(minWidth, maxWidth);
randomHeight = Random.Range(minHeight, maxHeight);
randomRotation = Random.Range(0,4);
	
GameObject goMain3 = (GameObject)Instantiate(buildingBase[randomBuilding]);
			
if(randomRotation == 1){
goMain3.gameObject.transform.Rotate(0, 90, 0);
}
if(randomRotation == 2){
goMain3.gameObject.transform.Rotate(0, -90, 0);
}
goMain3.gameObject.transform.position = Marker4.transform.position;		
GameObject tmp3 = GameObject.Find("GeneratedCity");
goMain3.gameObject.transform.parent = tmp3.gameObject.transform;

goMain3.gameObject.transform.localScale += new Vector3(randomWidth, randomHeight, randomLength);
			
Renderer rend3 = goMain3.gameObject.renderer;
Material[] mats3 = new Material[rend.sharedMaterials.Length];	
			
mats3[0] = facades[randomFacade];
rend3.materials = mats3;
			
			
			
randomBuilding = Random.Range(0, buildingBase.Length);
randomFacade = Random.Range(0, facades.Length);
randomLength = Random.Range(minLength, maxLength);
randomWidth = Random.Range(minWidth, maxWidth);
randomHeight = Random.Range(minHeight, maxHeight);
randomRotation = Random.Range(0,4);

GameObject goMain4 = (GameObject)Instantiate(buildingBase[randomBuilding]);
			
if(randomRotation == 1){
goMain4.gameObject.transform.Rotate(0, 90, 0);
}
if(randomRotation == 2){
goMain4.gameObject.transform.Rotate(0, -90, 0);
}
goMain4.gameObject.transform.position = Marker5.transform.position;		
GameObject tmp4 = GameObject.Find("GeneratedCity");
goMain4.gameObject.transform.parent = tmp4.gameObject.transform;
		
goMain4.gameObject.transform.localScale += new Vector3(randomWidth, randomHeight, randomLength);
			
Renderer rend4 = goMain4.gameObject.renderer;
Material[] mats4 = new Material[rend.sharedMaterials.Length];	
			
mats4[0] = facades[randomFacade];
rend4.materials = mats4;
				
}				
		
		
StartCoroutine("Destroying");
	
	
}

	
	
	

	
	
	
IEnumerator Destroying (){

yield return new WaitForSeconds(0.5f);
		
Destroy(Marker1.transform.gameObject);
Destroy(Marker2.transform.gameObject);
Destroy(Marker3.transform.gameObject);
Destroy(Marker4.transform.gameObject);
Destroy(Marker5.transform.gameObject);
Destroy(gameObject);
}






}