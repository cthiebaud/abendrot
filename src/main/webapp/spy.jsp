<%@page import="java.util.Map"%>
<%@  page language="java" 
%><%@page import="java.util.TreeSet"
%><%@page import="java.util.Properties"
%><!DOCTYPE html>
<html>
  <head>
    <title>abendrot | spy</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <table id="properties" style="border:solid gray thin">
      <caption>java system properties</caption>
      <thead>
        <tr>
          <th>key</th>
          <th>value</th>
        </tr>
      </thead>
      <tbody>
<% 
Properties properties = System.getProperties();
for(String key : new TreeSet<String>(properties.stringPropertyNames())) { %>
        <tr>
          <td><%=key   	                   %></td>
          <td><%=properties.getProperty(key) %></td>
        </tr>
<% } %>      	      
      </tbody>
    </table>
    <table id="environment" style="border:solid gray thin">
      <caption>environment variables</caption>
      <thead>
        <tr>
          <th>key</th>
          <th>value</th>
        </tr>
      </thead>
      <tbody>
<% 
Map<String, String> env = System.getenv();
for(String key : new TreeSet<String>(env.keySet())) { %>
        <tr>
          <td><%=key   	                   %></td>
          <td><%=env.get(key) %></td>
        </tr>
<% } %>      	      
      </tbody>
    </table>
  </body>
</html>
