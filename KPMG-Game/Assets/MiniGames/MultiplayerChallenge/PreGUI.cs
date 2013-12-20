using UnityEngine;
using System.Collections;

public class PreGUI : MonoBehaviour {

	public static bool preFlag = false;
	public static bool tooglePre = true;

	public Texture2D myProfile;
	public Texture2D[] opProfiles;
	public Texture2D[] opProfiles_h;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnGUI(){
		if (tooglePre) {
						GUI.Window (0, new Rect (Screen.width * 0.2f, 30, Screen.width * 0.6f, Screen.height * 0.8f), preWindow, "Pick Opponent");
						Time.timeScale = 0;
				}
		}

	void preWindow (int windowID) {
				//Draw player's avatar
		GUI.TextField(new Rect (Screen.width*0.15f+35, 110, 30, 20),"Me");
				GUI.DrawTexture (new Rect (Screen.width * 0.15f, 100, 100, 100), myProfile);

				for (int i = 0; i < opProfiles.Length; i++) {
						ButtonstyleGUI_CS.buttonstyle (opProfiles[i], opProfiles_h[i]);
			GUI.TextField(new Rect (Screen.width*0.4f+10, 110+i*100, 85, 20),"Opponent - " + (i+1).ToString());
						if (GUI.Button (new Rect (Screen.width*0.4f, 100+i*100, 100, 100),"" )) {
				preFlag = true;
					Time.timeScale = 1;
				tooglePre = false;
			
						}
				}
		}
}
