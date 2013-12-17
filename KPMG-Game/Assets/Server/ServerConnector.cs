using System;
using System.Net;
using System.IO;
using System.Collections;

public class ServerConnector {

	private static ServerConnector instance;

	public static ServerConnector getInstance() {
		if(instance == null)
			instance = new ServerConnector();

		return instance;
	}

	public string getNewChallengeQuestion() {

		string url = "http://localhost:8080/kpmgcities/challengequestions";
		string jsonResponse = sendRequest(url);
		return jsonResponse;

	}

	private string sendRequest(string url) {
		WebClient client = new WebClient ();
		
		//client.Headers.Add ("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");
		
		Stream data = client.OpenRead (url);
		StreamReader reader = new StreamReader (data);
		string s = reader.ReadToEnd ();
		//Console.WriteLine (s);
		data.Close ();
		reader.Close ();
		return s;
	}

}
