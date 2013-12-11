#pragma strict

//Function for formatting button styles
static function buttonstyle(norm : Texture2D, hov : Texture2D){
	
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