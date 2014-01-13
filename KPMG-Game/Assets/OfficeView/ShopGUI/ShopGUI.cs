using UnityEngine;
using System.Collections;

public class ShopGUI : MonoBehaviour {

	//Shop values
	public GUISkin ShopSkin;
	public Texture2D[] ShopItemsTexture;
	public Texture2D[] ShopItemsTextureHover;
	public Texture2D close;
	public Texture2D close_h;

	private static bool toggleShop = false;
	private Component camMouse;

	void Start() {
		//camMouse = GameObject.Find("CameraController").GetComponent("WorldCamera");
	}

	void OnMouseDown(){
		
		toggleShop = true;
		
	}

	void OnGUI() {

		if (Input.GetKeyDown (KeyCode.Escape)) {
			toggleShop = false;
			Time.timeScale = 1;
		}





		if (toggleShop) {
			GUI.Window (0, new Rect (10, 100, Screen.width - 20, Screen.height - 250), shopWindow, "Shop");
			//(camMouse as Behaviour).enabled = !((camMouse as Behaviour).enabled);
			Time.timeScale = 0;
		}
	}


	//Shop Window displays al items on sale.
	void shopWindow (int windowID) {


		for (int i = 0; i < ShopItemsTexture.Length; i++) {

			ButtonstyleGUI_CS.buttonstyle(ShopItemsTexture[i] , ShopItemsTextureHover[i]);
			GUI.Button (new Rect ((i * 110f), 30f, 100f, 70f), "Element_" + i);

		}

		ButtonstyleGUI_CS.buttonstyle (close, close_h);
		if (GUI.Button (new Rect (Screen.width - 80, 0, 40, 40), "")) {
			toggleShop=false;
				}

	}
}
