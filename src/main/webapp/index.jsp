<%@page import="net.aequologica.cloud.GitRepositoryState"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hello, SAP NetWeaver Cloud!</title>
<!-- 
<%
Properties properties = new Properties();
properties.load(getClass().getClassLoader().getResourceAsStream("git.properties"));

GitRepositoryState gitRepositoryState = new GitRepositoryState(properties);

out.write(gitRepositoryState.toString());
%>
-->

</head>
<body>
	<h1>Hello, <a href="http://scn.sap.com/community/developer-center/cloud-platform">SAP NetWeaver Cloud</a>!</h1>
	<a href="https://github.com/cthiebaud/abendrot/commit/<%=gitRepositoryState.getCommitId()%>">
		<img style="position: absolute; top: 0; right: 0; border: 0;"
			src="https://s3.amazonaws.com/github/ribbons/forkme_right_orange_ff7600.png"
			alt="Fork me on GitHub">
	</a>
</body>
</html>