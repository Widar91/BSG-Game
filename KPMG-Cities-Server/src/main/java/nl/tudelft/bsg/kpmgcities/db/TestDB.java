package nl.tudelft.bsg.kpmgcities.db;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Hibernate;

import nl.tudelft.bsg.kpmgcities.model.Player;
import nl.tudelft.bsg.kpmgcities.model.SceneObj;
import nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge.ChallengeAnswer;
import nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge.ChallengeQuestion;
import nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge.MinigameChallenge;
import nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge.MinigameChallengeStatus;

public class TestDB {
	
	public static void populateTestDB() {
		if(DBConnector.getInstance().getPlayers().size() == 0) {
			
			/*PLAYERS*/
			Player eddy = new Player();
			eddy.setName("Eddy");
			eddy.setOffice("Amsterdam");
			eddy.setDepartment("IT");
			eddy.setOffice3DScore(90);
			List<String> l= new ArrayList<String>();
			l.add("o1");
			l.add("o2");
			eddy.setSceneObjs(l);
			DBConnector.getInstance().save(eddy);
			
			Player rambo = new Player();
			rambo.setName("Rambo");
			rambo.setOffice("Amsterdam");
			rambo.setDepartment("IT");
			rambo.setOffice3DScore(10);
			rambo.setSceneObjs(new ArrayList<String>());
			DBConnector.getInstance().save(rambo);
			
			Player p1 = new Player();
			p1.setName("Player1");
			p1.setOffice("Amsterdam");
			p1.setDepartment("IT");
			p1.setOffice3DScore(80);
			p1.setSceneObjs(new ArrayList<String>());
			DBConnector.getInstance().save(p1);
			
			Player p2 = new Player();
			p2.setName("Player2");
			p2.setOffice("Amsterdam");
			p2.setDepartment("IT");
			p2.setOffice3DScore(70);
			p2.setSceneObjs(new ArrayList<String>());
			DBConnector.getInstance().save(p2);
			
			Player p3 = new Player();
			p3.setName("Player3");
			p3.setOffice("Amsterdam");
			p3.setDepartment("IT");
			p3.setOffice3DScore(50);
			p3.setSceneObjs(new ArrayList<String>());
			DBConnector.getInstance().save(p3);
			
			
			/* Q&A CHALLENGE */
			ChallengeAnswer a1 = new ChallengeAnswer();
			a1.setAnswer("a1");
			a1.setCorrect(true);
			DBConnector.getInstance().save(a1);
			ChallengeAnswer a2 = new ChallengeAnswer();
			a2.setAnswer("a2");
			a2.setCorrect(true);
			DBConnector.getInstance().save(a2);
			ChallengeAnswer a3 = new ChallengeAnswer();
			a3.setAnswer("a3");
			a3.setCorrect(true);
			DBConnector.getInstance().save(a3);
			ChallengeAnswer a4 = new ChallengeAnswer();
			a4.setAnswer("a4");
			a4.setCorrect(true);
			DBConnector.getInstance().save(a4);
			ChallengeAnswer a5 = new ChallengeAnswer();
			a5.setAnswer("a5");
			a5.setCorrect(true);
			DBConnector.getInstance().save(a5);
			ChallengeAnswer a6 = new ChallengeAnswer();
			a6.setAnswer("a6");
			a6.setCorrect(false);
			DBConnector.getInstance().save(a6);
			ChallengeAnswer a7 = new ChallengeAnswer();
			a7.setAnswer("a7");
			a7.setCorrect(false);
			DBConnector.getInstance().save(a7);
			ChallengeAnswer a8 = new ChallengeAnswer();
			a8.setAnswer("a8");
			a8.setCorrect(false);
			DBConnector.getInstance().save(a8);
			ChallengeAnswer a9 = new ChallengeAnswer();
			a9.setAnswer("a9");
			a9.setCorrect(false);
			DBConnector.getInstance().save(a9);
			ChallengeAnswer a10 = new ChallengeAnswer();
			a10.setAnswer("a10");
			a10.setCorrect(false);
			DBConnector.getInstance().save(a10);
			
			List<ChallengeAnswer> ans = new ArrayList<ChallengeAnswer>(); 
			
			//create 8 questions (2 with answers)
			ChallengeQuestion q1 = new ChallengeQuestion();
			q1.setQuestion("wtf?");
			ans.add(a1);
			ans.add(a2);
			ans.add(a3);
			ans.add(a4);
			ans.add(a5);
			q1.setAnswers(ans);
			DBConnector.getInstance().save(q1);
			
			ans = new ArrayList<ChallengeAnswer>(); 
			ChallengeQuestion q2 = new ChallengeQuestion();
			q2.setQuestion("wtf2?");
			ans.add(a6);
			ans.add(a7);
			ans.add(a8);
			ans.add(a9);
			ans.add(a10);
			q2.setAnswers(ans);
			DBConnector.getInstance().save(q2);
			ans = new ArrayList<ChallengeAnswer>(); 
			
			ChallengeQuestion q3 = new ChallengeQuestion();
			q3.setQuestion("wtf3?");
			ans.add(a9);
			ans.add(a8);
			ans.add(a7);
			ans.add(a5);
			ans.add(a2);
			//q3.setAnswers(ans);
			DBConnector.getInstance().save(q3);
			
			ans = new ArrayList<ChallengeAnswer>(); 
			ChallengeQuestion q4 = new ChallengeQuestion();
			q4.setQuestion("wtf4?");
			ans.add(a1);
			ans.add(a5);
			ans.add(a4);
			ans.add(a10);
			ans.add(a3);
			//q4.setAnswers(ans);
			DBConnector.getInstance().save(q4);
			
			ans = new ArrayList<ChallengeAnswer>(); 
			ChallengeQuestion q5 = new ChallengeQuestion();
			q5.setQuestion("wtf5?");
			ans.add(a1);
			ans.add(a7);
			ans.add(a2);
			ans.add(a4);
			ans.add(a8);
			//q5.setAnswers(ans);
			DBConnector.getInstance().save(q5);
			
			ans = new ArrayList<ChallengeAnswer>(); 
			ChallengeQuestion q6 = new ChallengeQuestion();
			q6.setQuestion("wtf6?");
			ans.add(a10);
			ans.add(a9);
			ans.add(a4);
			ans.add(a2);
			ans.add(a1);
			//q6.setAnswers(ans);
			DBConnector.getInstance().save(q6);
			
			ans = new ArrayList<ChallengeAnswer>(); 
			ChallengeQuestion q7 = new ChallengeQuestion();
			q7.setQuestion("wtf7?");
			ans.add(a3);
			ans.add(a8);
			ans.add(a7);
			ans.add(a5);
			ans.add(a2);
			//q7.setAnswers(ans);
			DBConnector.getInstance().save(q7);
			
			ans = new ArrayList<ChallengeAnswer>(); 
			ChallengeQuestion q8 = new ChallengeQuestion();
			q8.setQuestion("wtf8?");
			ans.add(a10);
			ans.add(a8);
			ans.add(a3);
			ans.add(a6);
			ans.add(a1);
			//q8.setAnswers(ans);
			DBConnector.getInstance().save(q8);
			
			
			
			//Create 1 challenge
			MinigameChallenge c = new MinigameChallenge();
			c.setPlayer1(rambo.getName());
			c.setPlayer2(eddy.getName());
			
			List<ChallengeQuestion> qs = new ArrayList<ChallengeQuestion>();
			qs.add(q1); qs.add(q2); qs.add(q3); qs.add(q4); qs.add(q5);
			
			c.setQuestions(qs);
			c.setStatus(MinigameChallengeStatus.WAITING_FOR_OPPONENT);
			
			DBConnector.getInstance().save(c);
		}
	}
	
}
