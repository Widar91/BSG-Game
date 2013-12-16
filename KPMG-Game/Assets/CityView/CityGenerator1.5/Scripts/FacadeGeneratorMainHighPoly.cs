using UnityEngine;
using System.Collections;

public class FacadeGeneratorMainHighPoly: MonoBehaviour {
	
	
	
public GameObject[] entrances;
public GameObject[] windows;
public GameObject[] props;

public Transform SpawnerFront;
public Transform Spawner2;
public Transform Spawner3;
public Transform SpawnerBack;	

public Transform SpawnerFrontB;
public Transform Spawner2B;
public Transform Spawner3B;
public Transform SpawnerBackB;
	
public bool lights = false;
	
GameObject entranceChosen;
GameObject entranceChosen2;
GameObject entranceChosenBack;
GameObject entranceChosenFront;
	
public GameObject windowChosen;

GameObject propChosen;
	
	
int choose = 1;	
int choose2 = 1;
int chooseFront = 1;	
int chooseBack = 1;		
int chooseProp = 1;
	
private float X = 1;
private float Y = 1;
	
int chooseFacade;

int XCount = 7;
int X2Count = 7;
int ZCount = 7;	
int Z2Count = 7;	
	
private bool door1 = false;	
private bool door2 = false;		
private bool door3 = false;		
private bool door4 = false;		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
void Start (){
	
choose = Random.Range(0, windows.Length);							
windowChosen = windows[choose];
		

		
			
RegenerateX();
RegenerateX2();
RegenerateZ();
RegenerateZ2();
		
StartCoroutine("Destroying");

}
	
	
	
	
	
	
	
	
	
	
	
	
	
void Update(){
		
X = transform.localScale.x;
Y = transform.localScale.y;		
}
	
	
	
	
	
	
	
	
	
	
	
	
	
void random1(){
		
choose = Random.Range(0, entrances.Length);	
entranceChosen = entrances[choose];
}
	
void random2(){
		
choose2 = Random.Range(0, entrances.Length);	
entranceChosen2 = entrances[choose2];
}
	
void randomBack(){
		
chooseBack = Random.Range(0, entrances.Length);	
entranceChosenBack = entrances[chooseBack];
}	
	
void randomFront(){
		
chooseFront = Random.Range(0, entrances.Length);	
entranceChosenFront = entrances[chooseFront];
}	
	
	
void randomProp(){
		
chooseProp = Random.Range(0, props.Length);
propChosen = props[chooseProp];
}
	
	
	
	
	
	
	
	
	
	
	
void RegenerateZ(){
			
		
if(ZCount >= 1){
			
StartCoroutine("GenerateZ");
}
		
if(ZCount <= 0){
			
StopCoroutine("GenerateZ");
}
	
}	
	
void RegenerateZ2(){
		
if(Z2Count >= 1){
			
StartCoroutine("GenerateZ2");
}
		
if(Z2Count <= 0){
			
StopCoroutine("GenerateZ2");
}

}
	
	
void RegenerateX(){
		
if(XCount >= 1){
			
StartCoroutine("GenerateX");
}
		
if(XCount <= 0){
			
StopCoroutine("GenerateX");
}

}
	
	
void RegenerateX2(){
		
if(X2Count >= 1){
			
StartCoroutine("GenerateX2");
}
		
if(X2Count <= 0){
			
StopCoroutine("GenerateX2");
}
	
}		
		

	
	
	
	
	
	
	
	
	
	
	
IEnumerator GenerateZ (){

yield return new WaitForSeconds(0.1f);
		
randomFront();	


		
		
if(entranceChosenFront.gameObject.tag == "Door" && door1 == false){
			
ZCount --;
randomProp();

GameObject goProp = (GameObject)Instantiate(props[chooseProp]);
		
goProp.transform.gameObject.name = propChosen.gameObject.name;
goProp.transform.parent = transform;
goProp.transform.position = SpawnerFrontB.transform.position;
goProp.transform.rotation = SpawnerFrontB.transform.rotation;
goProp.transform.Translate(0, 0, Random.Range(0, 0.001f));
door1 = true;
			
GameObject go = (GameObject)Instantiate(entrances[chooseFront]);
		
go.transform.gameObject.name = entranceChosenFront.gameObject.name;
go.transform.parent = transform;
go.transform.position = SpawnerFront.transform.position;
go.transform.rotation = SpawnerFront.transform.rotation;
			
SpawnerFront.transform.Translate(-0.85f, 0, 0);
			
RegenerateZ();	
}
		
if(entranceChosenFront.gameObject.tag == "Untagged"){
			
ZCount --;
randomProp();

GameObject goProp = (GameObject)Instantiate(props[chooseProp]);
		
goProp.transform.gameObject.name = propChosen.gameObject.name;
goProp.transform.parent = transform;
goProp.transform.position = SpawnerFrontB.transform.position;
goProp.transform.rotation = SpawnerFrontB.transform.rotation;
goProp.transform.Translate(0, 0, Random.Range(0, 0.001f));
			
GameObject go = (GameObject)Instantiate(entrances[chooseFront]);
	
			
go.transform.gameObject.name = entranceChosenFront.gameObject.name;
go.transform.parent = transform;
go.transform.position = SpawnerFront.transform.position;
go.transform.rotation = SpawnerFront.transform.rotation;
			
SpawnerFront.transform.Translate(-0.85f, 0, 0);
			
RegenerateZ();	
}
		
		
if(entranceChosenFront.gameObject.tag == "Door" && door1 == true){
	
			
RegenerateZ();	

}	
	

}
	
	
	
	
	
	
	
	
IEnumerator GenerateZ2 (){

yield return new WaitForSeconds(0.1f);
		
randomBack();	
		
		
if(entranceChosenBack.gameObject.tag == "Door" && door2 == false){
			
Z2Count --;
randomProp();

GameObject goProp = (GameObject)Instantiate(props[chooseProp]);
		
goProp.transform.gameObject.name = propChosen.gameObject.name;
goProp.transform.parent = transform;
goProp.transform.position = SpawnerBackB.transform.position;
goProp.transform.rotation = SpawnerBackB.transform.rotation;	
goProp.transform.Translate(0, 0, Random.Range(0, 0.001f));
			
door2 = true;
			
GameObject go = (GameObject)Instantiate(entrances[chooseBack]);
		
			
go.transform.gameObject.name = entranceChosenBack.gameObject.name;
go.transform.parent = transform;
go.transform.position = SpawnerBack.transform.position;
go.transform.rotation = SpawnerBack.transform.rotation;
			
SpawnerBack.transform.Translate(-0.85f, 0, 0);
			
RegenerateZ2();	
}
		
if(entranceChosenBack.gameObject.tag == "Untagged"){
			
Z2Count --;
randomProp();

GameObject goProp = (GameObject)Instantiate(props[chooseProp]);
		
goProp.transform.gameObject.name = propChosen.gameObject.name;
goProp.transform.parent = transform;
goProp.transform.position = SpawnerBackB.transform.position;
goProp.transform.rotation = SpawnerBackB.transform.rotation;
goProp.transform.Translate(0, 0, Random.Range(0, 0.001f));
			
GameObject go = (GameObject)Instantiate(entrances[chooseBack]);

go.transform.gameObject.name = entranceChosenBack.gameObject.name;
go.transform.parent = transform;
go.transform.position = SpawnerBack.transform.position;
go.transform.rotation = SpawnerBack.transform.rotation;
			
SpawnerBack.transform.Translate(-0.85f, 0, 0);
			
RegenerateZ2();	
}
		
		
if(entranceChosenBack.gameObject.tag == "Door" && door2 == true){
	
			
RegenerateZ2();	

}	
		
}
	
	
	
	
	
	
	
	
IEnumerator GenerateX (){

yield return new WaitForSeconds(0.1f);
		
random1();	

	
if(entranceChosen.gameObject.tag == "Door" && door3 == false){
			
XCount --;
randomProp();

GameObject goProp = (GameObject)Instantiate(props[chooseProp]);
		
goProp.transform.gameObject.name = propChosen.gameObject.name;
goProp.transform.parent = transform;
goProp.transform.position = Spawner2B.transform.position;
goProp.transform.rotation = Spawner2B.transform.rotation;	
goProp.transform.Translate(0, 0, Random.Range(0, 0.001f));
			
door3 = true;
			
GameObject go = (GameObject)Instantiate(entrances[choose]);
			
			
go.transform.gameObject.name = entranceChosen.gameObject.name;
go.transform.parent = transform;
go.transform.position = Spawner2.transform.position;
go.transform.rotation = Spawner2.transform.rotation;
			
Spawner2.transform.Translate(-0.85f, 0, 0);
			
RegenerateX();	
}
		
if(entranceChosen.gameObject.tag == "Untagged"){
			
XCount --;
randomProp();

GameObject goProp = (GameObject)Instantiate(props[chooseProp]);
		
goProp.transform.gameObject.name = propChosen.gameObject.name;
goProp.transform.parent = transform;
goProp.transform.position = Spawner2B.transform.position;
goProp.transform.rotation = Spawner2B.transform.rotation;	
goProp.transform.Translate(0, 0, Random.Range(0, 0.001f));
			
GameObject go = (GameObject)Instantiate(entrances[choose]);
			
			
go.transform.gameObject.name = entranceChosen.gameObject.name;
go.transform.parent = transform;
go.transform.position = Spawner2.transform.position;
go.transform.rotation = Spawner2.transform.rotation;
			
Spawner2.transform.Translate(-0.85f, 0, 0);
			
RegenerateX();	
}
		
		
if(entranceChosen.gameObject.tag == "Door" && door3 == true){
	
			
RegenerateX();	

}	
		
}
	
	
	
	
	
	
	
	
	
IEnumerator GenerateX2 (){

yield return new WaitForSeconds(0.1f);
		
random2();	
		
if(entranceChosen2.gameObject.tag == "Door" && door4 == false){
			
X2Count --;
randomProp();

GameObject goProp = (GameObject)Instantiate(props[chooseProp]);
		
goProp.transform.gameObject.name = propChosen.gameObject.name;
goProp.transform.parent = transform;
goProp.transform.position = Spawner3B.transform.position;
goProp.transform.rotation = Spawner3B.transform.rotation;		
goProp.transform.Translate(0, 0, Random.Range(0, 0.001f));
			
door4 = true;
			
GameObject go = (GameObject)Instantiate(entrances[choose2]);
			
			
go.transform.gameObject.name = entranceChosen2.gameObject.name;
go.transform.parent = transform;
go.transform.position = Spawner3.transform.position;
go.transform.rotation = Spawner3.transform.rotation;
			
Spawner3.transform.Translate(-0.85f, 0, 0);
			
RegenerateX2();	
}
		
if(entranceChosen2.gameObject.tag == "Untagged"){
			
X2Count --;
randomProp();

GameObject goProp = (GameObject)Instantiate(props[chooseProp]);
		
goProp.transform.gameObject.name = propChosen.gameObject.name;
goProp.transform.parent = transform;
goProp.transform.position = Spawner3B.transform.position;
goProp.transform.rotation = Spawner3B.transform.rotation;	
goProp.transform.Translate(0, 0, Random.Range(0, 0.001f));
			
GameObject go = (GameObject)Instantiate(entrances[choose2]);
			
			
go.transform.gameObject.name = entranceChosen2.gameObject.name;
go.transform.parent = transform;
go.transform.position = Spawner3.transform.position;
go.transform.rotation = Spawner3.transform.rotation;
			
Spawner3.transform.Translate(-0.85f, 0, 0);
			
RegenerateX2();	
}
		
		
if(entranceChosen2.gameObject.tag == "Door" && door4 == true){
	
			
RegenerateX2();	

}						
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
IEnumerator Destroying (){

yield return new WaitForSeconds(5);
		
Destroy(SpawnerFront.transform.gameObject);	
Destroy(SpawnerBack.transform.gameObject);	
Destroy(Spawner2.transform.gameObject);	
Destroy(Spawner3.transform.gameObject);	
Destroy(this);
		
				
}
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
}