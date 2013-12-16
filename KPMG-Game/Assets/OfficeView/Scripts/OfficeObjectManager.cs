using UnityEngine;
using System.Collections;

public class OfficeObjectManager : MonoBehaviour {

	// Use this for initialization
	void Start () {
		GameObject simpleTable = (GameObject) Instantiate(Resources.Load("OfficeView/TableSimple", typeof(GameObject)));
		simpleTable.transform.position = new Vector3 (-4f,1f,9.7f);
		simpleTable.renderer.material.color = Color.cyan;
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
