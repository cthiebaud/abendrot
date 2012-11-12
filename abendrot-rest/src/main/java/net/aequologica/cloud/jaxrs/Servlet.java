package net.aequologica.cloud.jaxrs;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;

import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.servlet.ServletContainer;

@WebServlet( 
	urlPatterns = "/resources/*" , 
	initParams 	= @WebInitParam(name = "javax.ws.rs.Application", value = "net.aequologica.cloud.jaxrs.Application"))					
public class Servlet extends ServletContainer {

	private static final long serialVersionUID = -7330108202178070064L;

	public Servlet() {
	}

	public Servlet(ResourceConfig resourceConfig) {
		super(resourceConfig);
	}
}
