package nl.tudelft.bsg.kpmgcities.resources;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("")
public class CrossDomainResource {
	
    @GET
    @Path("crossdomain.xml")
    @Produces(MediaType.APPLICATION_XML)
    public String getCrossDomain() {
        return    "<?xml version=\"1.0\"?>"
        		+ "<cross-domain-policy>"
        		+ "<allow-access-from domain=\"*\"/>"
        		+ "</cross-domain-policy>";
    }

}
