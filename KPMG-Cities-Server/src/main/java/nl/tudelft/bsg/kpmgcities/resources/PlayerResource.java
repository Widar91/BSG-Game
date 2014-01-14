package nl.tudelft.bsg.kpmgcities.resources;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import nl.tudelft.bsg.kpmgcities.db.DBConnector;
import nl.tudelft.bsg.kpmgcities.model.Player;
import nl.tudelft.bsg.kpmgcities.utils.JaxbString;

@Path("kpmgcities/player")
public class PlayerResource extends Resource {
	
    @GET
    @Path("/{username}")
    @Produces(MediaType.APPLICATION_JSON)
    public Player getPlayer(@PathParam("username") String username) {
        return DBConnector.getInstance().getPlayer(username, "");
    }
    
    @GET
    @Path("/list/all")
    @Produces(MediaType.APPLICATION_JSON)
    public List<JaxbString> getPlayers() {
    	List<JaxbString> r = new ArrayList<JaxbString>();
    	List<Player> ps = DBConnector.getInstance().getPlayers();
        for (Player p : ps)
        	r.add(new JaxbString(p.getName()));
        return r;
    }
    
    @POST
    @Path("/{username}/setscore/{score}")
    public Response updateOffice3DScore(@PathParam("username") String username, @PathParam("score") String score) {
            Player p = DBConnector.getInstance().getPlayer(username, "");
            p.setOffice3DScore(Integer.parseInt(score));
            
            DBConnector.getInstance().save(p);
            
            return simpleResponse(200);
    }
    
}
