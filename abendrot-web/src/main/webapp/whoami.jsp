<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><!DOCTYPE html>
<html>
  <head>
    <title>abendrot | whoami</title>
    
    <%@include file="/WEB-INF/jspf/header.jspf" %>
    
  </head>
  <body>
  
    <%@include file="/WEB-INF/jspf/navbar.jspf" %>
  
    <div class="container">
    <div class="span9">
  
    <h1><% String username = request.getRemoteUser();
    if (username == null) {
    	%>You are not logged<%
    } else {
        %><%=username%><%
    }
    %></h1>
    
    <%@include file="/WEB-INF/jspf/github-ribbon.jspf" %>
    
    </div> <!-- span9 -->
    </div> <!-- container -->

  </body>
    
  <%@include file="/WEB-INF/jspf/footer.jspf" %>
  
</html>