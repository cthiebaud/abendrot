<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%
  String result = "";
  String reason = "";

  javax.security.auth.login.LoginContext login = null;
  if (request.getRemoteUser() != null) {
    try {
      Class<?> loginContextFactoryClass = this.getClass().getClassLoader().loadClass("com.sap.security.auth.login.LoginContextFactory");
    
      if (loginContextFactoryClass != null) {
    	java.lang.reflect.Method method = loginContextFactoryClass.getMethod("createLoginContext");
        login = (javax.security.auth.login.LoginContext)method.invoke(null);
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
%><!DOCTYPE html>
  
<html>
  <head>
    <title>abendrot | logout</title>
    
    <%@include file="/WEB-INF/jspf/header.jspf" %>
    
  </head>
  <body>
   
    <%@include file="/WEB-INF/jspf/navbar.jspf" %>
    
    <div class="container">
    <div class="span9">
  
    <h1><%=result%></h1>
    <div><%=reason%></div>
    
    <%@include file="/WEB-INF/jspf/github-ribbon.jspf" %>
    
    </div> <!-- span9 -->
    </div> <!-- container -->

  </body>      
  
  <%@include file="/WEB-INF/jspf/footer.jspf" %>
  
</html>
