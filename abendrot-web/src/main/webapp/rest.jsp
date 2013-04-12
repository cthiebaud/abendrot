<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><!DOCTYPE html>
<html>
  <head>
    <title>abendrot | rest</title>
    
    <%@include file="/WEB-INF/jspf/header.jspf" %>
    
  </head>
  <body>
    <%@include file="/WEB-INF/jspf/navbar.jspf" %>
    
    <div class="container">
    <div class="span9">
    
  	<h1>REST</h1>
  	<h2 class="page-header">plain/text</h2>
    <a class="btn btn-primary" href="<c:url value='/resources/hello'/>">GET 'Hello, World!'</a>
    
  	<h2 class="page-header">application/json</h2>
  	<h3>input</h3>
  	<pre id="input"></pre>
  	<span class="btn btn-primary" id="post">POST</span>  <span class="btn" id="clearPost">clear output</span>
  	<h3>output</h3>
  	<pre id="complexOutput" style="visibility:hidden"></pre>
  	<span id="duration" class="label" style="visibility:hidden"></span>
    
    <%@include file="/WEB-INF/jspf/github-ribbon.jspf" %>
    
    </div> <!-- span9 -->
    </div> <!-- container -->

  </body>
  
  <%@include file="/WEB-INF/jspf/footer.jspf" %>
  <script type="text/javascript">
  $(document).ready(function(){
	  
	   var input = JSON.stringify({"id":1,"name":'Hello, World!',"date": /*"2013-02-15T14:41:58.938+0100" , */moment().format("YYYY-MM-DD[T]HH:mm:ss.SSSZZ")}, null, "\t");
	   
	   $("#input").append(input);
	   
	   $('#clearPost').click(function() {
			  $("#complexOutput").css("visibility", "hidden");
			  $("#duration").css("visibility", "hidden");
   	 });
	    	
	   
	    $('#post').click(function() {
	    	
			$("#complexOutput").empty();
			$("#duration").empty();
			
		    var debut = moment();
			
	    	$.ajax({  
	    		  url: "<c:url value='/resources/complex'/>",  
	    		  type: "POST",  
	    		  dataType: "json",  
	    		  contentType: "application/json",  
	    		  data: input,  
	    		  success: function(data){              
      			      var fin = moment();
	    			  $("#complexOutput").append(JSON.stringify(data, null, "\t"));
	    			  $("#complexOutput").append("\n\n");
	    			  $("#complexOutput").append("(output.date as a javascript date: "+new Date(data.date)+")");

    				  $("#duration").append("duration = "+ moment.duration(fin-debut).asMilliseconds() + " milliseconds");

	    			  $("#complexOutput").css("visibility", "visible");
	    			  $("#duration").css("visibility", "visible");
	    		  },  
	    		  error: function(){  
	    		    alert("fail :-(");  
	    		  }  
	    		});  	    	
     	 });
	  });
  </script>

  
</html>
