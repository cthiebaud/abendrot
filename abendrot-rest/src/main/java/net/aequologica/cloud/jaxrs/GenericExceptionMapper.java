package net.aequologica.cloud.jaxrs;

import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class GenericExceptionMapper implements ExceptionMapper<Exception> {
    
    @Override
    public Response toResponse(Exception exception) {
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                        .entity(exception)
                        .type("application/json")
                        .build();    
    }
}
