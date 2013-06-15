<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.json.JSONObject,bill.db.JDBServer,bill.bean.*"%>
<%
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%
	String action = request.getParameter("action");
	if (null != action) {
		try {
			JSONObject object = new JSONObject(action);
			int userId = (Integer) session.getAttribute("userId");
			String billSubject = object.getString("billSubject");
			String billTime = object.getString("billTime");
			int billType = object.getInt("billType");
			double billMoney = object.getDouble("billMoney");
			String billDetial = object.getString("billDetial");
			BillData billData = new BillData();
			billData.setUserId(userId);
			billData.setBillSubject(billSubject);
			billData.setBillTime(billTime);
			billData.setBillType(billType);
			billData.setBillMoney((float) billMoney);
			billData.setBillDetial(billDetial);
			int code = JDBServer.getInstance().addBill(billData) ? 1
					: 0;
			out.print(code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}
	String login = request.getParameter("login");
	if (null != login) {
		try {
			JSONObject object = new JSONObject(login);
			String userName = object.getString("user");
			String userPassword = object.getString("pwd");
			int code = 0;
			int userId = JDBServer.getInstance().checkLogin(userName,
					userPassword);
			if (-1 != userId) {
				code = 1;
				session.setAttribute("userId", userId);
				out.print("note.jsp");
			} else {
				out.print(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}

	String delKey = request.getParameter("delKey");
	String userId = request.getParameter("userId");
	if (null != delKey&&null!=userId) {
		boolean flag = JDBServer.getInstance().delKey(
				Integer.parseInt(userId), Long.valueOf(delKey));
		if (flag) {
			out.print(1);
		} else {
			out.print(0);
		}
		System.out.print(flag);
	}

	String detailDate = request.getParameter("detailDate");
	if (null != detailDate) {
		out.print(1 + "<br/>" + "</p>hello<p>");
		return;
	}
	
	String check = request.getParameter("check");
	if(null!=check){
		if(JDBServer.getInstance().existsUser(check)){
			out.println(2);
		}else{
			out.println(1);
		}
		return;	
	}
	
	String reg = request.getParameter("reg");
	if(null!=reg){
		int uid = JDBServer.getInstance().regUser(reg);
		if(uid!=-1){
			session.setAttribute("userId", uid);
			out.print("note.jsp");
		}else{
			out.println(2);
		}
		return;	
	}
	
%>