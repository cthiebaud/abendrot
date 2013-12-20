package net.aequologica.cloud.ws;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;

import org.atmosphere.cpr.AtmosphereServlet;

@WebServlet(
        urlPatterns = "/chat/*", 
        asyncSupported = true, 
        loadOnStartup = 0,
        initParams = { 
                @WebInitParam(
                        name = "org.atmosphere.cpr.packages", 
                        value = "net.aequologica.cloud.ws"
                ) 
        }
)

public class Servlet extends AtmosphereServlet implements javax.servlet.Servlet {
       
    private static final long serialVersionUID = 5573979034364944293L;

}
