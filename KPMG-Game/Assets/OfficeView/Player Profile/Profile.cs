using UnityEngine;
using System;
using System.Collections;
//using UnityEditor;

public class myscore
{
	public myscore(string date, string duration, string progress, string score)
	{
		this.date = date;
		this.duration = duration;
		this.progress = progress;
		this.score = score;
	}
	
	public string date;
	public string duration;
	public string progress;
	public string score;
}

public class allscore : IEnumerable
{
	private myscore[] _allscore;
	public allscore(myscore[] pArray)
	{
		_allscore = new myscore[pArray.Length];
		
		for (int i = 0; i < pArray.Length; i++)
		{
			_allscore[i] = pArray[i];
		}
	}
	
	IEnumerator IEnumerable.GetEnumerator()
	{
		return (IEnumerator) GetEnumerator();
	}
	
	public allscoreEnum GetEnumerator()
	{
		return new allscoreEnum(_allscore);
	}
}

public class allscoreEnum : IEnumerator
{
	public myscore[] _allscore;
	
	// Enumerators are positioned before the first element 
	// until the first MoveNext() call. 
	int position = -1;
	
	public allscoreEnum(myscore[] list)
	{
		_allscore = list;
	}
	
	public bool MoveNext()
	{
		position++;
		return (position < _allscore.Length);
	}
	
	public void Reset()
	{
		position = -1;
	}
	
	object IEnumerator.Current
	{
		get
		{
			return Current;
		}
	}
	
	public myscore Current
	{
		get
		{
			try
			{
				return _allscore[position];
			}
			catch (IndexOutOfRangeException)
			{
				throw new InvalidOperationException();
			}
		}
	}
}

public class Profile : MonoBehaviour {
	
	public int toggleLeader = 0;
	public GUISkin ProfileSkin;

	public Vector2 scrollPosition = Vector2.zero;
	public float vscrollPos;
	//public Transform target;
	//Vector3 point;

	string fname = "Joe";
	string id = "joe123";
	string dept = "Tech";
	string office = "Amstelveen";
	string badges = "1111";
	string dRank = "23";
	string wRank = "33";
	string mRank = "45";

	//Content
	//int[] Scores = {87987,45155,56825};
	//string[] empName = { "one", "two", "three" };
	//int numPlayers = 3;
	
	public Texture2D[] badgeTextures;
	string[] badgeTips = {"You did something", "You completed something", "You rock", "You own the world"};
	//int[,] Badges = new int[,] { { 0, 0, 0, 1 }, { 1, 0, 1, 0 }, { 1, 1, 1, 0 } };
	//int numBadges = 4;
	
	public Texture2D Close;
	public Texture2D Close_h;

	public Texture2D browse;
	public Texture2D browse_h;

	public Texture2D avatar;
	
	//string[] temp = {"Good","BAD","NICE"};
	
	
	
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
		//point.x = Event.current.mousePosition.x;
		//point.y = Event.current.mousePosition.y;
		
	}
	
	void OnMouseDown(){
		
		toggleLeader = 1;
		
	}
	
	void OnGUI(){
		GUI.skin = ProfileSkin;
		
		//point.x = Event.current.mousePosition.x;
		//point.y = Event.current.mousePosition.y;
		
		if (toggleLeader == 1) {
			Time.timeScale = 0; //Remember to set 1 for resuming.
			GUI.Window (0, new Rect (Screen.width*0.1f, 30, Screen.width*0.75f, Screen.height*0.75f), scoreWindow, "My Profile");
			
		}
		
		
	}
	
	
	//GUI Window
	void scoreWindow (int windowID) {
		
		myscore[] allscoreArray = new myscore[10]
		{
			new myscore ("18/11/13 17:22", "10:15", "100%", "987"),
			new myscore ("24/11/13 12:20", "08:15", "100%", "1020"),
			new myscore ("28/11/13 22:13", "07:15", "80%", "640"),
			new myscore ("28/11/13 22:13", "07:15", "80%", "640"),
			new myscore ("28/11/13 22:13", "07:15", "80%", "640"),
			new myscore ("28/11/13 22:13", "07:15", "80%", "640"),
			new myscore ("28/11/13 22:13", "07:15", "80%", "640"),
			new myscore ("28/11/13 22:13", "07:15", "80%", "640"),
			new myscore ("28/11/13 22:13", "07:15", "80%", "640"),
			new myscore ("28/11/13 22:13", "07:15", "80%", "640"),
		};
		allscore allscoreList = new allscore(allscoreArray);
		
		
		GUI.BeginGroup (new Rect (75, 50, Screen.width*0.75f, Screen.height*0.75f), "");

		GUI.DrawTexture (new Rect (Screen.width * 0.1f, 20, 100, 100), avatar);
		ButtonstyleGUI_CS.buttonstyle(browse,browse_h);
		/*if(GUI.Button (new Rect (Screen.width * 0.1f, 120, 100, 30), "Change Avatar")){
			
			Texture2D texture = avatar;
			if (texture == null) {
				EditorUtility.DisplayDialog (
					"Select Texture",
					"You Must Select a Texture first!",
					"Ok");
				return;
			}
			var path = EditorUtility.OpenFilePanel (
				"Overwrite with png",
				"",
				"png");
			if (path.Length != 0) {
				var www = new WWW ("file:///" + path);
				www.LoadImageIntoTexture (texture);
				
			}
		}*/
		
		//Titles
		GUI.Label (new Rect (Screen.width*0.1f+180, 0, 100, 50),"Name : " + fname );
		GUI.Label (new Rect (Screen.width*0.1f+180, 30, 100, 50),"ID : " + id);

		//GUI.Label (new Rect (Screen.width*0.1f+180, 60, 90, 50),"Achievements : ");

		int flag = 0;
		for(int j=0; j<badges.Length; j++){
			
			
			
			if(badges[j]=='1'){
				

				
				GUI.Label(new Rect(Screen.width*0.1f+180+flag*30,90,30,30),new GUIContent(badgeTextures[j], badgeTips[j]));
				flag = flag + 1;
				
				
			}
			
			
		}
		GUI.Label(new Rect(Screen.width*0.1f+180,60,200,30),GUI.tooltip);

		GUI.Label (new Rect (Screen.width*0.45f, 0, 120, 50), "Department : " + dept);
		GUI.Label (new Rect (Screen.width*0.45f, 30, 120, 50), "Office : " + office);

		GUI.Label (new Rect (Screen.width*0.1f+180, 130, 100, 50),"Ranks");
		GUI.Label (new Rect (Screen.width*0.15f+180, 130, 100, 50),"Daily : " + dRank);
		GUI.Label (new Rect (Screen.width*0.25f+180, 130, 100, 50),"Weekly : " + wRank);
		GUI.Label (new Rect (Screen.width*0.35f+180, 130, 100, 50),"Monthly : " + mRank);
		
		//Content
		GUI.Label (new Rect (Screen.width*0.1f, 200, 60, 50), "S.No");
		GUI.Label (new Rect (Screen.width*0.15f, 200, 120, 50), "Date & Time");
		GUI.Label (new Rect (Screen.width*0.25f, 200, 60, 50), "Duration");
		GUI.Label (new Rect (Screen.width*0.35f, 200, 120, 50), "Progress");
		GUI.Label (new Rect (Screen.width*0.45f, 200, 120, 50), "Score");

		//GUI.BeginGroup(new Rect (0, 200, Screen.width*0.75f, Screen.height*0.75f), "");
		//vscrollPos = GUI.VerticalScrollbar(new Rect(0, 200, 100, 30), vscrollPos, 1, 0, 100);
		scrollPosition = GUI.BeginScrollView (new Rect (0, 220, Screen.width*0.52f, Screen.height*0.25f),
		                                      scrollPosition, new Rect (0, 0, Screen.width*0.52f-100, Screen.height*0.25f+(20* allscoreArray.Length )));

		int i = 0;
		foreach (myscore p in allscoreList) {

			
						GUI.Label (new Rect (Screen.width * 0.1f, (i + 1) * 30, 60, 50), (i+1).ToString());
						GUI.Label (new Rect (Screen.width * 0.15f, (i + 1) * 30, 120, 50), p.date);
						GUI.Label (new Rect (Screen.width * 0.25f, (i + 1) * 30, 60, 50), p.duration);
						GUI.Label (new Rect (Screen.width * 0.35f, (i + 1) * 30, 120, 50), p.progress);
						GUI.Label (new Rect (Screen.width * 0.45f, (i + 1) * 30, 120, 50), p.score);
						i++;
				}
		GUI.EndScrollView ();
		GUI.EndGroup ();
		//Close Button
		ButtonstyleGUI_CS.buttonstyle(Close,Close_h);
		if (GUI.Button (new Rect (Screen.width*0.7f,20,40,40), "")) {
						Time.timeScale = 1;
						toggleLeader = 0;
				}


					
			//GUI.EndGroup();
			
		
		
		
	}
	
	
	
}