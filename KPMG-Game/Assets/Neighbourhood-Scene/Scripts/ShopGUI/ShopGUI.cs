using UnityEngine;
using System.Collections;

public class ShopGUI : MonoBehaviour {

	//Shop values
	public GUISkin ShopSkin;
	public Texture2D[] ShopItemsTexture;
	public Texture2D[] ShopItemsTextureHover;

	private static bool toggleShop;
	private Component camMouse;

	void Start() {
		toggleShop = false;
		//camMouse = GameObject.Find("CameraController").GetComponent("WorldCamera");
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

	public static void displayShop () {
		toggleShop = true;
	}

	//Shop Window displays al items on sale.
	void shopWindow (int windowID) {

		for (int i = 0; i < ShopItemsTexture.Length; i++) {

			ButtonstyleGUI_CS.buttonstyle(ShopItemsTexture[i] , ShopItemsTextureHover[i]);
			GUI.Button (new Rect ((i * 110f), 30f, 100f, 70f), "Element_" + i);

		}
		
	}
}
