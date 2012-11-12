package net.aequologica.cloud.jaxrs;

import javax.inject.Singleton;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Singleton
@Path("hello")
public class Resource {
	private static Logger log = LoggerFactory.getLogger(Resource.class);

    public Resource() {
    	log.info("Resource created!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	}

	@GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getIt() {
        return "Hello, World!";
    }
}
