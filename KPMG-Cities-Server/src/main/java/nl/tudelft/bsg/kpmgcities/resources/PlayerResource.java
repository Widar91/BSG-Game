package nl.tudelft.bsg.kpmgcities.resources;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import nl.tudelft.bsg.kpmgcities.db.DBConnector;
import nl.tudelft.bsg.kpmgcities.model.Player;

@Path("player")
public class PlayerResource {
	
    @GET
    @Path("/{username}")
    @Produces(MediaType.APPLICATION_JSON)
    public Player getPlayer(@PathParam("username") String username) {
        return DBConnector.getInstance().getPlayer(username, "");
    }
    
}
