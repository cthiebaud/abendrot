<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
	<head>
	<title>abendrot | hellocloud</title>
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
		<h1>${requestScope.remoteUser}</h1>
	
        <table id="hellos" class="table table-striped table-bordered" cellpadding="0" cellspacing="0" border="0" >
		    <thead>
		      <tr>
		        <th>#</th>
		        <th>id</th>
		        <th>when</th>
		        <th>how much</th>
		        <th>what</th>
		        <th>from</th>
		      </tr>
		    </thead>
		    <tbody>
			    <c:forEach var="hello" items="${requestScope.helloDao.all}" varStatus="status">
			      <tr>
			        <td>${status.index}</td>
			        <td>${hello.id}</td>
			        <td><fmt:formatDate type="both" value="${hello.when}" /></td>
			        <td>${hello.count}</td>
			        <td>hello<c:if test = "${hello.count > 1}">s</c:if> from</td>
			        <td>${hello.username}</td>
			      </tr>
			    </c:forEach>
			</tbody>
	    </table>	
	
	</body>
  <!-- Bootstrap -->
  <script src="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/js/bootstrap.min.js"></script>
  <!-- jQuery -->
  <script type="text/javascript" charset="utf8" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>
  <!-- DataTables -->
  <script type="text/javascript" charset="utf8" src="https://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
  
  <script type="text/javascript">
  $(document).ready(function(){
    $('#hellos').dataTable( {
    	"sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
      "bAutoWidth": false,
      "iDisplayLength": -1,
      "bFilter": false,
      "bInfo": false,
      "bLengthChange": false,
      "bPaginate": false,
      "bScrollInfinite": true,
      "bScrollCollapse": true,
      "sScrollY": "200px",
      "bSort": false,
    });
    
    $.extend( $.fn.dataTableExt.oStdClasses, {
        "sWrapper": "dataTables_wrapper form-inline"
    } );    
  });
  </script>
  
</html>