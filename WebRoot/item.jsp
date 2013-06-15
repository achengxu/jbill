<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.json.JSONObject,bill.db.JDBServer,bill.bean.*"%>
<%
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%
	String s = request.getParameter("s");
	String uid =request.getParameter("uid");
	String key = null;
	int type = 0;
	String start = null;
	String end = null;
	if(null!=s&&null!=uid){
	java.util.List<bill.bean.BillData> list = new java.util.ArrayList<bill.bean.BillData>();
	
		try {
			JSONObject object = new JSONObject(s);
			key = object.getString("key");
			 type = object.getInt("type");
			 start = object.getString("start");
			 end = object.getString("end");
			list = JDBServer.getInstance().getUserBillList(Integer.parseInt(uid),key,start,end,type);
			out.print(1);
		}catch(Exception e){
			e.printStackTrace();
			return;
		}	
		%>
		<table>
		<tr>
		    <th>项目</th>
		    <th>时间</th>
		    <th>金额</th>
		    <th>备注</th>
		   
	  	</tr>
	  	 <%
		    	int total = 0;
		    	for(bill.bean.BillData data:list){
		    		total+=data.getBillType()==1?-1*data.getBillMoney():data.getBillMoney();
		    	%>
		    	<tr>
		    		<td><%=data.getBillSubject()%></td>
		    		<td><%=data.getBillTime().substring(0,10)%></td>
		    		<td><%=data.getBillType()==1?"-"+data.getBillMoney():"+"+data.getBillMoney()%></td>
		    		<td><%=data.getBillDetial()%></td>
		    	</tr>
		    	<%
		    	}
		    
		    %>
		    
	  	</table>
	  	<br/>
	  	<div><%=start%>至<%=end%> 支出(收入):<span style="color:red"><%=total%></span></div>
		<%
	}else{
		BillShow show =null;
		if ("1".equals(key))
		show = JDBServer.getInstance().getUserBillList(Integer.parseInt(uid),start,end,type);
		%>
		<table>
		<tr>
		    <th>时间</th>
		    <th>金额</th>
	  	</tr>
	  	
	  	<%  
			int total = 0;
	  		List<BillShow.BillInfo> list = show==null?new ArrayList<BillShow.BillInfo>():show.getList(-1);
			for(BillShow.BillInfo info:list){
				total+=info.getMoney();
		 %>
	  	<tr>
	  		<td><%=info.getDate().substring(0,10)%></td>
	  		<td><%=info.getMoney()>0?"+"+info.getMoney():info.getMoney()%></td>
	  		<td style="display:none;" id="1">1</td>
	  		<td><a onclick='detial("<%=show.getDetail(info.getDate())%>")'>明细</a></td>
	  	</tr>
	  	<%} %>
	 </table>
		<%
	}
%>