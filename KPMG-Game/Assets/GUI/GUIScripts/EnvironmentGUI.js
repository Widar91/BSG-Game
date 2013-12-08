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

function OnGUI() {
	
//	var openshop = 0; //flag
//	if (openshop == 0){
	// Make a background box
	
	
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
			ButtonstyleGUI.buttonstyle(button1,button1_h);
			if(GUI.Button (Rect (Screen.width-100,73,30,32), "")){
				print("World down button");
				Application.LoadLevel("WorldView");
				}
			// Make Second button and switch to second skin.
			ButtonstyleGUI.buttonstyle(button2,button2_h);
			if(GUI.Button (Rect (Screen.width-100,33,30,32), "")){
				print("World up button");
				}

		GUI.EndGroup();	
//		}

	
//		//Make shop button and switch to shop GUI.
//		GUI.skin = shopskin;	
//		buttonstyle(toggle1, toggle1_h);
//		
		//Shop toggle button shows window.
//		shopflag = GUI.Toggle (Rect (Screen.width-150,10,100,100), shopflag, "");
//		if (shopflag)
//			GUI.Window (0, Rect(10,100,Screen.width-20,Screen.height-250), shopWindow, "Shop");
		
		
}


