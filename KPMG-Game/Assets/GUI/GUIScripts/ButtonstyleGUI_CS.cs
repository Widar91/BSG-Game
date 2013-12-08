using UnityEngine;
using System.Collections;

public class ButtonstyleGUI_CS : MonoBehaviour {

	//Function for formatting button styles
	public static void buttonstyle(Texture2D norm, Texture2D hov){
		
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
}
