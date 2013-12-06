using UnityEngine;
using System.Collections;

public class GUIScript : MonoBehaviour {
	
	private int buildingindex;
	private string buildingname;
	private int buildingrotation;

	private int buildingIndex;
	private int buildingRotation;
	
	// Use this for initialization
	void Start () {
		buildingIndex = 0;
		buildingRotation = 0;
	}
	
	// Update is called once per frame
	void Update () 
	{
		GameObject go = GameObject.Find("BuildManager");
		BuildManager bm = go.GetComponent<BuildManager>();
			
		if (Input.GetKeyDown("1"))
		{
			buildingIndex = (buildingIndex + 1) % bm.Building.Length;
			bm.SelectedBuilding = buildingIndex;
		}

		if (Input.GetKeyDown("2"))
		{
			buildingRotation = (buildingRotation + 90) % 360;
			bm.SelectedBuildingRotation = buildingRotation;
		}

		buildingindex = bm.SelectedBuilding;
		buildingname = bm.Building[buildingindex].name;
		buildingrotation = bm.SelectedBuildingRotation;
	}
	
	void OnGUI()
	{
		
		GUILayout.TextArea("Selected Building Index: " + buildingindex + " Name: " + buildingname + " Rotation:" + buildingrotation);
	}
}
