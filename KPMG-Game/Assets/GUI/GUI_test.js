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

//Shop values
var shopskin : GUISkin;
var shopflag : boolean = true;
var item1 : Texture;
var item2 : Texture;
var item3 : Texture;
var item4 : Texture;

var item1_h : Texture;
var item2_h : Texture;
var item3_h : Texture;
var item4_h : Texture;

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
			buttonstyle(button1,button1_h);
			if(GUI.Button (Rect (Screen.width-100,73,30,32), "")){
				print("World down button");
				Application.LoadLevel("WorldView");
				}
			// Make Second button and switch to second skin.
			buttonstyle(button2,button2_h);
			if(GUI.Button (Rect (Screen.width-100,33,30,32), "")){
				print("World up button");
				}

		GUI.EndGroup();	
//		}

	
		//Make shop button and switch to shop GUI.
		GUI.skin = shopskin;	
		buttonstyle(toggle1, toggle1_h);
		
		//Shop toggle button shows window.
		shopflag = GUI.Toggle (Rect (Screen.width-150,10,100,100), shopflag, "");
		if (shopflag)
			GUI.Window (0, Rect(10,100,Screen.width-20,Screen.height-250), shopWindow, "Shop");
		
		
}

//Shop Window displays al items on sale.
function shopWindow (windowID : int) {
		
		buttonstyle(item1,item1_h);
		GUI.Button (Rect (10,30, 100,66), "");
		
		buttonstyle(item2,item2_h);
		GUI.Button (Rect (130,30, 100,70), "");
		
		buttonstyle(item3,item3_h);
		GUI.Button (Rect (240,30, 100,67), "");
		
		buttonstyle(item4,item4_h);
		GUI.Button (Rect (350,30, 100,67), "");
	}

//Function for formatting button styles
function buttonstyle(norm : Texture, hov : Texture){
	
	GUI.skin.button.normal.background = norm;
	GUI.skin.button.hover.background = hov;
	GUI.skin.button.active.background = norm;
	GUI.skin.button.onActive.background = norm;
	GUI.skin.button.onHover.background = hov;
	GUI.skin.button.onNormal.background = norm;
	
	GUI.skin.toggle.normal.background = norm;
	GUI.skin.toggle.hover.background = hov;
	GUI.skin.toggle.active.background = norm;
	GUI.skin.toggle.onActive.background = norm;
	GUI.skin.toggle.onHover.background = hov;
	GUI.skin.toggle.onNormal.background = norm;
}