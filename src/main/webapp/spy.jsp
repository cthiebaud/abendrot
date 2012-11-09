<%@  page language="java"
%><%@page import="java.util.Map"
%><%@page import="java.util.Properties"
%><%@page import="java.util.TreeSet"
%><!DOCTYPE html>
<html>
  <head>
    <title>abendrot | spy</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href='http://fonts.googleapis.com/css?family=Inconsolata' rel='stylesheet' type='text/css'>
  </head>
  <body>
    <table id="properties">
      <caption>java system properties</caption>
      <thead>
        <tr>
          <th>key</th>
          <th>value</th>
        </tr>
      </thead>
      <tbody>
<% Properties properties = System.getProperties();
for (String key : new TreeSet<String>(properties.stringPropertyNames())) { %>
        <tr>
          <td><%=key                          %></td>
          <td><%=properties.getProperty(key) %></td>
        </tr>
<% } %>
      </tbody>
    </table>
  </body>
</html>
