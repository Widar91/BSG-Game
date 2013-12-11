using UnityEngine;
using System.Collections;
using System;

public class DynamicBuildingHeight : MonoBehaviour {

	// Use this for initialization
	void Start () {
		Vector3 localScale = this.transform.localScale;
		this.transform.localScale = new Vector3 (localScale.x, 100f + getTopicScore(), localScale.z);
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	float getTopicScore () {
		//Mock function for building height
		System.Random random = new System.Random();
		float randomNumber = random.Next(0, 150);
		return randomNumber;
	}
}
