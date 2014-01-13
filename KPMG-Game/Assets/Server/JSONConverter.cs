using UnityEngine;
using System;
using System.Collections.Generic;

using SimpleJSON;

public class JSONConverter {
		
	private static JSONConverter instance;

	private JSONConverter () {}

	public static JSONConverter getInstance() {
		if (instance == null)
			instance = new JSONConverter();

		return instance;
	}

	public List<MinigameChallenge> convertMinigameChallenges(string response) {
	
		JSONNode json = JSON.Parse(response);
		JSONArray challengesArray = json.AsArray;

		List<MinigameChallenge> result = new List<MinigameChallenge>();

		for(int i = 0; i < (int)challengesArray.Count; i++) 
			result.Add(convertMinigameChallenge(challengesArray[i].ToString()));

		return result;
		
	}

	public MinigameChallenge convertMinigameChallenge(string response) {
		
		JSONNode challenge = JSON.Parse(response);
		
		MinigameChallenge c = new MinigameChallenge();
		c.setId(challenge["id"].AsInt);
		c.setStatus(challenge["status"].Value);
		c.setPlayer1(challenge["player1"].Value);
		c.setPlayer2(challenge["player2"].Value);
		c.setChallengeQuestions(convertChallengeQuestions(challenge["questions"].ToString()));
		c.setChallengeResult1(convertChallengeResult(challenge["result1"].ToString()));
		c.setChallengeResult2(convertChallengeResult(challenge["result2"].ToString()));
			
		return c;
		
	}

	public List<ChallengeQuestion> convertChallengeQuestions(string response) {

		JSONNode json = JSON.Parse(response);
		JSONArray questionsArray = json.AsArray;
		
		List<ChallengeQuestion> result = new List<ChallengeQuestion>();

		for(int i = 0; i < (int)questionsArray.Count; i++) {
			
			string question = questionsArray[i]["question"].Value;
			KeyValuePair<string, bool>[] answers = new KeyValuePair<string, bool>[5];
			
			for(int j = 0; j < answers.Length; j++) {
				if(questionsArray[i]["answers"].Count > j) {
					var ans = questionsArray[i]["answers"][j]["answer"].ToString();
					bool correct = questionsArray[i]["answers"][j]["correct"].AsInt == 0? false : true;
					answers[j] = new KeyValuePair<string, bool> (ans, correct);
				}
				else 
					answers[j] = new KeyValuePair<string, bool> ("N/A", false);
			}
			
			result.Add(new ChallengeQuestion(question, answers));
		}

		return result;

	}

	public ChallengeResult convertChallengeResult(string response) {

		if(response.Equals(""))
			return new ChallengeResult(0, 0);

		JSONNode result = JSON.Parse(response);

		float time = result["time"].AsFloat;
		int correctAnswers = result["correctAnswers"].AsInt;

		return new ChallengeResult(time, correctAnswers);

	}

	public List<string> convertPlayersNames(string response){

		JSONNode json = JSON.Parse(response);
		JSONArray players = json.AsArray;
		
		List<string> result = new List<string>();
		
		for(int i = 0; i < (int)players.Count; i++) 
			result.Add(players[i]["value"].Value);
		
		return result;

	}


}

