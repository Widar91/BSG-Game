using UnityEngine;
using System;
using System.Text;
using System.Net;
using System.IO;
using System.Collections.Generic;
using SimpleJSON;

public class ServerConnector {

	//private static string BASE_URL = "http://localhost:8080/kpmgcities";
	private static string BASE_URL = "http://ec2-54-200-36-218.us-west-2.compute.amazonaws.com:8080/kpmgcities";

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

	public int getOffice3DScore(string player=null) {
	
		string url = createURL("/player/" + ((player==null) ? playerName : player));
		string jsonResponse = sendRequest("GET", url, "");

		JSONNode json = JSON.Parse(jsonResponse);

		return json["office3DScore"].AsInt;

	}

	public void setOffice3DScore(int score) {
			
		string url = createURL("/player/" + playerName + "/setscore/" + score);
		string jsonResponse = sendRequest("POST", url, "");
			
	}

	public void AddOfficeObject(string itemName) {
		string url = createURL("/player/" + playerName + "/office/add_obj/" + itemName);
		string jsonResponse = sendRequest("POST", url, "");
	}

	public void RemoveOfficeObject(string itemName) {
		string url = createURL("/player/" + playerName + "/office/del_obj/" + itemName);
		string jsonResponse = sendRequest("DELETE", url, "");
	}

	public bool RemoveNeighbourhoodObject(long id) {
		throw new NotImplementedException ("Remove neighbourhood object");
	}

	// public [objects] AddNeighbourhoodObject(Item item)
	//{
	//}
	
	public IList<string> GetOfficeObjects() {
		//IList<Item> items = new List<Item> ();
		IList<string> items = new List<string> ();

		string url = createURL ("/player/" + this.playerName);
		string jsonResponseString = sendRequest ("GET", url, null);
		if (jsonResponseString == "")
			return items;

		JSONNode jsonPlayer = JSON.Parse (jsonResponseString);
		JSONArray jsonObjects = jsonPlayer ["sceneObjs"].AsArray;
		foreach (JSONNode obj in jsonObjects) {
//			Vector3 position = new Vector3(obj["posx"].AsFloat, obj["posy"].AsFloat, obj["posz"].AsFloat);
//			string name = obj["name"].Value;
//			float scale = obj["sclx"].AsFloat;
//			items.Add(new Item(name, position, scale));

			string itemname = obj.Value;
			items.Add(itemname);
		}

		return items;
	}

	public IEnumerable<string> GetAchievements() {
		//return new string[]{"Participation", "Beta-testing"}; // TODO remove mocking

		IList<String> achievements = new List<string> ();

		string url = createURL ("/player/" + this.playerName);
		string jsonResponseString = sendRequest ("GET", url, null);
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
		//return new string[]{"Participation", "Beta-testing"}; // TODO remove mocking
		
		IList<string> trophies = new List<string> ();
		
		string url = createURL ("/player/" + this.playerName);
		string jsonResponseString = sendRequest ("GET", url, null);
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
	
	public List<string> getAllPlayersNames(){
		
		string url = createURL("/player/list/all");
		string jsonResponse = sendRequest("GET", url, "");
		
		if(jsonResponse.Equals(""))
			return null;
		
		List<string> result = JSONConverter.getInstance().convertPlayersNames(jsonResponse);
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

	public Dictionary<String, int> getOffice3DScores() {

				Dictionary<string, int> scores = new Dictionary<string, int> ();

		IEnumerable<string> players = this.getAllPlayersNames ();
		if ( players==null ) {
			Debug.LogWarning ("ServerConnector.getplayerNames() returned nothing");
			return scores;
		} 
		foreach (string player in players) {
			int score = this.getOffice3DScore(player);
			scores.Add (player, score);
		}

		return scores;
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
					//EditorUtility.DisplayDialog("Error", response.ToString(), "Ok", "Cancel");
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
		
		try        {
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
