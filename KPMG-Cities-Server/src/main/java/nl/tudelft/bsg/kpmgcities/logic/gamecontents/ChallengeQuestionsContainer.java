package nl.tudelft.bsg.kpmgcities.logic.gamecontents;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class ChallengeQuestionsContainer {
	
	private static String [] challenge = { "Quesion 0",
											"Quesion 1",
											"Quesion 2",
											"Quesion 3",
											"Quesion 4",
											"Quesion 5",
											"Quesion 6",
											"Quesion 7",
											"Quesion 8",
											"Quesion 9"
										  };
	
	public static ChallengeQuestionsSet getChallengeQuestions() {
		
		ChallengeQuestionsSet cqs;
		List<String> rndQuestions = new ArrayList<String>();
		
		String question;
		Random rnd = new Random();
		
		while(rndQuestions.size() < 5) {
			
			question = challenge[rnd.nextInt(challenge.length)];
			
			if(!rndQuestions.contains(question))
				rndQuestions.add(rndQuestions.size(), question);
		}
		
		cqs = new ChallengeQuestionsSet();
		cqs.setQuestions(rndQuestions);
		return cqs;
	}
}
