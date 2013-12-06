using UnityEngine;
using System.Collections;

public class WorldCameraManager : MonoBehaviour {
	//public float rotateSpeed = 0.1f;
	private bool hasGrabbedPoint = false;
	private Vector3 grabbedPoint;
	private Vector3 lastTargetPoint;
	public Camera camera;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
		// Rotate Earth on mouse drag
		if (Input.GetMouseButton (0)) {         
			if (!hasGrabbedPoint) {
					hasGrabbedPoint = true;                                             
					grabbedPoint = getTouchedPoint ();
			} else {
					Vector3 targetPoint = getTouchedPoint ();
					if (!targetPoint.Equals(Vector3.zero)) {
						lastTargetPoint = targetPoint;
						Quaternion rot = Quaternion.FromToRotation (grabbedPoint, lastTargetPoint);
						transform.localRotation *= rot;  
					}           
			}
		} else {
				hasGrabbedPoint = false;
				lastTargetPoint = Vector3.zero;
		}
		
		// Zoom in or out on Earth
		float newCamPos = camera.transform.position.z - Input.GetAxis("Mouse ScrollWheel");
		if (newCamPos < -3f)
			newCamPos = -3f;
		else if (newCamPos > -2f)
			newCamPos = -2f;
		camera.transform.position = new Vector3(0f, 0f, newCamPos);
			
			
		
	}

	Vector3 getTouchedPoint()
	{
		// Check where the mouse touches Earth
		RaycastHit[] hits = Physics.RaycastAll (camera.ScreenPointToRay(Input.mousePosition));
		foreach (RaycastHit hit in hits) {
			if (hit.collider.gameObject.name.Equals("Earth"))
				return transform.InverseTransformPoint(hit.point);
		} 
		return Vector3.zero;
			
	}

}
