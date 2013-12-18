package nl.tudelft.bsg.kpmgcities.resources;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.mysql.jdbc.log.Log;

import nl.tudelft.bsg.kpmgcities.db.DBConnector;
import nl.tudelft.bsg.kpmgcities.model.ChallengeQuestion;

@Path("challengequestions")
public class ChallengeQuestionsResource {
	
	@GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<ChallengeQuestion> getChallengeQuestions() {
			System.err.println("ChallengeQuestion request received");
			return getRandomChallengeQuestions();
    }
	
	private List<ChallengeQuestion> getRandomChallengeQuestions() {
		
		Random rnd = new Random();
		ChallengeQuestion question;
		List<ChallengeQuestion> rndQuestions = new ArrayList<ChallengeQuestion>();
		List<ChallengeQuestion> challengeQuestions = DBConnector.getInstance().getChallengeQuestions();
		System.err.println("questions taken from db");
		if(challengeQuestions.isEmpty()) 
			return rndQuestions;
		System.err.println("questions not empty");
		while(rndQuestions.size() < 5) {

			question = challengeQuestions.get(rnd.nextInt(challengeQuestions.size()));
			System.err.println("taken question");
			if(!rndQuestions.contains(question))
				rndQuestions.add(rndQuestions.size(), question);
		}
		
		System.err.println("questions"+rndQuestions.toString());
		return rndQuestions;
	}
	
}
