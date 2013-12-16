//HUD values
var hudskin : GUISkin;
var button1 : Texture;
var button2 : Texture;
var button1_h : Texture;
var button2_h : Texture;
var toggle1 : Texture;
var toggle1_h : Texture;
var midtex : Texture;
var kpmg : Texture;
var scores : String = "All stuff here";
public static var currentLevel : String;
public static var previousLevel : String;

function OnGUI() {
		
		currentLevel = Application.loadedLevelName;
		
		GUI.BeginGroup (Rect (10,Screen.height-130,Screen.width-20,120), "");
		
			//Call HUD skin.
			GUI.skin = hudskin;
			GUI.Box(Rect(0,20,Screen.width-20,100),"");
			
			//Text area for scores
			GUI.TextArea (Rect (10, 30, 200, 80), scores, 200);

			
			//Additive images
			GUI.DrawTexture(Rect(Screen.width/2-50,0,100,109), midtex, ScaleMode.StretchToFill, true, 0);
			GUI.DrawTexture(Rect(Screen.width-400,35,100,46), kpmg, ScaleMode.StretchToFill, true, 0);
			

			// Make the first button and first skin. 
			ButtonstyleGUI_JS.buttonstyle(button1,button1_h);
			
			if(currentLevel != "WorldView")
			{
			if(GUI.Button (Rect (Screen.width-100,73,30,32), "")){
			
				if(currentLevel == "Office"){
					Application.LoadLevel("Neighbourhood");	
				}
				
				if(currentLevel == "Neighbourhood"){
					Application.LoadLevel("WorldView");	
				}
				
				
				print("World down button");
			}
			}
			// Make Second button and switch to second skin.
			ButtonstyleGUI_JS.buttonstyle(button2,button2_h);
			if(currentLevel != "Office")
			{
			if(GUI.Button (Rect (Screen.width-100,33,30,32), "")){
			
			if(currentLevel == "Neighbourhood"){
					Application.LoadLevel("Office");	
				}
				
				if(currentLevel == "WorldView"){
					Application.LoadLevel("Neighbourhood");	
				}
			
			
				print("World up button");
			}
			}

		GUI.EndGroup();	
			
}


