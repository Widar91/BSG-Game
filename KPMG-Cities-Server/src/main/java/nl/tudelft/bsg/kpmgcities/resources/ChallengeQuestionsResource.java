package nl.tudelft.bsg.kpmgcities.resources;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import nl.tudelft.bsg.kpmgcities.logic.gamecontents.ChallengeQuestionsContainer;
import nl.tudelft.bsg.kpmgcities.logic.gamecontents.ChallengeQuestionsSet;

@Path("challengequestions")
public class ChallengeQuestionsResource {
	
	@GET
    @Produces(MediaType.APPLICATION_JSON)
    public ChallengeQuestionsSet getChallengeQuestions() {
		return ChallengeQuestionsContainer.getChallengeQuestions();
    }
	
}
