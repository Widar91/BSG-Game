using UnityEngine;
using System.Collections;

public class CameraBehaviour : MonoBehaviour {

	public Vector3 leftmost = new Vector3(20.26f, 320f, 0f);
	public Vector3 rightmost = new Vector3(20.26f, 330f, 0f);
	public float rotationSpeed = 0.3f;


	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

		Vector3 mousePosition = Input.mousePosition;
		if (mousePosition.x < Screen.width*0.1)
		{ 
			// Move left
			Quaternion to = Quaternion.Euler(leftmost);//Quaternion.AngleAxis(310, new Vector3(0,1,0));
			Quaternion rotation = Quaternion.RotateTowards(camera.transform.rotation, to, rotationSpeed);
			camera.transform.rotation = rotation;
		}
		if (mousePosition.x > Screen.width*0.9)
		{
			// Move right
			Quaternion to = Quaternion.Euler(rightmost);//Quaternion.AngleAxis(330, new Vector3(0,1,0));
			Quaternion rotation = Quaternion.RotateTowards(camera.transform.rotation, to, rotationSpeed);
			camera.transform.rotation = rotation;
		}
	}
}
