using UnityEngine;
using System.Collections;

public class ParkGenerator : MonoBehaviour {

public Transform marker;
	
public Transform[] trees;
public Transform[] props;
	
public int minTrees;
public int maxTrees;

public int minProps;
public int maxProps;
	
int random1 = 1;
int random2 = 1;	
	
int randomTotal = 1;
int randomTotal2 = 1;	
	
float X = 3.7f;
float Z = 3.7f;
	
int count = 1;
int count2 = 1;	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
void Start(){
		
randomTotal = Random.Range(minTrees, maxTrees);		
randomTotal2 = Random.Range(minProps, maxProps);
		
count = randomTotal;
count2 = randomTotal2;		
		
Regenerate();
}
	
	
	
	
	
	
	
	
	
	
	
	
void Regenerate(){
		
if(count > 0){

BuildTrees();
}
		
if(count2 > 0){
			
BuildProps();			
}
		
}

	
	
	
	
	
	
	
	
	
	
	
	
void BuildTrees(){
		
random1 = Random.Range(0, trees.Length);
		
marker.transform.position = transform.position;
marker.transform.Translate(Random.Range(-X, X), 0,Random.Range(-Z, Z));
		
GameObject go = (GameObject)Instantiate(Resources.Load(trees[random1].gameObject.name));	
go.transform.position = marker.position;
go.transform.Rotate(0, Random.Range(0, 360), 0);		
go.transform.parent = transform;
count --;
		
Regenerate();
}
	
	
	
	
	
	
	
	
	
	
	
	
void BuildProps(){
		
random2 = Random.Range(0, props.Length);
		
marker.transform.position = transform.position;
marker.transform.Translate(Random.Range(-X, X), 0,Random.Range(-Z, Z));
		
GameObject go2 = (GameObject)Instantiate(Resources.Load(props[random2].gameObject.name));		
go2.transform.position = marker.position;
go2.transform.rotation = marker.rotation;	
go2.transform.parent = transform;
count2 --;		
	
Regenerate();
}
	
	
	
	
	
}
