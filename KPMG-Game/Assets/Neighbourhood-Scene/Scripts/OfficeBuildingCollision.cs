using UnityEngine;
using System.Collections;

public class OfficeBuildingCollision : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		RaycastHit hit;
		if (Physics.Raycast(camera.ScreenPointToRay(Input.mousePosition), out hit)) {
			if (hit.collider.gameObject.name.Equals("Skyscraper")) {		
				if(Input.GetMouseButtonDown(0))
					Application.LoadLevel("Office");
			}
		} 
	}
}
