package nl.tudelft.bsg.kpmgcities.db;

import nl.tudelft.bsg.kpmgcities.model.ChallengeQuestion;
import nl.tudelft.bsg.kpmgcities.model.Player;

public class TestDB {
	
	public static void populateTestDB() {
		if(DBConnector.getInstance().getPlayers().size() == 0) {
			Player pl = new Player();
			pl.setName("Eddy");
			pl.setOffice("Amsterdam");
			pl.setDepartment("IT");
			DBConnector.getInstance().save(pl);
			
			Player pl2 = new Player();
			pl2.setName("Rambo");
			pl2.setOffice("Amsterdam");
			pl2.setDepartment("IT");
			DBConnector.getInstance().save(pl2);
			
			ChallengeQuestion q1 = new ChallengeQuestion();
			q1.setQuestion("wtf?");
			DBConnector.getInstance().save(q1);
			
			ChallengeQuestion q2 = new ChallengeQuestion();
			q2.setQuestion("wtf2?");
			DBConnector.getInstance().save(q2);
			
			ChallengeQuestion q3 = new ChallengeQuestion();
			q3.setQuestion("wtf3?");
			DBConnector.getInstance().save(q3);
			
			ChallengeQuestion q4 = new ChallengeQuestion();
			q4.setQuestion("wtf4?");
			DBConnector.getInstance().save(q4);
			
			ChallengeQuestion q5 = new ChallengeQuestion();
			q5.setQuestion("wtf5?");
			DBConnector.getInstance().save(q5);
			
			ChallengeQuestion q6 = new ChallengeQuestion();
			q6.setQuestion("wtf6?");
			DBConnector.getInstance().save(q6);
			
			ChallengeQuestion q7 = new ChallengeQuestion();
			q7.setQuestion("wtf7?");
			DBConnector.getInstance().save(q7);
			
			ChallengeQuestion q8 = new ChallengeQuestion();
			q8.setQuestion("wtf8?");
			DBConnector.getInstance().save(q8);
			
		}
	}
	
}
