<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String word = request.getParameter("word");
	if (null != word) {
		out.print("a,b,b,c"+word+"e");
	}
%>
