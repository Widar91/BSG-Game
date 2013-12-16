using UnityEngine;
using System.Collections;

public class FacadeGenerator : MonoBehaviour {

public GameObject buildingFacade;
	
Material facade;

		
	
	
	
	
	
void Start (){
		
StartCoroutine("Destroying");		
}
	
	
	
	
	
	
	
public void Update (){
		


facade = transform.parent.gameObject.GetComponent<FacadeGeneratorMain>().facadeChosen;
buildingFacade.renderer.material = facade;				
		
}
	
	
IEnumerator Destroying(){
		
yield return new WaitForSeconds(3f);
	
Destroy(this);
		
}
	
	
	
}