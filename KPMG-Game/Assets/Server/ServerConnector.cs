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

	public IEnumerable<String> GetAchievements() {
		throw new NotImplementedException ("GetAchievements");
	}

	public bool SetAchievements(IEnumerable<String> newAchievements) {
		throw new NotImplementedException("Set achievements");
	}

	public int GetScore() {
		throw new NotImplementedException ("get score");
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
