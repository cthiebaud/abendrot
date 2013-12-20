<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><!DOCTYPE html>
<html>
  <head>
    <title>abendrot | index</title>
    
    <%@include file="/WEB-INF/jspf/header.jspf" %>
    
  </head>
  <body>
    <%@include file="/WEB-INF/jspf/navbar.jspf" %>

<style>
.time {
  color: lightgray;
}

.author {
  font-weight: bold;
}
</style>

<div data-ng-app="angular.atmosphere.chat" data-ng-controller="ChatController">
<div id="header">
  <h3 data-ng-bind="model.header" data-ng-init="model.header=''"></h3> <!-- Atmosphere Chat. Default transport is WebSocket, fallback is long-polling -->
</div>
<p style="float:right;" data-ng-show="!model.connected">Connecting...</p>
<p style="float:right;" >{{model.content}}</p>
<div class="container">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">Chat room</h3>
      </div>
      <div class="panel-body">
        <div class="messages">
          <p data-ng-repeat="message in model.messages">
            <span class="time">{{message.date | date:'shortDate'}} {{message.date|date:'shortTime'}}</span>
            <span class="author">{{message.author}}</span> :
            <span class="text">{{message.text}}</span>
          </p>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
  <span data-ng-show="!model.name">Enter your name:</span>
  <div data-ng-show="model.logged">
    <span><b>{{model.name}}</b> says:</span>
  </div>
  <form role="form" class="form-horizontal">
    <div class="form-group">
      <div class="col-lg-9">
        <input type="text" class="form-control" id="input" data-ng-disabled="!model.connected" x-webkit-speech/>
      </div>
    </div>
  </form>
  </div>
</div>
</div>

  </body>
  
  <%@include file="/WEB-INF/jspf/footer.jspf" %>
  
</html>

<script type="text/javascript" src="<c:url value='/javascript/atmosphere.js'/>"></script>

<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min.js"></script>

<script type="text/javascript" src="<c:url value='/scripts/angular-atmosphere-service.js'/>"></script>

<script type="text/javascript" >
angular.module('angular.atmosphere.chat', ['angular.atmosphere']);

function ChatController($scope, atmosphereService){
  $scope.model = {
    transport: 'websocket'
    , name: 
    <c:if test="${empty requestScope.userInfo.firstname}">'${requestScope.userInfo.id}'</c:if>
    <c:if test="${not empty requestScope.userInfo.firstname}">'${requestScope.userInfo.firstname}'</c:if>
    , messages: []
  };
  
  $scope.model.logged = !(!$scope.model.name);

  var socket;

  var request = {
    url: "<c:url value='/chat'/>",
    contentType: 'application/json',
    logLevel: 'debug',
    transport: 'websocket',
    trackMessageLength: true,
    reconnectInterval: 5000,
    enableXDR: true,
    timeout: 60000
  };

  request.onOpen = function(response){
    $scope.model.transport = response.transport;
    $scope.model.connected = true;
    $scope.model.content = 'connected using ' + response.transport;
  };

  request.onClientTimeout = function(response){
    $scope.model.content = 'Client closed the connection after a timeout. Reconnecting in ' + request.reconnectInterval;
    $scope.model.connected = false;
    socket.push(atmosphere.util.stringifyJSON({ author: author, message: 'is inactive and closed the connection. Will reconnect in ' + request.reconnectInterval }));
    setTimeout(function(){
      socket = atmosphereService.subscribe(request);
    }, request.reconnectInterval);
  };

  request.onReopen = function(response){
    $scope.model.connected = true;
    $scope.model.content = 're-connected using ' + response.transport;
  };

  // For demonstration of how you can customize the fallbackTransport using the onTransportFailure function
  request.onTransportFailure = function(errorMsg, request){
    atmosphere.util.info(errorMsg);
    request.fallbackTransport = 'long-polling';
    $scope.model.header = ''; // 'Atmosphere Chat. Default transport is WebSocket, fallback is ' + request.fallbackTransport;
  };

  request.onMessage = function(response){
    var responseText = response.responseBody;
    try{
      var message = atmosphere.util.parseJSON(responseText);
      if(!$scope.model.logged && $scope.model.name)
        $scope.model.logged = true;
      else{
        var date = typeof(message.time) === 'string' ? parseInt(message.time) : message.time;
        $scope.model.messages.push({author: message.author, date: new Date(date), text: message.message});
      }
    }catch(e){
      console.error("Error parsing JSON: ", responseText);
      throw e;
    }
  };

  request.onClose = function(response){
    $scope.model.connected = false;
    $scope.model.content = 'Server closed the connection after a timeout';
    socket.push(atmosphere.util.stringifyJSON({ author: $scope.model.name, message: 'disconnecting' }));
  };

  request.onError = function(response){
    $scope.model.content = "Sorry, but there's some problem with your socket or the server is down";
    $scope.model.logged = false;
  };

  request.onReconnect = function(request, response){
    $scope.model.content = 'Connection lost. Trying to reconnect ' + request.reconnectInterval;
    $scope.model.connected = false;
  };

  socket = atmosphereService.subscribe(request);

  var input = $('#input');
  input.keydown(function(event){
    var me = this;
    var msg = $(me).val();
    if(msg && msg.length > 0 && event.keyCode === 13){
      $scope.$apply(function(){
        // First message is always the author's name
        if(!$scope.model.name)
          $scope.model.name = msg;

        socket.push(atmosphere.util.stringifyJSON({author: $scope.model.name, message: msg}));
        $(me).val('');
      });
    }
  });
}
</script>

