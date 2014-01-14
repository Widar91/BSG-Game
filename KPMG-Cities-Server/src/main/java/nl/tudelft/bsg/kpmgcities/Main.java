package nl.tudelft.bsg.kpmgcities;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.ws.rs.ext.ContextResolver;

import nl.tudelft.bsg.kpmgcities.db.DBConnector;
import nl.tudelft.bsg.kpmgcities.db.TestDB;

import org.eclipse.persistence.sessions.server.Server;
import org.glassfish.grizzly.http.server.HttpServer;
import org.glassfish.jersey.grizzly2.httpserver.GrizzlyHttpServerFactory;
import org.glassfish.jersey.moxy.json.MoxyJsonConfig;
import org.glassfish.jersey.server.ResourceConfig;

/**
 * Main class.
 * 
 */
public class Main {
	
	public static final Properties Configuration = loadProperties();
	
	// Base URI the Grizzly HTTP server will listen on
	public static final String BASE_URI = (String) Configuration.get("BASE_URI"); 


	public static void main(String[] args) throws IOException {
		final HttpServer server = startServer();

		DBConnector.getInstance();
		TestDB.populateTestDB();

		System.out.println(String.format(
				"Jersey app started with WADL available at "
						+ "%sapplication.wadl\nHit enter to stop it...",
				BASE_URI));
		System.in.read();
		
		DBConnector.getInstance().close();
		server.stop();
	}
	
	/**
	 * Starts Grizzly HTTP server exposing JAX-RS resources defined in this
	 * application.
	 * 
	 * @return Grizzly HTTP server.
	 */
	public static HttpServer startServer() {
		// create a resource config that scans for JAX-RS resources and
		// providers
		// in nl.tudelft.bsg.kpmgcities package
		final ResourceConfig rc = new ResourceConfig()
				.packages("nl.tudelft.bsg.kpmgcities")
				.register(createMoxyJsonResolver());

		// create and start a new instance of grizzly http server
		// exposing the Jersey application at BASE_URI
		return GrizzlyHttpServerFactory.createHttpServer(URI.create(BASE_URI),
				rc);
	}
	

	public static ContextResolver<MoxyJsonConfig> createMoxyJsonResolver() {
		final MoxyJsonConfig moxyJsonConfig = new MoxyJsonConfig();

		Map<String, String> namespacePrefixMapper = new HashMap<String, String>(1);
		namespacePrefixMapper.put("http://www.w3.org/2001/XMLSchema-instance","xsi");
		
		moxyJsonConfig.setNamespacePrefixMapper(namespacePrefixMapper)
				.setNamespaceSeparator(':');
		
		return moxyJsonConfig.resolver();
	}
	
	
    private static Properties loadProperties() {
        Properties properties = new Properties();

        try {
                properties.load(new FileInputStream(System.getProperty("user.dir") + "/KPMG-Cities-Server.properties"));
        
                for(String key : properties.stringPropertyNames()) {
                        String value = properties.getProperty(key);
                }
                
        } catch (IOException e) {
        	System.err.println("Loading properties: " + e);
        }
        
        return properties;
        
}
}
