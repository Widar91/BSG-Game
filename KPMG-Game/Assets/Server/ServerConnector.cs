using UnityEngine;
using UnityEditor;
using System;
using System.Text;
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

	public string playerName; 
	private string loginname;
	private string loginpass;

	private ServerConnector () {
		this.playerName = "Eddy";
	}


	public bool Login(string name, string pass) {
		string url = createURL("/player/" + name);
		string jsonResponse = sendRequest("GET", url, "");

		if (jsonResponse.Equals(""))
			return false;

		JSONNode json = JSON.Parse(jsonResponse);
		playerName = json ["name"].Value;

		return true;
	}

	public int getOffice3DScore() {
	
		string url = createURL("/player/" + playerName);
		string jsonResponse = sendRequest("GET", url, "");

		JSONNode json = JSON.Parse(jsonResponse);

		return json["office3DScore"].AsInt;

	}

	public void setOffice3DScore(int score) {
		
		string url = createURL("/player/" + playerName + "/setscore/" + score);
		string jsonResponse = sendRequest("POST", url, "");
		
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

	public List<MinigameChallenge> getMinigameChallenges() {

		string url = createURL("/minigamechallenge/" + playerName);
		string jsonResponse = sendRequest("GET", url, "");

		if(jsonResponse.Equals(""))
			return null;

		return JSONConverter.getInstance().convertMinigameChallenges(jsonResponse);

	}

	public List<string> getPlayersNames(){

		string url = createURL("/player/list/all");
		string jsonResponse = sendRequest("GET", url, "");
		
		if(jsonResponse.Equals(""))
			return null;
		
		List<string> result = JSONConverter.getInstance().convertPlayersNames(jsonResponse);
		result.Remove(playerName);
		return result;

	}

	public string newMinigameChallenge(string p2) {

		string url = createURL("/minigamechallenge/new?players=" + playerName + "&players=" + p2);
		string jsonResponse = sendRequest("PUT", url, "");
		Debug.Log("challenge: "+jsonResponse);
		return jsonResponse;

	}

	public void sendMinigameResult(int cid, int ans, float time) {

		string url = createURL("/minigamechallenge/result/"+ cid + "/" + playerName);

		string jsonResponse = sendRequest("POST", url, "{\"id\":1,\"time\":"+ time +",\"correctAnswers\":"+ ans +"}");

	}
	




	/*--- UTILITY METHODS ---*/

	private string sendRequest(string method, string url, string parameters) {

		HttpWebRequest http = (HttpWebRequest) WebRequest.Create(new Uri(url));
		http.Accept = "*/*";
		http.ContentType = "application/json";
		http.Method = method;

		string content = "";

		if(method.Equals("POST") && parameters != null) {
			/**
			ASCIIEncoding encoding = new ASCIIEncoding();
			Byte[] bytes = encoding.GetBytes(parameters);
			
			Stream newStream = http.GetRequestStream();
			newStream.Write(bytes, 0, bytes.Length);
			newStream.Close();
			**/

			StreamWriter streamWriter = new StreamWriter(http.GetRequestStream());
			streamWriter.Write(parameters);
			streamWriter.Flush();
			streamWriter.Close();

		}

		try {
			Debug.Log("Request - " + url);
			HttpWebResponse response = (HttpWebResponse) http.GetResponse();


			if((int)response.StatusCode != 200) {
				EditorUtility.DisplayDialog("Error", response.ToString(), "Ok", "Cancel");
				return "";	
			}
			
			var stream = response.GetResponseStream();
			var sr = new StreamReader(stream);
			content = sr.ReadToEnd();
		}
		catch (WebException e) {
			//EditorUtility.DisplayDialog("Error: ", e.Message, "Ok", "");
			Debug.Log(e.Message);
			return "";	
		}

		return content;

		/** OLD VERSION
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
