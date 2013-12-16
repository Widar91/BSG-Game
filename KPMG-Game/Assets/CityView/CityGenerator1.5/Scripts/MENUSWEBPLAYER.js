private var showCursor = false;








function OnGUI () {

if (GUI.Button(Rect(0,0,200,50),"Generate - Normal")){
Application.LoadLevel("WebPlayer1");

}

if (GUI.Button(Rect(0,50,200,50),"Generate - Low Poly")){
Application.LoadLevel("WebPlayer2");

}

if (GUI.Button(Rect(0,100,200,50),"GGenerate - High Poly")){
Application.LoadLevel("WebPlayer3");

}

GUI.Label (Rect (230, 10, 300, 50), "Use arrows for FreeCam mode");


}

