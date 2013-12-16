using UnityEngine;
using System.Collections;

public class BuildingGeneratorCustom : MonoBehaviour {


public GameObject[] BuildingPrefabs;
public Transform Marker;

private int randomMain = 0;
	
GameObject goMain;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
void Start () {

randomMain = Random.Range(0, BuildingPrefabs.Length);
StartCoroutine("Generate");

}		
	
	
	

	
	
	
	
	
	
IEnumerator Generate (){

		
yield return new WaitForSeconds(0.2f);

GameObject goMain = (GameObject)Instantiate(BuildingPrefabs[randomMain]);
		
goMain.gameObject.transform.position = Marker.transform.position;
		
GameObject tmp = GameObject.Find("GeneratedCity");
goMain.gameObject.transform.parent = tmp.gameObject.transform;

StartCoroutine("FinalDestroy");
}	
	
	
	
	
	
	

	
	
	
IEnumerator FinalDestroy (){
		
yield return new WaitForSeconds(1);	
		
Destroy(Marker.transform.gameObject);
Destroy(gameObject);
}
	
	
}