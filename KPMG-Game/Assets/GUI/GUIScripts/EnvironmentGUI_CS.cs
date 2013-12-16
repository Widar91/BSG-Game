﻿using UnityEngine;
using System.Collections;

public class EnvironmentGUI_CS : MonoBehaviour {

	public GUISkin hudskin;
	public Texture2D button1;
	public Texture2D button2;
	public Texture2D button1_h;
	public Texture2D button2_h;
	public Texture2D toggle1;
	public Texture2D toggle1_h;
	public Texture2D midtex;
	public Texture2D kpmg;
	public string scores = "All stuff here";

	public static string currentLevel;
	public static string previousLevel;

	void OnGUI() {
		
		currentLevel = Application.loadedLevelName;
		
		GUI.BeginGroup (new Rect (10,Screen.height-130,Screen.width-20,120), "");
		
		//Call HUD skin.
		GUI.skin = hudskin;
		GUI.Box(new Rect(0,20,Screen.width-20,100),"");
		
		//Text area for scores
		GUI.TextArea (new Rect (10, 30, 200, 80), scores, 200);
		
		
		//Additive images
		GUI.DrawTexture(new Rect(Screen.width/2-50,0,100,109), midtex, ScaleMode.StretchToFill, true, 0);
		GUI.DrawTexture(new Rect(Screen.width-400,35,100,46), kpmg, ScaleMode.StretchToFill, true, 0);
		
		
		// Make the first button and first skin. 
		ButtonstyleGUI_CS.buttonstyle(button1,button1_h);
		

			if(GUI.Button (new Rect (Screen.width - 100,60,30,32), "")){
				
				if(currentLevel != "Office"){
					Application.LoadLevel("Office");        
				}
				else {
					//disable button
				}
			}

		// Make Second button and switch to second skin.
		ButtonstyleGUI_CS.buttonstyle(button2,button2_h);

			if(GUI.Button (new Rect (Screen.width-200,60,30,32), "")){
				
				if(currentLevel != "Neighbourhood"){
					Application.LoadLevel("Neighbourhood");        
				}

			}

		// Make Second button and switch to second skin.
		ButtonstyleGUI_CS.buttonstyle(button2,button2_h);
			if(GUI.Button (new Rect (Screen.width-300,60,30,32), "")){
				
				if(currentLevel != "CityView"){
				Application.LoadLevel("CityView");        
				}

			}

		// Make Second button and switch to second skin.
		ButtonstyleGUI_CS.buttonstyle(button2,button2_h);

			if(GUI.Button (new Rect (Screen.width-400,60,30,32), "")){
				
				if(currentLevel != "WorldView"){
					Application.LoadLevel("WorldView");        
				}
			
			}
		
		GUI.EndGroup();        
		
	}
}