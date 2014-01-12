package nl.tudelft.bsg.kpmgcities.resources;

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

@Path("player")
public class PlayerResource extends Resource {
	
    @GET
    @Path("/{username}")
    @Produces(MediaType.APPLICATION_JSON)
    public Player getPlayer(@PathParam("username") String username) {
        return DBConnector.getInstance().getPlayer(username, "");
    }
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updatePlayer(Player p) {
            DBConnector.getInstance().save(p);
            return simpleResponse(200);
    }
    
}
