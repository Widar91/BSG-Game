using UnityEngine;
using System.Collections;

public class GUIScript : MonoBehaviour {

	public Texture2D button1;
	public Texture2D button1h;
	public Texture2D button1a;
	public Texture2D button2;
	public Texture2D button2h;
	public Texture2D button2a;
	
	private int buildingindex;
	private string buildingname;
	private int buildingrotation;

	private int buildingIndex;
	private int buildingRotation;
	public static int confirmFlag = 0;
	public static int winFlag = 0;
	
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

		if (winFlag == 1) {
						GUI.Window (0, new Rect (Screen.width/2-150, Screen.height/2-100, 600, 100), confirmWindow, "Are you sure?");

				}
	}

	//Confirmation window called from BuildManager.
	void confirmWindow (int windowID) {



		ButtonstyleGUI_CS.buttonstyle(button1, button1h);
		if(GUI.Button(new Rect(20, 20, 184, 39),"YES"))
		   {
			confirmFlag = 1;
		}
		ButtonstyleGUI_CS.buttonstyle(button2, button2h);
		if(GUI.Button(new Rect(240, 20, 184, 39),"NO"))
		        {
			confirmFlag = 0;
		}
	}
}
