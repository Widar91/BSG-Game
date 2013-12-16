using UnityEngine;
using System.Collections;

public class FacadeGeneratorMain : MonoBehaviour {
	
	
public GameObject buildingFacade;
	
public Material[] entrances;
public Material[] facades;
	
public GameObject[] entranceProps;
	
public Transform propSpawnerFront;
public Transform propSpawner2;
public Transform propSpawner3;
public Transform propSpawnerBack;	

Material entranceChosen;
public Material facadeChosen;
	
private int choose;	
private int choose2;
private int choose3;
	
private float X = 0;
private float Z = 0;
	
int chooseFacade;


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
public void Start (){
		
choose = Random.Range(0, entrances.Length);			
choose2 = Random.Range(0, facades.Length);		
		
entranceChosen = entrances[choose];
facadeChosen = facades[choose2];

StartCoroutine("Generate");

StartCoroutine("Destroying");

StartCoroutine("Props");
}
	
	
	
	
	
	
	
	
	
	
	
void Update(){
		
X = gameObject.transform.localScale.x;		
Z = gameObject.transform.localScale.z;		
}
	
	
	
	
	
	
	
	
	
	
	
	
	
public IEnumerator Generate (){

yield return new WaitForSeconds(2);

buildingFacade.renderer.material = entranceChosen;
		
				
}
	
	
	
	
	
	
	
	
	
	
	
	
	
IEnumerator Destroying (){

yield return new WaitForSeconds(5.5f);

Destroy(propSpawnerFront.transform.gameObject);	
Destroy(propSpawnerBack.transform.gameObject);	
Destroy(propSpawner2.transform.gameObject);	
Destroy(propSpawner3.transform.gameObject);	
Destroy(this);
		
				
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
IEnumerator Props (){
		
			
		
yield return new WaitForSeconds(0.5f);	
	
		
		
propSpawnerFront.transform.Translate(-X /3, 0, 0);
		
choose3 = Random.Range(0, entranceProps.Length);

GameObject go = (GameObject)Instantiate(entranceProps[choose3]);


go.transform.position = propSpawnerFront.transform.position;
go.transform.rotation = propSpawnerFront.transform.rotation;	
go.transform.parent = transform;
		
propSpawnerFront.transform.Translate(-X /3, 0, 0);
		
choose3 = Random.Range(0, entranceProps.Length);

		
		
GameObject goB = (GameObject)Instantiate(entranceProps[choose3]);
		
goB.transform.position = propSpawnerFront.transform.position;
goB.transform.rotation = propSpawnerFront.transform.rotation;
goB.transform.parent = transform;
		

		


		
		
yield return new WaitForSeconds(0.5f);		
		
		
		
		
propSpawner2.transform.Translate(X /3, 0, 0);	
		
		
choose3 = Random.Range(0, entranceProps.Length);

		
GameObject go2 = (GameObject)Instantiate(entranceProps[choose3]);
		
		
go2.transform.position = propSpawner2.transform.position;
go2.transform.rotation = propSpawner2.transform.rotation;
go2.transform.parent = transform;
		
propSpawner2.transform.Translate(X /3, 0, 0);
		
choose3 = Random.Range(0, entranceProps.Length);
		
		
GameObject go2B = (GameObject)Instantiate(entranceProps[choose3]);

		
go2B.transform.position = propSpawner2.transform.position;
go2B.transform.rotation = propSpawner2.transform.rotation;
go2B.transform.parent = transform;
		
		
		
yield return new WaitForSeconds(0.5f);		
	
		
		
		
propSpawner3.transform.Translate(-X /3, 0, 0);		
		
choose3 = Random.Range(0, entranceProps.Length);

		
GameObject go3 = (GameObject)Instantiate(entranceProps[choose3]);
		
		
go3.transform.position = propSpawner3.transform.position;
go3.transform.rotation = propSpawner3.transform.rotation;
go3.transform.parent = transform;
		
		
propSpawner3.transform.Translate(-X /3, 0, 0);		
		
choose3 = Random.Range(0, entranceProps.Length);

		
GameObject go3B = (GameObject)Instantiate(entranceProps[choose3]);

		
go3B.transform.position = propSpawner3.transform.position;
go3B.transform.rotation = propSpawner3.transform.rotation;
go3B.transform.parent = transform;
		

		
yield return new WaitForSeconds(0.5f);	
	
		
		
propSpawnerBack.transform.Translate(-X /3, 0, 0);
		
choose3 = Random.Range(0, entranceProps.Length);

GameObject go4 = (GameObject)Instantiate(entranceProps[choose3]);


go4.transform.position = propSpawnerBack.transform.position;
go4.transform.rotation = propSpawnerBack.transform.rotation;	
go4.transform.parent = transform;
		
propSpawnerBack.transform.Translate(-X /3, 0, 0);
		
choose3 = Random.Range(0, entranceProps.Length);

		
		
GameObject go4B = (GameObject)Instantiate(entranceProps[choose3]);
		
go4B.transform.position = propSpawnerBack.transform.position;
go4B.transform.rotation = propSpawnerBack.transform.rotation;
go4B.transform.parent = transform;
		
}	
	
	
	
	
	
	
	
	
}