using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

public class Person
{
	public Person(string fName, int scores, int rank, string badges)
	{
		this.firstName = fName;
		this.Scores = scores;
		this.Rank = rank;
		this.Badges = badges;
	}
	
	public string firstName;
	public int Scores;
	public int Rank;
	public string Badges;
}

public class People : IEnumerable
{
	private Person[] _people;
	public People(Person[] pArray)
	{
		_people = new Person[pArray.Length];
		
		for (int i = 0; i < pArray.Length; i++)
		{
			_people[i] = pArray[i];
		}
	}
	
	IEnumerator IEnumerable.GetEnumerator()
	{
		return (IEnumerator) GetEnumerator();
	}
	
	public PeopleEnum GetEnumerator()
	{
		return new PeopleEnum(_people);
	}
}

public class PeopleEnum : IEnumerator
{
	public Person[] _people;
	
	// Enumerators are positioned before the first element 
	// until the first MoveNext() call. 
	int position = -1;
	
	public PeopleEnum(Person[] list)
	{
		_people = list;
	}
	
	public bool MoveNext()
	{
		position++;
		return (position < _people.Length);
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
	
	public Person Current
	{
		get
		{
			try
			{
				return _people[position];
			}
			catch (IndexOutOfRangeException)
			{
				throw new InvalidOperationException();
			}
		}
	}
}

public class Leaderboard : MonoBehaviour {

	public int toggleLeader = 0;
	public GUISkin LeaderSkin;
	//public Transform target;
	Vector3 point;
	public Vector2 scrollPosition = Vector2.zero;

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

	//string[] temp = {"Good","BAD","NICE"};


	Person[] scoresCache = new Person[0];


	// Use this for initialization
	void Start () {
		// Automatically refresh the leaderboard every 2 minutes
		InvokeRepeating("LoadScores", 0.0f, 120.0f);
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
		GUI.skin = LeaderSkin;

		//point.x = Event.current.mousePosition.x;
		//point.y = Event.current.mousePosition.y;

		if (toggleLeader == 1) {
			Time.timeScale = 0; //Remember to set 1 for resuming.
			GUI.Window (0, new Rect (Screen.width*0.1f, 30, Screen.width*0.75f, Screen.height*0.75f), leaderWindow, "Leader Boards");		
		}
	}


	//GUI Window
	void leaderWindow (int windowID) {


		Person[] peopleArray = this.scoresCache;
		People peopleList = new People(peopleArray);


		//GUI.BeginGroup (new Rect (75, 50, Screen.width*0.75f, Screen.height*0.75f), "");

		//Titles
		GUI.Label (new Rect (Screen.width*0.1f, 40, 60, 50), "Rank");
		GUI.Label (new Rect (Screen.width*0.2f, 40, 60, 50), "Name");
		GUI.Label (new Rect (Screen.width*0.3f, 40, 60, 50), "Score");
		GUI.Label (new Rect (Screen.width*0.45f, 40, 120, 50), "Achievements");

		scrollPosition = GUI.BeginScrollView (new Rect (0, 75, Screen.width*0.72f, Screen.height*0.6f),
		                                      scrollPosition, new Rect (0, 0, Screen.width*0.72f-100, Screen.height*0.25f+(30*peopleArray.Length )));

		//Content
		int i = 0;
		foreach (Person p in peopleList){

			int flag = 0;//To offset badges

			GUI.Label(new Rect(Screen.width*0.1f,(i+1)*30,60,40),p.Rank.ToString());
			GUI.Label(new Rect(Screen.width*0.2f,(i+1)*30,60,50),p.firstName);
			GUI.Label(new Rect(Screen.width*0.3f,(i+1)*30,60,50),p.Scores.ToString());


			//Badges correspond to j and player to i
			for(int j=0; j<p.Badges.Length; j++){



				if(p.Badges[j]=='1'){

					flag = flag + 1;

					GUI.Label(new Rect(Screen.width*0.425f+flag*30,(i+1)*30,30,30),new GUIContent(badgeTextures[j], badgeTips[j]));



						}


					}
			i++;

				}
		//Tooltip for badges
		GUI.Label(new Rect(800,200,150,30),GUI.tooltip);
		GUI.EndScrollView ();

		
		//Close Button
		ButtonstyleGUI_CS.buttonstyle(Close,Close_h);
		if(GUI.Button(new Rect(Screen.width*0.7f,20,40,40),"")){
			Time.timeScale = 1;
			toggleLeader = 0;

		}
		//GUI.EndGroup();

				
	}

	public void LoadScores() {

		// ---MOCK----   // TODO unmock
//		scoresCache = new Person[]
//		{
//			new Person ("John", 789, 1, "1001"),
//			new Person ("Jim", 456, 2, "1000"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//			new Person ("Sue", 123, 3, "0100"),
//		};
		//return;
		//------------

		// Get scores from server
		IDictionary<string, int> scores = ServerConnector.getInstance ().getOffice3DScores ();
		
		// Sort scores
		List<KeyValuePair<string, int>> sorter = new List<KeyValuePair<string, int>> ();
		foreach (KeyValuePair<string, int> kv in scores) {
			sorter.Add (kv);
		}
		sorter.Sort(
			delegate(KeyValuePair<string, int> firstPair,
		         KeyValuePair<string, int> nextPair)
				{
			return nextPair.Value.CompareTo(firstPair.Value);
				}
			);

		// Create people
		int rank = 1;
		List<Person> people = new List<Person> ();
		foreach (KeyValuePair<string, int> kv in sorter) {
			people.Add(new Person(kv.Key, kv.Value, rank++, "0000"));
		}

		scoresCache = people.ToArray ();
	}


			
}