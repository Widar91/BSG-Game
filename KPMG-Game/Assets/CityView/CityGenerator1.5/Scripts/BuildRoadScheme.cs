using UnityEngine;
using System.Collections;

public class BuildRoadScheme : MonoBehaviour {
	
public GameObject line;	
public GameObject crossRoad;	
public GameObject angleRoad;
public GameObject TjunctionRoad;
	
public bool frontCollided = false;
public bool backCollided = false;
public bool leftCollided = false;
public bool rightCollided = false;
	
GameObject roadPref;	
	
public bool generate = false;
	
public bool destroying = false;	
	
public bool activate = true;
		
private bool colored = false;	
	
public bool useRoad = false;
public bool useBuilding = false;
public bool usePark = false;
public bool useParking = false;		
	
public string usedName = "3DButton";		
	
	
	
	
	
	
	
	
void OnMouseDown(){

if(useRoad == true){
if(colored == false){
gameObject.renderer.material.color = Color.cyan;	
gameObject.name = usedName;	
colored = true;
}

else{
gameObject.renderer.material.color = Color.white;	
gameObject.name = "3DButton";
colored = false;
}
}
		
		
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
		
		
		
if(usePark == true){
if(colored == false){
gameObject.renderer.material.color = Color.green;	
gameObject.name = usedName;	
colored = true;
}

else{
gameObject.renderer.material.color = Color.white;	
gameObject.name = "3DButton";
colored = false;
}
}
		
		
		
if(useParking == true){
if(colored == false){
gameObject.renderer.material.color = Color.yellow;	
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
		
		
		
		
if(destroying == true){

Destroy(gameObject);
}
		
		
		
		
		
		
		
if(leftCollided == false && rightCollided == false && backCollided == false && frontCollided == false){
			
if(generate == true){
Destroy(gameObject);				
}
}
		
		
		
		
		
		
if(frontCollided == true && backCollided == false && leftCollided == false && rightCollided == false|| backCollided == true && frontCollided == false && leftCollided == false && rightCollided == false){
			
roadPref = line;
	
if(generate == true){

if(activate == true){
StartCoroutine("Spawn1");
}

}
}
		
		
		
		
		
if(frontCollided == false && backCollided == false && leftCollided == true && rightCollided == false|| backCollided == false && frontCollided == false && leftCollided == false && rightCollided == true){
			
roadPref = line;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn2");
}
}
}
		
		
		
		
		
if(leftCollided == true && rightCollided == true && backCollided == true && frontCollided == true){

roadPref = crossRoad;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn1");
}
}
}
		
		
		
		
		
if(leftCollided == true && rightCollided == true && backCollided == true && frontCollided == false){

roadPref = TjunctionRoad;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn1");
}
}
}
		
		
		
		
		
if(leftCollided == true && rightCollided == true && frontCollided == true && backCollided == false){

roadPref = TjunctionRoad;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn3");
}
}
}
	
		
		
		
		
		
if(frontCollided == true && backCollided == true && leftCollided == true && rightCollided == false){

roadPref = TjunctionRoad;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn2");
}
}
}
		
		
		
		
		
if(frontCollided == false && backCollided == false && leftCollided == true && rightCollided == true){

roadPref = line;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn4");
}
}
}	
		
		
		
		
		
if(frontCollided == true && backCollided == true && leftCollided == false && rightCollided == false){

roadPref = line;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn1");
}
}
}	
		
		
		
		
		
if(frontCollided == true && backCollided == true && rightCollided == true && leftCollided == false){

roadPref = TjunctionRoad;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn4");
}
}
}
	
	
	
		
		
if(frontCollided == true && rightCollided == true && leftCollided == false && backCollided == false){
			
roadPref = angleRoad;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn4");
}
}			
}

	
		
		
		
		
if(frontCollided == true && leftCollided == true && rightCollided == false && backCollided == false){
			
roadPref = angleRoad;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn3");
}
}				
}
	
		
	
		
		
		
if(backCollided == true && rightCollided == true && leftCollided == false && frontCollided == false){
			
roadPref = angleRoad;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn1");
}
}				
}
	
		
		
	
		
		
if(backCollided == true && leftCollided == true && rightCollided == false && frontCollided == false){
			
roadPref = angleRoad;
			
if(generate == true){

if(activate == true){
StartCoroutine("Spawn2");
}
}					
}
		
		
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
IEnumerator Spawn1(){

activate = false;
GameObject go = Instantiate(roadPref) as GameObject;
go.gameObject.transform.position = transform.position;
		
GameObject tmp = GameObject.Find("GeneratedCity");
go.gameObject.transform.parent = tmp.gameObject.transform;
		
yield return new WaitForSeconds(0.01f);
Destroy(gameObject);

}
	
IEnumerator Spawn2(){

activate = false;
GameObject go = Instantiate(roadPref) as GameObject;
go.gameObject.transform.Rotate(0, 90, 0);
go.gameObject.transform.position = transform.position;
		
GameObject tmp = GameObject.Find("GeneratedCity");
go.gameObject.transform.parent = tmp.gameObject.transform;
		
yield return new WaitForSeconds(0.01f);
Destroy(gameObject);

}
	
IEnumerator Spawn3(){
		
activate = false;
GameObject go = Instantiate(roadPref) as GameObject;
go.gameObject.transform.Rotate(0, 180, 0);
go.gameObject.transform.position = transform.position;
		
GameObject tmp = GameObject.Find("GeneratedCity");
go.gameObject.transform.parent = tmp.gameObject.transform;
		
yield return new WaitForSeconds(0.01f);
Destroy(gameObject);

}
	
IEnumerator Spawn4(){

activate = false;
GameObject go = Instantiate(roadPref) as GameObject;
go.gameObject.transform.Rotate(0, 270, 0);
go.gameObject.transform.position = transform.position;
		
GameObject tmp = GameObject.Find("GeneratedCity");
go.gameObject.transform.parent = tmp.gameObject.transform;
		
yield return new WaitForSeconds(0.01f);
Destroy(gameObject);

}
	

	
}