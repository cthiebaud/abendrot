<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="c"   uri="http://java.sun.com/jstl/core_rt" 
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" 
%><!DOCTYPE html>
<html>
  <head>
	<title>abendrot | hellocloud</title>
	
    <%@include file="/WEB-INF/jspf/header.jspf" %>
    
  </head>
  <body>
  
    <%@include file="/WEB-INF/jspf/navbar.jspf" %>
  
    <div class="container">
    <div class="span9">
  
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
	
    <%@include file="/WEB-INF/jspf/github-ribbon.jspf" %>
	
    </div> <!-- span9 -->
    </div> <!-- container -->

  </body>
	
  <%@include file="/WEB-INF/jspf/footer.jspf" %>
  
  <script type="text/javascript">
  $(document).ready(function(){
	  /*
    $('#hellos').dataTable( {} );
    
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
    
    
$.extend( $.fn.dataTableExt.oStdClasses, {
  "sWrapper": "dataTables_wrapper form-inline"
});
*/
  });
  </script>
  
</html>