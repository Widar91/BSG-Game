using UnityEngine;
using System;
using System.Net;
using System.IO;
using System.Collections.Generic;
using SimpleJSON;

public class ServerConnector : MonoBehaviour{

	private static ServerConnector instance;

	public static ServerConnector getInstance() {
		if(instance == null)
			instance = new ServerConnector();

		return instance;
	}

	public ChallengeQuestion[] getNewChallengeQuestions() {

		string question;
		string[] answers;
		ChallengeQuestion[] questions;


		string url = "http://localhost:8080/kpmgcities/challengequestions";
		string jsonResponse = sendRequest(url);
		JSONNode json = JSON.Parse(jsonResponse);
		JSONArray jsonQuestionsArray = json.AsArray;
		print ("JSON: " + jsonQuestionsArray.ToString());

		int qcount = (int)jsonQuestionsArray.Count;
		questions = new ChallengeQuestion[qcount];


		for(int i = 0; i < questions.Length; i++) {

			question = jsonQuestionsArray[i]["question"].Value;
			answers = new string[5];

			for(int j = 0; j < answers.Length; j++) {
				if(jsonQuestionsArray[i]["answers"].Count > j)
					answers[j] = jsonQuestionsArray[i]["answers"][j]["answer"].ToString();
				else 
					answers[j] = "N/A";
			}

			questions[i] = new ChallengeQuestion(question, answers);
		}

		//debug print
		foreach(ChallengeQuestion cq in questions) {
			print ("q: " + cq.getQuestion() + "\n");
			foreach(string a in cq.getAnswers())
				print ("\t" + a + "\n" );
		}


		return questions;

	}

	private string sendRequest(string url) {
		WebClient client = new WebClient ();
		
		//client.Headers.Add ("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");
		//exceptions here?
		Stream data = client.OpenRead (url);
		StreamReader reader = new StreamReader (data);
		string s = reader.ReadToEnd ();
		//Console.WriteLine (s);
		print ("data:" + s);
		data.Close ();
		reader.Close ();
		return s;
	}

}
