using UnityEngine;
using System.Collections;

public class FacadeGeneratorHighPoly : MonoBehaviour {

public GameObject window;

public Transform windowSpawnerFront;
public Transform windowSpawner2;
public Transform windowSpawner3;
public Transform windowSpawnerBack;	
			
int windowXCount = 7;
int windowX2Count = 7;
int windowZCount = 7;	
int windowZ2Count = 7;		
	
	
int randomLight = 0;	
	
bool lights = false;	
	
	
	
	
	
	
	
	
	
	
		
void Start (){
		
window = gameObject.transform.parent.gameObject.GetComponent<FacadeGeneratorMainHighPoly>().windowChosen;				
RegenerateWindow();
	
		
if(gameObject.transform.parent.gameObject.GetComponent<FacadeGeneratorMainHighPoly>().lights == true){				

lights = true;
}			

StartCoroutine("Destroying");

}	

	
	

	
	
	
	
	
	
	
void RegenerateWindow(){
		
		
		
if(windowZCount >= 1){
			
StartCoroutine("GenerateZWindow");
}
		
if(windowZCount <= 0){
			
StopCoroutine("GenerateZWindow");
}
	
		
if(windowZ2Count >= 1){
			
StartCoroutine("GenerateZ2Window");
}
		
if(windowZ2Count <= 0){
			
StopCoroutine("GenerateZ2Window");
}
		
if(windowXCount >= 1){
			
StartCoroutine("GenerateXWindow");
}
		
if(windowXCount <= 0){
			
StopCoroutine("GenerateXWindow");
}
		
if(windowX2Count >= 1){
			
StartCoroutine("GenerateX2Window");
}
		
if(windowX2Count <= 0){
			
StopCoroutine("GenerateX2Window");
}
	
		
		
}
	
	
	
	
	
	
	
	
	
	
IEnumerator GenerateZWindow (){

windowZCount --;
		

randomLight = Random.Range(0, 2);		

if(lights == true){		
if(randomLight == 0){
				
GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name));

go.transform.parent = transform;
go.transform.position = windowSpawnerFront.transform.position;
go.transform.rotation = windowSpawnerFront.transform.rotation;	


windowSpawnerFront.transform.Translate(-0.85f, 0, 0);
}
			
if(randomLight == 1){
				
GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name + "N"));

go.transform.parent = transform;
go.transform.position = windowSpawnerFront.transform.position;
go.transform.rotation = windowSpawnerFront.transform.rotation;	


windowSpawnerFront.transform.Translate(-0.85f, 0, 0);
}
}

if(lights == false){	

GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name));
		

go.transform.parent = transform;
go.transform.position = windowSpawnerFront.transform.position;
go.transform.rotation = windowSpawnerFront.transform.rotation;	


windowSpawnerFront.transform.Translate(-0.85f, 0, 0);
}
		
		
		
yield return new WaitForSeconds(0.1f);
		
RegenerateWindow();						
}
	
	
	
	
	
	
	
	
	
	
	
	
	
IEnumerator GenerateZ2Window (){

windowZ2Count --;
	
randomLight = Random.Range(0, 2);		

if(lights == true){		
if(randomLight == 0){
				
GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name));
		

go.transform.parent = transform;
go.transform.position = windowSpawnerBack.transform.position;
go.transform.rotation = windowSpawnerBack.transform.rotation;	


windowSpawnerBack.transform.Translate(-0.85f, 0, 0);
}
			
if(randomLight == 1){
				
GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name + "N"));

go.transform.parent = transform;
go.transform.position = windowSpawnerBack.transform.position;
go.transform.rotation = windowSpawnerBack.transform.rotation;	


windowSpawnerBack.transform.Translate(-0.85f, 0, 0);
}
}

if(lights == false){	

GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name));
		

go.transform.parent = transform;
go.transform.position = windowSpawnerBack.transform.position;
go.transform.rotation = windowSpawnerBack.transform.rotation;	


windowSpawnerBack.transform.Translate(-0.85f, 0, 0);
}
yield return new WaitForSeconds(0.1f);

RegenerateWindow();						
}
	
	
	
	
	
	
	
	
	
	
	
	
	
IEnumerator GenerateXWindow (){

windowXCount --;
		
		
randomLight = Random.Range(0, 2);		

if(lights == true){		
if(randomLight == 0){
				
GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name));
		

go.transform.parent = transform;
go.transform.position = windowSpawner2.transform.position;
go.transform.rotation = windowSpawner2.transform.rotation;	


windowSpawner2.transform.Translate(-0.85f, 0, 0);
}
			
if(randomLight == 1){
				
GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name + "N"));

go.transform.parent = transform;
go.transform.position = windowSpawner2.transform.position;
go.transform.rotation = windowSpawner2.transform.rotation;	


windowSpawner2.transform.Translate(-0.85f, 0, 0);
}
}

if(lights == false){	

GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name));
		

go.transform.parent = transform;
go.transform.position = windowSpawner2.transform.position;
go.transform.rotation = windowSpawner2.transform.rotation;	


windowSpawner2.transform.Translate(-0.85f, 0, 0);
}


yield return new WaitForSeconds(0.1f);

RegenerateWindow();						
}
	
	
	
	
	
	
	
	
	
	
	
	
IEnumerator GenerateX2Window (){

windowX2Count --;
		
	
randomLight = Random.Range(0, 2);		

if(lights == true){		
if(randomLight == 0){
				
GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name));
		

go.transform.parent = transform;
go.transform.position = windowSpawner3.transform.position;
go.transform.rotation = windowSpawner3.transform.rotation;	


windowSpawner3.transform.Translate(-0.85f, 0, 0);
}
			
if(randomLight == 1){
				
GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name + "N"));

go.transform.parent = transform;
go.transform.position = windowSpawner3.transform.position;
go.transform.rotation = windowSpawner3.transform.rotation;	


windowSpawner3.transform.Translate(-0.85f, 0, 0);
}
}

if(lights == false){	

GameObject go = (GameObject)Instantiate(Resources.Load(window.gameObject.name));
		

go.transform.parent = transform;
go.transform.position = windowSpawner3.transform.position;
go.transform.rotation = windowSpawner3.transform.rotation;	


windowSpawner3.transform.Translate(-0.85f, 0, 0);
}


yield return new WaitForSeconds(0.1f);

RegenerateWindow();						
}
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
IEnumerator Destroying(){
		
yield return new WaitForSeconds(5f);
	
Destroy(this);
		
}
	
	
	
}