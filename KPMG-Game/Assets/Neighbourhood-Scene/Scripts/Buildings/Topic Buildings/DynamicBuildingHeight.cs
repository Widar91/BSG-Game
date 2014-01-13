using UnityEngine;
using System.Collections;
using System;

public class DynamicBuildingHeight : MonoBehaviour {

	// Use this for initialization
	void Start () {
		Vector3 localScale = this.transform.localScale;
		Vector3 position = this.transform.position;

		this.transform.localScale = new Vector3 (localScale.x, localScale.y + getTopicScore(), localScale.z);

		float posY = (localScale.y + getTopicScore ()) * position.y / localScale.y;
		this.transform.position = new Vector3 (position.x, posY, position.z);
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	int getTopicScore () {
		return ServerConnector.getInstance().getOffice3DScore();
	}
}
