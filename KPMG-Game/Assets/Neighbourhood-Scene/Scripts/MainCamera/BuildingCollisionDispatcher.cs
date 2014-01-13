using UnityEngine;
using System.Collections;

public class BuildingCollisionDispatcher : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		RaycastHit hit;
		if (Physics.Raycast(camera.ScreenPointToRay(Input.mousePosition), out hit)) {

			if(Input.GetMouseButtonDown(0)) {
				string collidedObject = hit.collider.gameObject.name;

				switch(collidedObject) {
					case "Office":
						Application.LoadLevel("Office");
						break;
					default:
						break;
				}
			}
		} 
	}
}
