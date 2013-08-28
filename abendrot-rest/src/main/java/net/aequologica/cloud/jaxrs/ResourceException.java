package net.aequologica.cloud.jaxrs;

import java.io.IOException;

import javax.inject.Singleton;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Singleton
@Path("wrong")
public class ResourceException {
    private static Logger log = LoggerFactory.getLogger(ResourceException.class);
    
    public ResourceException() {
        log.info("ResourceException created!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
    
    @GET
    @Path("badResponse")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response badResponse() {
        return Response.status(Status.METHOD_NOT_ALLOWED).build();
    }

    @GET
    @Path("webException")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public String throwWebException() {
        throw new WebApplicationException("Tu n'as pas le droit !", Status.METHOD_NOT_ALLOWED);
    }

    @GET
    @Path("runtimeException")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response throwRuntimeException() {
        throw new RuntimeException("unexpected exception with cause", new IOException("I am the cause ..."));
    }
}
