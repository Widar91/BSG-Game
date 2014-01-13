using UnityEngine;
using System;
using System.Net;
using System.IO;
using System.Collections.Generic;
using SimpleJSON;

public class ServerConnector {

	private static string BASE_URL = "http://localhost:8080/kpmgcities";
	//private static string BASE_URL = "http://ec2-54-201-204-95.us-west-2.compute.amazonaws.com:8080";

	private static ServerConnector instance;
	public static ServerConnector getInstance() {
		if(instance == null)
			instance = new ServerConnector();

		return instance;
	}

	private string playerName; 
	private string loginname;
	private string loginpass;

	private ServerConnector () {
		this.playerName = "Eddy";
	}


	public bool Login(string name, string pass) {
		string url = createURL("/player/" + name);
		string jsonResponse = sendRequest(url);

		if (jsonResponse == "")
			return false;

		JSONNode json = JSON.Parse(jsonResponse);
		playerName = json ["name"].Value;
		return true;
	}

	public int getOffice3DScore() {
	
		string url = createURL("/player/" + playerName);
		string jsonResponse = sendRequest(url);
		JSONNode json = JSON.Parse(jsonResponse);

		return json["office3DScore"].AsInt;

	}

	public bool RemoveOfficeObject(long id) {
		throw new NotImplementedException ("Remove office object");
	}

	public bool RemoveNeighbourhoodObject(long id) {
		throw new NotImplementedException ("Remove neighbourhood object");
	}

	// public [objects] AddOfficeObject(Item item)
	//{
	//}
	// public [objects] AddNeighbourhoodObject(Item item)
	//{
	//}

	public IList<Item> GetOfficeObjects() {
		IList<Item> items = new List<Item> ();

		string url = createURL ("/player/" + this.playerName);
		string jsonResponseString = sendRequest (url);
		if (jsonResponseString == "")
			return items;

		JSONNode jsonPlayer = JSON.Parse (jsonResponseString);
		JSONArray jsonObjects = jsonPlayer ["sceneObjs"].AsArray;
		foreach (JSONNode obj in jsonObjects) {
			Vector3 position = new Vector3(obj["posx"].AsFloat, obj["posy"].AsFloat, obj["posz"].AsFloat);
			string name = obj["name"].Value;
			float scale = obj["sclx"].AsFloat;
			items.Add(new Item(name, position, scale));
		}

		return items;
	}

	public IEnumerable<string> GetAchievements() {
		return new string[]{"Participation", "Beta-testing"}; // TODO remove mocking

		IList<String> achievements = new List<string> ();

		string url = createURL ("/player/" + this.playerName);
		string jsonResponseString = sendRequest (url);
		if (jsonResponseString == "")
			return achievements;

		JSONNode jsonPlayer = JSON.Parse (jsonResponseString);
		JSONArray achievementsJson = jsonPlayer ["achievements"].AsArray;
		for (int i=0; i<achievementsJson.Count; i++) {
			string achievement = achievementsJson[i]["name"].Value;
			achievements.Add (achievement);
		}

		return achievements;
	}

	public bool SetAchievements(IEnumerable<String> newAchievements) {
		throw new NotImplementedException("Set achievements");
	}

	public IEnumerable<string> GetTrophies() {
		return new string[]{"Participation", "Beta-testing"}; // TODO remove mocking
		
		IList<string> trophies = new List<string> ();
		
		string url = createURL ("/player/" + this.playerName);
		string jsonResponseString = sendRequest (url);
		if (jsonResponseString == "")
			return trophies;

		JSONNode jsonPlayer = JSON.Parse (jsonResponseString);
		JSONArray trophiesJson = jsonPlayer ["trophies"].AsArray;
		for (int i=0; i<trophiesJson.Count; i++) {
			string trophy = trophiesJson[i]["name"].Value;
			trophies.Add (trophy);
		}
		
		return trophies;
	}
	
	public bool SetTrophies(IEnumerable<String> newTrophies) {
		throw new NotImplementedException("Set trophies");
	}

	public int GetScore() {
		string url = createURL("/player/" + this.playerName);

		string jsonResponse = sendRequest(url);
		if (jsonResponse == "")
			return 0; // TODO throw exception?
		
		JSONNode json = JSON.Parse(jsonResponse);
		return json["office3DScore"].AsInt;
	}

	public int SetScore(int inScore) {
		throw new NotImplementedException ("set score");
	}

	public ChallengeQuestion[] getNewChallengeQuestions() {

		string question;
		KeyValuePair<string, bool>[] answers;
		ChallengeQuestion[] questions;

		string url = createURL("/challengequestions");
		string jsonResponse = sendRequest(url);
		JSONNode json = JSON.Parse(jsonResponse);
		JSONArray jsonQuestionsArray = json.AsArray;
		Debug.Log ("JSON: " + jsonQuestionsArray.ToString());

		int qcount = (int)jsonQuestionsArray.Count;
		questions = new ChallengeQuestion[qcount];


		for(int i = 0; i < questions.Length; i++) {

			question = jsonQuestionsArray[i]["question"].Value;
			answers = new KeyValuePair<string, bool>[5];

			for(int j = 0; j < answers.Length; j++) {
				if(jsonQuestionsArray[i]["answers"].Count > j) {
					var ans = jsonQuestionsArray[i]["answers"][j]["answer"].ToString();
					bool correct = jsonQuestionsArray[i]["answers"][j]["correct"].AsInt == 0? false : true;
					answers[j] = new KeyValuePair<string, bool> (ans, correct);
				}
				else 
					answers[j] = new KeyValuePair<string, bool> ("N/A", false);
			}

			questions[i] = new ChallengeQuestion(question, answers);
		}

		//debug print
		foreach(ChallengeQuestion cq in questions) {
			Debug.Log  ("q: " + cq.getQuestion() + "\n");
			foreach(KeyValuePair<string, bool> a in cq.getAnswers())
				Debug.Log  ("\t" + a.Key + ": " + a.Value + "\n" );
		}


		return questions;

	}

	private string sendRequest(string url) {

		string result = "";
		Debug.Log ("Callig method");

		WebClient client = new WebClient ();
		Stream data = client.OpenRead (url);
		StreamReader reader = new StreamReader (data);

		Debug.Log ("Before reading");
		result = reader.ReadToEnd ();
		Debug.Log("Server data: " + result);

		data.Close ();
		reader.Close ();

		return result;
	}

	private string createURL(string url) {
		if (url.StartsWith ("/"))
			return BASE_URL + url;
		else
			return BASE_URL + "/" + url;
	}

}
