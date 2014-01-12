using UnityEngine;
using UnityEditor;
using System;
using System.Text;
using System.Net;
using System.IO;
using System.Collections.Generic;
using SimpleJSON;

public class ServerConnector : MonoBehaviour {

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
		this.playerName = "";
	}


	public bool Login(string name, string pass) {
		string url = createURL("/player/" + name);
		string jsonResponse = sendGETRequest(url);

		if (jsonResponse.Equals(""))
			return false;

		JSONNode json = JSON.Parse(jsonResponse);
		playerName = json ["name"].Value;

		return true;
	}

	public int getOffice3DScore() {
	
		string url = createURL("/player/" + playerName);
		string jsonResponse = sendGETRequest(url);

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

	public List<MinigameChallenge> getMinigameChallenges() {

		string url = createURL("/minigamechallenge/" + playerName);
		string jsonResponse = sendGETRequest(url);

		if(jsonResponse.Equals(""))
			return null;

		return JSONConverter.getInstance().convertMinigameChallenges(jsonResponse);

	}

	public void newMinigameChallenge(string p2) {

		string url = createURL("/minigamechallenge/new?players=" + playerName + "&players=" + p2);
		string jsonResponse = sendGETRequest(url);

	}




	public ChallengeQuestion[] getNewChallengeQuestions() {

		string question;
		KeyValuePair<string, bool>[] answers;
		ChallengeQuestion[] questions;

		string url = createURL("/challengequestions");
		string jsonResponse = sendGETRequest(url);
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

	private string sendGETRequest(string url) {

		string result = "";
		Debug.Log ("Callig method");

		WebClient client = new WebClient ();

		try	{
			Stream data = client.OpenRead (url);
			StreamReader reader = new StreamReader (data);
			result = reader.ReadToEnd ();
		}
		catch (WebException e) {
			EditorUtility.DisplayDialog("Error", e.Message, "Ok", "");
		}

		Debug.Log ("Before reading");
		Debug.Log("Server data: " + result);

		data.Close ();
		reader.Close ();

		return result;
	}



	private string sendRequest(string method, string url) {

		HttpWebRequest http = (HttpWebRequest) WebRequest.Create(new Uri(url));
		http.Accept = "application/json";
		http.ContentType = "application/json";
		http.Method = method;
		
		string parsedContent = <<PUT HERE YOUR JSON PARSED CONTENT>>;
		ASCIIEncoding encoding = new ASCIIEncoding();
		Byte[] bytes = encoding.GetBytes(parsedContent);
		
		Stream newStream = http.GetRequestStream();
		newStream.Write(bytes, 0, bytes.Length);
		newStream.Close();
		
		HttpWebResponse response = (HttpWebResponse) http.GetResponse();

		if((int)response.StatusCode != 200)
			EditorUtility.DisplayDialog("Error", e.Message, "Ok", "");
		
		var stream = response.GetResponseStream();
		var sr = new StreamReader(stream);
		var content = sr.ReadToEnd();

		/**
		string result = "";
		WebClient client = new WebClient ();
		
		try	{
			client.Headers[HttpRequestHeader.ContentType] = "application/json";
			result = client.UploadString(url, parameters);
		}
		catch (WebException e) {
			EditorUtility.DisplayDialog("Error", e.Message, "Ok", "");
		}
		
		return result;
		**/
	}

	private string createURL(string url) {
		if (url.StartsWith ("/"))
			return BASE_URL + url;
		else
			return BASE_URL + "/" + url;
	}

}
