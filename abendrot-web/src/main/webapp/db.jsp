<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><!DOCTYPE html>
<html>
<head>
  <title>abendrot | db.jsp</title>

  <%@include file="/WEB-INF/jspf/header.jspf" %>
    
  </head>
  <body>
   
    <%@include file="/WEB-INF/jspf/navbar.jspf" %>
    
    <div class="container">
    <div class="span9">
  
    <%
  
    String                 contextName  = "java:comp/env";
    String                 resourceName = "jdbc/DefaultDB";
    javax.naming.Context   initCtx      = new javax.naming.InitialContext();
    javax.naming.Context   envCtx       = (javax.naming.Context)initCtx.lookup(contextName);
    javax.sql.DataSource   datasource   = (javax.sql.DataSource)envCtx.lookup(resourceName);
    javax.sql.DataSource[] datasources  = new javax.sql.DataSource[] { datasource }; %>

    <dl class="dl-horizontal">
      <dt>JNDI CONTEXT</dt>
      <dd><%=contextName%></dd>
      <dt>DATASOURCE</dt>
      <dd><%=resourceName%></dd>
    </dl>

    <table id="database" class="table table-condensed table-hover table-bordered">
      <thead>
	    <tr>
	        <!-- 1 --><th>Database Product Name</th>
	        <!-- 2 --><th>Database Product Version</th>
	        <!-- 3 --><th>User Name</th>
	        <!-- 4 --><th>Driver Name</th>
	        <!-- 5 --><th>Driver Version</th>
	        <!-- 6 --><th>URL</th>
	    </tr>
      </thead>
      <tbody>
        <% for (int i = 0; i<datasources.length; i++) { %>
        <tr><%
          java.sql.Connection connection = null;
          try {
            connection = datasources[i].getConnection();

            java.sql.DatabaseMetaData databaseMetaData = connection.getMetaData(); %>
            <td><!-- 1 --><%=databaseMetaData.getDatabaseProductName()      %></td>
            <td><!-- 2 --><%=databaseMetaData.getDatabaseProductVersion()   %></td>
            <td><!-- 3 --><%=databaseMetaData.getUserName()                 %></td>
            <td><!-- 4 --><%=databaseMetaData.getDriverName()               %></td>
            <td><!-- 5 --><%=databaseMetaData.getDriverVersion()            %></td>
            <td><!-- 6 --><%=databaseMetaData.getURL()                      %></td>
          </tr> 
          <tr>
            <td colspan="6">
              <table>
                <thead>
                  <tr>
                    <th>schema</th>
                    <th>table name</th>
                  </tr>
                </thead>
                <tbody>
                  <% java.sql.ResultSet tables = null;
                  try {
                    tables = databaseMetaData.getTables(null, databaseMetaData.getUserName().toUpperCase(), null, null);
                    while (tables.next()) { %>
                      <tr>
                        <td><%=tables.getString("TABLE_SCHEM")%></td>
                        <td><%=tables.getString("TABLE_NAME")%></td>
                      </tr> <% 
                    }
                  } finally {
                    if (tables != null) {
                      try {
                        tables.close();
                      } catch (java.lang.Error ignored) {
                      }
                    }
                  } %>                
                </tbody>
              </table>
            </td>
          <%
          } catch (java.lang.Error ignored) { 
            %><%= ignored.getClass().getName() + " : " + ignored.getMessage()%><%
          } finally {
            if (connection != null) {
              try {
                connection.close();
              } catch (java.lang.Error ignored) {
              }
            }
          } %>
        </tr> <%
        } %>
      </tbody>
    </table>

    <%@include file="/WEB-INF/jspf/github-ribbon.jspf" %>
    
    </div> <!-- span9 -->
    </div> <!-- container -->

  </body>

  <%@include file="/WEB-INF/jspf/footer.jspf" %>
  
</html>

