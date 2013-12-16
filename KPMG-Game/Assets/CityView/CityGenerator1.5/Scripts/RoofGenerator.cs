using UnityEngine;
using System.Collections;

public class RoofGenerator : MonoBehaviour {


public Material[] roofs;		

private int randomMain = 0;
private int random1 = 0;
private int random2 = 0;


	
	
	
	
	
	
	
	
	
void Start () {

random1 = Random.Range(0, roofs.Length);	
gameObject.renderer.material = roofs[random1];		
		
randomMain = Random.Range(0, 2);

gameObject.transform.Translate(0, Random.Range(0, 0.05f),0);
		
if(randomMain == 1){
StartCoroutine("Generate");		
}
		
else{
			
Destroy(this);
}
		
}
	
	

	
	
	
	
	
IEnumerator Generate (){
	
		
	
	
	GameObject go = (GameObject)Instantiate(Resources.Load("RoofProp"));
	
    random2 = Random.Range(0, roofs.Length);	
    go.gameObject.renderer.material = roofs[random2];	
		
	go.transform.position = gameObject.transform.position;
	
	
	go.gameObject.transform.localScale += new Vector3(Random.Range(0, gameObject.transform.localScale.x * 2) ,0 ,Random.Range(0, gameObject.transform.localScale.z * 2));
	

	go.transform.parent = transform;
		
	yield return new WaitForSeconds(1);
		
	Destroy(this);		
		
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
