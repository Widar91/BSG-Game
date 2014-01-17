using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ShopGUI : MonoBehaviour {

	public bool Enabled = true;
	
	public GameObject deamon;
	public OfficeObjectManager manager;
	public OfficeSceneLoader sceneLoader;

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

		if (deamon == null) 
			this.deamon = GameObject.Find ("Deamon");
		this.manager = deamon.GetComponent<OfficeObjectManager> ();	
		this.sceneLoader = deamon.GetComponent<OfficeSceneLoader> ();
	}

	void OnMouseDown(){
		
		toggleShop = this.Enabled;
		
	}

	void OnGUI() {

		if (Input.GetKeyDown (KeyCode.Escape)) {
			toggleShop = false;
		}



		if (toggleShop) {
			GUI.Window (0, new Rect (10, 100, Screen.width - 20, Screen.height - 250), shopWindow, "Shop");
		}
	}


	//Shop Window displays al items on sale.
	void shopWindow (int windowID) {

		int count = 0;
		foreach (KeyValuePair<int, string> kv in OfficeSceneLoader.objects) {
			string objectName  = kv.Value;
			int    objectIndex = kv.Key;

			ButtonstyleGUI_CS.buttonstyle(ShopItemsTexture[objectIndex] , ShopItemsTextureHover[objectIndex]);
			if ( GUI.Button (new Rect ((count * 110f), 30f, 100f, 70f), objectName) ) {
				this.sceneLoader.ToggleObject(objectName);
			};

			// Iteration stuff
			count++;
		}

//		for (int i = 0; i < ShopItemsTexture.Length; i++) {
//			int index = i+1;
//			string itemName = OfficeSceneLoader.objects[index];
//		}

		ButtonstyleGUI_CS.buttonstyle (close, close_h);
		if (GUI.Button (new Rect (Screen.width - 80, 0, 40, 40), "")) {
			toggleShop=false;
		}

	}
}
