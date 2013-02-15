package net.aequologica.cloud.jaxrs;

import java.util.Date;

import javax.inject.Singleton;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import net.aequologica.cloud.jaxrs.model.Embedded;
import net.aequologica.cloud.jaxrs.model.Input;
import net.aequologica.cloud.jaxrs.model.Output;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.jaxrs.json.annotation.JacksonFeatures;
*/

@Singleton
@Path("complex")
public class ResourceComplex {
	private static Logger log = LoggerFactory.getLogger(ResourceComplex.class);

    public ResourceComplex() {
    	log.info("ResourceComplex created!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	}

	@POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
	// @JacksonFeatures(serializationDisable={Seriali/zationFeature.FAIL_ON_EMPTY_BEANS})
    public Output getIt(Input input) {
		Output output = new Output();
		output.setId(12L);
		output.setName("echo: "+input.getName());
		output.setDate(new Date());
		Embedded embedded = new Embedded();
		output.setEmbedded(embedded);
		
        return output;
    }
}
