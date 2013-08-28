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
    <div class="row">
    <div class="col-lg-9">
  
    <h1><% String username = request.getRemoteUser();
    if (username == null) {
    	%>You are not logged<%
    } else {
        %><%=username%><%
    }
    %></h1>
    
    </div> <!-- col-lg-9 -->
    </div>
    </div> <!-- container -->

  </body>
    
  <%@include file="/WEB-INF/jspf/footer.jspf" %>
  
</html>