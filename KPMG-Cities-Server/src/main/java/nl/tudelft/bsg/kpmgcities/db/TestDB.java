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
			ChallengeAnswer a1 = createAnswer("Leading by example", false);
			ChallengeAnswer a2 = createAnswer("Working together", false);
			ChallengeAnswer a3 = createAnswer("Everything for the client", true);
			ChallengeAnswer a4 = createAnswer("Seeking the facts", false);
			ChallengeAnswer a5 = createAnswer("Communicating openly and honestly", false);
			
			ChallengeAnswer a6 = createAnswer("Raise issues if something doesn’t seem right", false);
			ChallengeAnswer a7 = createAnswer("Uphold exemplary standards", true);
			ChallengeAnswer a8 = createAnswer("Consult with others if in doubt", false);
			ChallengeAnswer a9 = createAnswer("Stay informed about relevant laws", false);
			ChallengeAnswer a10 = createAnswer("Take ownership over the global code", false);
			
			ChallengeAnswer a11 = createAnswer("A bottle of wine", false);
			ChallengeAnswer a12 = createAnswer("One euro", false);
			ChallengeAnswer a13 = createAnswer("Free use of a country house for a weekend", false);
			ChallengeAnswer a14 = createAnswer("VIP tickets to a soccer match", false);
			ChallengeAnswer a15 = createAnswer("Cup of coffee during a meeting", true);
			
			ChallengeAnswer a16 = createAnswer("A payment used to secure or expedite a routine action", true);
			ChallengeAnswer a17 = createAnswer("A standard payment for the use of a certain facility", false);
			ChallengeAnswer a18 = createAnswer("An undue benefit offered or made to influence the conduct of someone", false);
			ChallengeAnswer a19 = createAnswer("The cost a client makes for using KPMG facilities", false);
			ChallengeAnswer a20 = createAnswer("A special payment KPMG gives to exemplary employees", false);
			
			ChallengeAnswer a21 = createAnswer("Your engagement partner", true);
			ChallengeAnswer a22 = createAnswer("The receptionist", false);
			ChallengeAnswer a23 = createAnswer("The security official at work in the hall", false);
			ChallengeAnswer a24 = createAnswer("Your senior partner", false);
			ChallengeAnswer a25 = createAnswer("Your Risk management partner", false);
			
			
			
			/*QUESTIONS*/
			List<ChallengeAnswer> ans = new ArrayList<ChallengeAnswer>(); 
			ChallengeQuestion q1 = new ChallengeQuestion();
			q1.setQuestion("Which of the following values is not one of the main KPMG values?");
			ans.add(a1);
			ans.add(a2);
			ans.add(a3);
			ans.add(a4);
			ans.add(a5);
			q1.setAnswers(ans);
			DBConnector.getInstance().save(q1);
			
			ans = new ArrayList<ChallengeAnswer>(); 
			ChallengeQuestion q2 = new ChallengeQuestion();
			q2.setQuestion("Which of the following responsibilities is only a leader’s responsibility?");
			ans.add(a6);
			ans.add(a7);
			ans.add(a8);
			ans.add(a9);
			ans.add(a10);
			q2.setAnswers(ans);
			DBConnector.getInstance().save(q2);
			ans = new ArrayList<ChallengeAnswer>(); 
			
			ChallengeQuestion q3 = new ChallengeQuestion();
			q3.setQuestion("Which of the following does KPMG not consider a bribe?");
			ans.add(a11);
			ans.add(a12);
			ans.add(a13);
			ans.add(a14);
			ans.add(a15);
			//q3.setAnswers(ans);
			DBConnector.getInstance().save(q3);
			
			ans = new ArrayList<ChallengeAnswer>(); 
			ChallengeQuestion q4 = new ChallengeQuestion();
			q4.setQuestion("A facilitation payment is:");
			ans.add(a16);
			ans.add(a17);
			ans.add(a18);
			ans.add(a19);
			ans.add(a20);
			//q4.setAnswers(ans);
			DBConnector.getInstance().save(q4);
			
			ans = new ArrayList<ChallengeAnswer>(); 
			ChallengeQuestion q5 = new ChallengeQuestion();
			q5.setQuestion("During lunch at the café next to the office, someone tries to bribe you to let him into the building. When you get back, you immediately report this to:");
			ans.add(a21);
			ans.add(a22);
			ans.add(a23);
			ans.add(a24);
			ans.add(a25);
			//q5.setAnswers(ans);
			DBConnector.getInstance().save(q5);			
			
			
			/* CHALLENGE */
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

	private static ChallengeAnswer createAnswer(String a, boolean c) {
		ChallengeAnswer a1 = new ChallengeAnswer();
		a1.setAnswer(a);
		a1.setCorrect(c);
		DBConnector.getInstance().save(a1);
		return a1;
	}
	
}
