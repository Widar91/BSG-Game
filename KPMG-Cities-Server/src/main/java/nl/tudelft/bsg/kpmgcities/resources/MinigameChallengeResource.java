package nl.tudelft.bsg.kpmgcities.resources;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("minigamechallenge")
public class MinigameChallengeResource {
		
	
		@GET
	    @Produces(MediaType.APPLICATION_JSON)
	    public int requestMinigameChallenge(/*opponent id*/) {
				//ask for opponent acceptance
				//if yes (status is READY), return gameID/status
				
				
				return 1;
	    }
	
	
		@POST
	    public int getMinigameChallenge() {
				
				return 1;
	    }
		
}
