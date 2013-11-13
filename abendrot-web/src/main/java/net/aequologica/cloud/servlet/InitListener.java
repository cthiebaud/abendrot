package net.aequologica.cloud.servlet;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;

@WebListener
public class InitListener implements ServletContextListener {
    
    public InitListener() {
    }
    
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        String contextName = "java:comp/env";
        String resourceName = "jdbc/DefaultDB";
        Context initCtx;
        Connection connection = null;
        String databaseProductName = "";
        try {
            initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup(contextName);
            DataSource datasource = (DataSource) envCtx.lookup(resourceName);
            
            connection = datasource.getConnection();
            
            DatabaseMetaData databaseMetaData = connection.getMetaData();
            databaseProductName = databaseMetaData.getDatabaseProductName();
            if (databaseProductName.equalsIgnoreCase("HDB")) {
                databaseProductName = "HANA";
            }
            
        } catch (Exception e) {
        } finally {
            servletContextEvent.getServletContext().setAttribute("databaseProductName", databaseProductName);
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ignored) {
                }
            }
        }
        
    }
    
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        servletContextEvent.getServletContext().removeAttribute("databaseProductName");
    }
    
}
