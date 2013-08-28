<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><!DOCTYPE html>
<html>
  <head>
	<title>abendrot | hellocloud</title>
	
    <%@include file="/WEB-INF/jspf/header.jspf" %>
    
  </head>
  <body>
  
    <%@include file="/WEB-INF/jspf/navbar.jspf" %>
  
    <div class="container">
    <div class="row">
    <div class="col-lg-9">
  
	<table id="hellos" class="table table-condensed table-hover table-bordered" >
	  <thead>
		<tr>
		  <th>row number</th>
		  <th>database id</th>
          <th>last</th>
          <th>how much</th>
          <th>what</th>
          <th>from</th>
          <th>IPs</th>
        </tr>
      </thead>
      <tbody>
		<c:forEach var="hello" items="${requestScope.helloDao.all}" varStatus="status">
		  <tr>
			<td>${status.index}</td>
			<td>${hello.id}</td>
			<td><fmt:formatDate type="both" value="${hello.when}" /></td>
			<td>${hello.counter}</td>
			<td>hello<c:if test = "${hello.counter > 1}">(s)</c:if> from</td>
			<td>${hello.username}</td>
            <td>
                <c:forEach var="address" items="${hello.addresses}" >
                    <span>${address.ip4}</span>
                </c:forEach>
            </td>
		  </tr>
        </c:forEach>
      </tbody>
	</table>	
	
    </div> <!-- col-lg-9 -->
    </div>
    </div> <!-- container -->

  </body>
	
  <%@include file="/WEB-INF/jspf/footer.jspf" %>
  
  <script type="text/javascript">
  $(document).ready(function(){
	  /*
    $('#hellos').dataTable( {} );
    
"sDom": "<'row'<'col-lg-6'l><'col-lg-6'f>r>t<'row'<'col-lg-6'i><'col-lg-6'p>>",
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
    
    
$.extend( $.fn.dataTableExt.oStdClasses, {
  "sWrapper": "dataTables_wrapper form-inline"
});
*/
  });
  </script>
  
</html>