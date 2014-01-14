using UnityEngine;
using System.Collections;

public class EnvironmentGUI_CS : MonoBehaviour {

	public GUISkin hudskin;
	public Texture2D button1;
	public Texture2D button1_h;
	public Texture2D button2;
	public Texture2D button2_h;
	public Texture2D button3;
	public Texture2D button3_h;
	public Texture2D button4;
	public Texture2D button4_h;
	public Texture2D toggle1;
	public Texture2D toggle1_h;
	public Texture2D midtex;
	public Texture2D kpmg;

	public static string currentLevel;
	public static string previousLevel;

	void OnGUI() {
		
		currentLevel = Application.loadedLevelName;

		GUI.DrawTexture(new Rect(Screen.width-100,0,100,69), kpmg, ScaleMode.StretchToFill, true, 0);
		
		GUI.BeginGroup (new Rect (10,Screen.height-130,Screen.width-20,120), "");
		
		//Call HUD skin.
		GUI.skin = hudskin;
		GUI.Box(new Rect(175,20,Screen.width/2 + 350,100),"");
		
		//Additive images
		if (currentLevel == "WorldView") 
			GUI.DrawTexture (new Rect (Screen.width/2 - midtex.width/2 - 35, -20, 300, 150), midtex, ScaleMode.StretchToFill, true, 0);
		else if (currentLevel == "CityView") 
			GUI.DrawTexture (new Rect ((Screen.width/2) - midtex.width - 45, -100, 275, 225), midtex, ScaleMode.StretchToFill, true, 0);
		else  
			GUI.DrawTexture (new Rect ((Screen.width/2) - midtex.width - 7, -25, 235, 185), midtex, ScaleMode.StretchToFill, true, 0);
		
		// Make the first button and first skin. 
		ButtonstyleGUI_CS.buttonstyle(button4,button4_h);
		

		if(GUI.Button (new Rect (Screen.width/2 + 330,38,85,85), "")){
				
				if(currentLevel != "Office"){
					Application.LoadLevel("Office");        
				}
				else {
					//disable button
				}
			}

		// Make Second button and switch to second skin.
		ButtonstyleGUI_CS.buttonstyle(button3,button3_h);

		if(GUI.Button (new Rect (Screen.width/2 + 180,40,85,70), "")){
				
				if(currentLevel != "Neighbourhood"){
					Application.LoadLevel("Neighbourhood");        
				}

			}

		// Make Second button and switch to second skin.
		ButtonstyleGUI_CS.buttonstyle(button2,button2_h);
		if(GUI.Button (new Rect (Screen.width/2 - 300,40,85,70), "")){
				
				if(currentLevel != "CityView"){
				Application.LoadLevel("CityView");        
				}

			}

		// Make Second button and switch to second skin.
		ButtonstyleGUI_CS.buttonstyle(button1,button1_h);

		if(GUI.Button (new Rect (Screen.width/2 - 450,40,70,70), "")){
				
				if(currentLevel != "WorldView"){
					Application.LoadLevel("WorldView");        
				}
			
			}
		
		GUI.EndGroup();        
		
	}
}