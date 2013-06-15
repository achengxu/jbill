<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>账单系统</title>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
		*{font-size:12px;}
		a{text-decoration:none;}
</style>
  </head>
  
  <body>
   		<h3></h3>
   		<a href="login.jsp">登录</a>
   		|
   		<a href="register.jsp">注册</a>
  </body>
</html>
