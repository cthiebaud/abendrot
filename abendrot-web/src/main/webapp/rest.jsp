<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>abendrot | rest</title>

<%@include file="/WEB-INF/jspf/header.jspf"%>

</head>
<body>
  <%@include file="/WEB-INF/jspf/navbar.jspf"%>

  <div class="container">
   <div class="row">
    <div class="col-lg-9">

      <h1>REST</h1>
      <h2 class="page-header">plain/text</h2>
      <a class="btn btn-primary" href="<c:url value='/resources/hello'/>">GET 'Hello, World!'</a>

      <h2 class="page-header">application/json</h2>
      <h3>input</h3>
      <pre id="input"></pre>
      <span class="btn btn-primary" id="post">POST</span> <span class="btn" id="clearPost">clear output</span>
      <h3>output</h3>
      <pre id="complexOutput" style="visibility: hidden"></pre>
      <span id="duration" class="label" style="visibility: hidden"></span>

      <h2 class="page-header">things can go wrong</h2>
      
      <h3 class="page-header">bad response</h3>
      <span class="btn btn-primary" id="bad-response">get!</span>

      <h3 class="page-header">web exception</h3>
      <span class="btn btn-primary" id="web-exception">throw!</span>

      <h3 class="page-header">runtime exception</h3>
      <span class="btn btn-primary" id="runtime-exception">throw!</span>

    </div>
    <!-- col-lg-9 -->
   </div>
  </div>
  <!-- container -->

</body>

<%@include file="/WEB-INF/jspf/footer.jspf"%>

<script type="text/javascript">
  $(document).ready(function() {
    
    var input = JSON.stringify({
      "id" : 1,
      "name" : 'Hello, World!',
      "date" : moment().format("YYYY-MM-DD[T]HH:mm:ss.SSSZZ")
    }, null, "\t");
    
    $("#input").append(input);
    
    $('#clearPost').click(function() {
      $("#complexOutput").css("visibility", "hidden");
      $("#duration").css("visibility", "hidden");
    });
    
    function isJsonString(str) {
      try {
          JSON.parse(str);
      } catch (e) {
          return false;
      }
      return true;
    }
    
    function myFail(jqXHR, textStatus, errorThrown) {
      var text;
      if (isJsonString(jqXHR.responseText)) {
        var jsonObject = JSON.parse(jqXHR.responseText);
        if (typeof jsonObject.message !== "undefined") {
          text = jsonObject.message;
        } else {
          text = jqXHR.responseText;
        }
      } else {
        text = jqXHR.responseText;
      }
      alert("fail :-( \n\n"+text+"\njqXHR.status="+jqXHR.status+"\ntextStatus=" + textStatus + "\nerrorThrown=" + errorThrown);
    }
    
    $('#post').click(function() {
      
      $("#complexOutput").empty();
      $("#duration").empty();
      
      var debut = moment();
      
      $.ajax({
        url : "<c:url value='/resources/complex'/>",
        type : "POST",
        dataType : "json",
        contentType : "application/json",
        data : input
      }).done(function(data, textStatus, jqXHR) {
        var fin = moment();
        $("#complexOutput").append(JSON.stringify(data, null, "\t"));
        $("#complexOutput").append("\n\n");
        $("#complexOutput").append("(output.date as a javascript date: " + new Date(data.date) + ")");
        
        $("#duration").append("duration = " + moment.duration(fin - debut).asMilliseconds() + " milliseconds");
        
        $("#complexOutput").css("visibility", "visible");
        $("#duration").css("visibility", "visible");
      }).fail(function(jqXHR, textStatus, errorThrown) {
        myFail(jqXHR, textStatus, errorThrown)
      }).always(function(data_or_jqXHR, textStatus, jqXHR_or_errorThrow) {
      });
      
    });
    
    $('#bad-response').click(function() {
      
      $.ajax({
        url : "<c:url value='/resources/wrong/badResponse'/>",
        type : "GET",
        dataType : "json",
        contentType : "application/json"
      }).done(function(data, textStatus, jqXHR) {
      }).fail(function(jqXHR, textStatus, errorThrown) {
        myFail(jqXHR, textStatus, errorThrown)
      }).always(function(data_or_jqXHR, textStatus, jqXHR_or_errorThrow) {
      });
      
    });
    
    $('#web-exception').click(function() {
      
      $.ajax({
        url : "<c:url value='/resources/wrong/webException'/>",
        type : "GET",
        dataType : "json",
        contentType : "application/json"
      }).done(function(data, textStatus, jqXHR) {
      }).fail(function(jqXHR, textStatus, errorThrown) {
        myFail(jqXHR, textStatus, errorThrown)
      }).always(function(data_or_jqXHR, textStatus, jqXHR_or_errorThrow) {
      });
      
    });
    
    $('#runtime-exception').click(function() {
      
      $.ajax({
        url : "<c:url value='/resources/wrong/runtimeException'/>",
        type : "GET",
        dataType : "json",
        contentType : "application/json"
      }).done(function(data, textStatus, jqXHR) {
      }).fail(function(jqXHR, textStatus, errorThrown) {
        myFail(jqXHR, textStatus, errorThrown)
      }).always(function(data_or_jqXHR, textStatus, jqXHR_or_errorThrow) {
      });
      
    });
  });
</script>


</html>
