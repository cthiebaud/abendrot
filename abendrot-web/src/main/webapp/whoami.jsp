<%@page import="net.aequologica.cloud.git.GitRepositoryState"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><!DOCTYPE html>
<html>
  <head>
    <title>abendrot | whoami</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <h1><%=request.getRemoteUser() %></h1>
    
<%
Properties gitproperties = new Properties();
gitproperties.load(this.getClass().getClassLoader().getResourceAsStream("git.properties"));
GitRepositoryState gitRepositoryState = new GitRepositoryState(gitproperties);
if (gitRepositoryState.getCommitIdDescribe().indexOf("dirty") == -1) {
%>    <a href="https://github.com/cthiebaud/abendrot/commit/<%=gitRepositoryState.getCommitId()%>" target="_blank">
      <img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_orange_ff7600.png" alt="Fork me on GitHub">
    </a>
<%} %>
    
  </body>
</html>