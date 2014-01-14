package nl.tudelft.bsg.kpmgcities.resources.minigames.multiplayerchallenge;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import nl.tudelft.bsg.kpmgcities.db.DBConnector;
import nl.tudelft.bsg.kpmgcities.model.Player;
import nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge.ChallengeQuestion;
import nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge.ChallengeResult;
import nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge.MinigameChallenge;
import nl.tudelft.bsg.kpmgcities.model.minigames.multiplayerchallenge.MinigameChallengeStatus;
import nl.tudelft.bsg.kpmgcities.resources.Resource;

@Path("kpmgcities/minigamechallenge")
public class MinigameChallengeResource extends Resource{
		
	
	@GET
	@Path("/{player}")
	public List<MinigameChallenge> getMinigameChallenge(@PathParam("player") String player) {
		return DBConnector.getInstance().getMinigameChallenges(player);
	}
	
	@PUT
	@Path("/new")
    public MinigameChallenge requestMinigameChallenge(@QueryParam(value = "players") final List<String> players) {
			MinigameChallenge c = new MinigameChallenge();
			
			
			Player p1 = DBConnector.getInstance().getPlayer(players.get(0), "");
			Player p2 = DBConnector.getInstance().getPlayer(players.get(1), "");

			System.err.println("creating Challenge + " + p1.getName() + ", " + p2.getName());
			
			if(p1 == null || p2 == null)
				return null;
			
			c.setPlayer1(players.get(0));
			c.setPlayer2(players.get(1));
			
			c.setQuestions(getRandomChallengeQuestions());
			c.setStatus(MinigameChallengeStatus.ACTIVE);
			
			DBConnector.getInstance().save(c);
			
			return DBConnector.getInstance().getMinigameChallenge(c.getId());
    }
	
    @POST
    @Path("/result/{cid}/{pl}")
    @Consumes(MediaType.APPLICATION_JSON)
    public MinigameChallenge updateResult(@PathParam("cid") int cid, @PathParam("pl") String pl, ChallengeResult r) {
    		
    		ChallengeResult cr = new ChallengeResult();
    		cr.setTime(r.getTime());
    		cr.setCorrectAnswers(r.getCorrectAnswers());
            DBConnector.getInstance().save(cr);

    		
    		MinigameChallenge c = DBConnector.getInstance().getMinigameChallenge(cid);
    		
    		if(c.getPlayer1().equalsIgnoreCase(pl)) {
    			c.setResult1(cr);
    			c.setStatus(MinigameChallengeStatus.WAITING_FOR_OPPONENT);
    		}
    		else {
    			c.setResult2(cr);
    			c.setStatus(MinigameChallengeStatus.WAITING_FOR_RESULTS);
    		}
    		
    		if(c.getResult1() != null && c.getResult2() != null)
    			c.setStatus(MinigameChallengeStatus.TERMINATED);
    		
            DBConnector.getInstance().save(c);
            return DBConnector.getInstance().getMinigameChallenge(cid);
    }
	
	
	

	
	private List<ChallengeQuestion> getRandomChallengeQuestions() {
		
		Random rnd = new Random();
		ChallengeQuestion question;
		List<ChallengeQuestion> rndQuestions = new ArrayList<ChallengeQuestion>();
		List<ChallengeQuestion> challengeQuestions = DBConnector.getInstance().getChallengeQuestions();

		if(challengeQuestions.isEmpty()) 
			return rndQuestions;

		while(rndQuestions.size() < 5) {
			question = challengeQuestions.get(rnd.nextInt(challengeQuestions.size()));

			if(!rndQuestions.contains(question))
				rndQuestions.add(rndQuestions.size(), question);
		}
		
		return rndQuestions;
	}
}
