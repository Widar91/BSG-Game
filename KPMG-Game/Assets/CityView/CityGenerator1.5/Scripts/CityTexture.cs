using UnityEngine;
using System.Collections;

public class CityTexture : MonoBehaviour {

	
	
	
	void Start (){
	
	StartCoroutine("Generate");
	}
	
	
	
	IEnumerator Generate (){
		
	yield return new WaitForSeconds(2);	
	Vector2 SS = renderer.material.mainTextureScale;
    SS.x = transform.localScale.x;
    SS.y = transform.localScale.y;
    renderer.material.mainTextureScale = SS;
    Destroy(this);	
		
		
		
		
		
	}
}
