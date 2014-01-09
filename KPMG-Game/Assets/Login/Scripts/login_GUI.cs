using UnityEngine;
using System.Collections;

public class login_GUI : MonoBehaviour {

	public GUISkin loginskin;
	public static string uname = "";
	public static string upass = "";

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnGUI(){
		GUI.BeginGroup (new Rect (Screen.width*0.375f,Screen.height*0.35f,Screen.width*0.5f,Screen.height*0.8f), "");

		GUI.Box(new Rect(0,0,Screen.width*0.25f,Screen.height*0.3f),"");
		GUI.Label (new Rect (20, 40, 200, 20), "Username : ");
		uname = GUI.TextField (new Rect (90, 40, 200, 22), uname, 25);
		GUI.Label (new Rect (20, 70, 200, 20), "Password : ");
		upass = GUI.PasswordField (new Rect (90, 70, 200, 22), upass, "*"[0], 25);

		if (GUI.Button (new Rect (130, 120, 70, 23), "Login") || Input.GetKeyDown (KeyCode.Return)) {
			if (ServerConnector.getInstance().Login(uname, upass)){
				Application.LoadLevel("Office");
			}
			else {
				UnityEditor.EditorUtility.DisplayDialog("Login failed", "The user does not exit", "OK", null);
			}
		}

		GUI.EndGroup ();
		}
}
