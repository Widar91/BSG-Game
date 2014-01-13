using UnityEngine;
using System.Collections;

public class CityGeneratorLowPoly : MonoBehaviour {

	
public int column = 16;
public int row = 16;
	
public Transform button3D;
	
int columnBase = 1;
	
public Transform Marker;

public bool end = false;	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
void Start () {

columnBase = column;
			
StartCoroutine("GenerateColumn");

}
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	

void RegenerateColumn(){
		

StartCoroutine("GenerateColumn");		

	
}
	
	
	
	
	
	
	
	
	
	
	
	
IEnumerator GenerateColumn (){
	
		
if(column > 0){
			
Marker.transform.Translate(0, 0, 7.42f);
			
GameObject go = Instantiate(Resources.Load("3DButtonLowPoly")) as GameObject;

go.gameObject.transform.position = Marker.position;
go.gameObject.transform.parent = button3D.transform;			

			
column --;

		
}
			
		
if(column <= 0){

column = columnBase;
			
StartCoroutine("GenerateRow");

}
		
	
			
yield return new WaitForSeconds(0.001f);
		
RegenerateColumn();


}
	
	
	
	
	
	
	
	
	
	
	
	
	
IEnumerator GenerateRow (){
		
StopCoroutine("GenerateColumn");
		
if(row > 0){

			
transform.Translate(7.32f, 0, 0);
			
Marker.transform.position = transform.position;
			


			
row --;

		
}	
		
if(row <= 0){

StopAllCoroutines();
end = true;
}
		
		
yield return new WaitForSeconds(0.001f);
		
RegenerateColumn();
		

		

	
		
	
}	
	
	
	
	
	
	
}