<%@  page language="java"
%><%@page import="java.util.Map"
%><%@page import="java.util.Properties"
%><%@page import="java.util.TreeSet"
%><!DOCTYPE html>
<html>
  <head>
    <title>abendrot | spy</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <!-- Bootstrap CSS -->
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/css/bootstrap-combined.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
  
    <style type="text/css">
    body {
      padding : 40px;
    }
    </style>
  </head>
  
  <body>
    <table id="properties" class="table table-striped table-bordered">
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
  
  <!-- Bootstrap -->
  <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/js/bootstrap.min.js"></script>
  <!-- jQuery -->
  <script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>
  <!-- DataTables -->
  <script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
  
  <script type="text/javascript">
  $(document).ready(function(){
    $('#properties').dataTable( {
      "iDisplayLength": -1,
    });
  });
  </script>

</html>
