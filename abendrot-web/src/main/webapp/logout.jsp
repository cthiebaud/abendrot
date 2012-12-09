<!DOCTYPE html>
<%@page import="net.aequologica.cloud.git.GitRepositoryState"%>
<%@page import="java.util.Properties"%>
<%@page import="java.lang.reflect.Method"%>
<%@page import="javax.security.auth.login.LoginException"%>
<%@page import="javax.security.auth.login.LoginContext"%>

<%
String result = "";
String reason = "";

LoginContext login = null;
if (request.getRemoteUser() != null) {
  try {
    Class<?> loginContextFactoryClass = this.getClass().getClassLoader().loadClass("com.sap.security.auth.login.LoginContextFactory");
    
    if (loginContextFactoryClass != null) {
      Method method = loginContextFactoryClass.getMethod("createLoginContext");
      login = (LoginContext)method.invoke(null);
      login.logout();
      result = "You have successfully logged out.";
      reason = "Congratulations.";
    }
  } catch (Exception e) {
    // Servlet container handles the login exception. It throws it to the application for its information
    result = "Logout failed.";
    reason = e.getClass().getName() + " " + e.getMessage();
  }
}
else {
   result = "You were already logged out.";
   reason = "Current user is Guest.";
}  
%>
  
<html>
  <head>
    <title>abendrot | logout</title>
  </head>
  <body>
    <h1><%=result%></h1>
    <div><%=reason%></div>
    
<%
Properties properties = new Properties();
properties.load(this.getClass().getClassLoader().getResourceAsStream("git.properties"));
GitRepositoryState gitRepositoryState = new GitRepositoryState(properties);
if (gitRepositoryState.getCommitIdDescribe().indexOf("dirty") == -1) {
%>    <a href="https://github.com/cthiebaud/abendrot/commit/<%=gitRepositoryState.getCommitId()%>" target="_blank">
      <img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_orange_ff7600.png" alt="Fork me on GitHub">
    </a>
<%} %>
    
    
  </body>      
</html>
