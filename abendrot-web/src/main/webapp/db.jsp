<!DOCTYPE html>
<%@page import="net.aequologica.cloud.git.GitRepositoryState"%>
<%@   page import="java.sql.ResultSet"
%><%@ page import="java.util.TreeSet"
%><%@ page import="java.util.Properties"
%><%@ page language="java" 
%><html>
<head>
	 <title>candle | db.jsp</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <!-- Bootstrap CSS -->
    <link href="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/css/bootstrap-combined.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
  
    <style type="text/css">
    body {
      padding : 40px;
    }
    </style>
</head>
<body>

<%
String contextName = "java:comp/env";
String resourceName = "jdbc/DefaultDB";
javax.naming.Context initCtx = new javax.naming.InitialContext();
javax.naming.Context envCtx = (javax.naming.Context) initCtx.lookup(contextName);
javax.sql.DataSource datasource = (javax.sql.DataSource)envCtx.lookup(resourceName);
javax.sql.DataSource[] datasources = new javax.sql.DataSource[] {datasource};
%>

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
        <tr>
            <%
            java.sql.Connection connection = null;
            try {
            	connection = datasources[i].getConnection();

                java.sql.DatabaseMetaData databaseMetaData = connection.getMetaData();
                %>
                    <td><!-- 1 --><%=databaseMetaData.getDatabaseProductName()   	%></td>
                    <td><!-- 2 --><%=databaseMetaData.getDatabaseProductVersion()	%></td>
                    <td><!-- 3 --><%=databaseMetaData.getUserName()              	%></td>
                    <td><!-- 4 --><%=databaseMetaData.getDriverName()            	%></td>
                    <td><!-- 5 --><%=databaseMetaData.getDriverVersion()         	%></td>
                    <td><!-- 6 --><%=databaseMetaData.getURL()						%></td>
                    <tr>
                        <td colspan="12">
                            <table><thead><tr><th>schema</th><th>table name</th></tr></thead><tbody>
                <%
                ResultSet tables = null;
                try {
                	tables = databaseMetaData.getTables(null, databaseMetaData.getUserName().toUpperCase(), null, null);
                    while (tables.next()) {
                    	%>
                    	<tr><td>
                    	   <%=tables.getString("TABLE_SCHEM")%>
                    	</td><td>
                    	   <%=tables.getString("TABLE_NAME")%>
                    	</td></tr>
                    	<%
                    }
                } finally {
                	if (tables != null) {
                        try {
	                		tables.close();
                        } catch (java.lang.Error ignored) {
                    	}
                	}
                }
                %>          </tbody></table>
                        </td>
                    </tr><%
                
            } catch (java.lang.Error ignored) {
                %><td colspan="12"><%=ignored.getClass().getName()%>: <b><%=ignored.getMessage()%></b></td>
                <%
            } finally {
            	if (connection != null) {
                    try {
        	    		connection.close();
	                } catch (java.lang.Error ignored) {
    	        	}
            	}
            }
            %>
        </tr>
    <%
    }
    %>
    </tbody>
</table>

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

<!-- Bootstrap -->
<script src="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script type="text/javascript" charset="utf8" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>
<!-- DataTables -->
<script type="text/javascript" charset="utf8" src="https://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
  $('#properties').dataTable( {
    "iDisplayLength": -1,
  });
});
</script>

</html>

