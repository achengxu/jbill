<%@ page contentType="application/vnd.ms-excel; charset=utf-8" %>
<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="bill.db.JDBServer,bill.bean.*,java.util.*"%>
<%
if(null==session.getAttribute("userId")){
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		String newLocn = "./index.html";
		response.setHeader("Location",newLocn);
		return ;
}
int userId = (Integer)session.getAttribute("userId");
    String filename = new String(("账单").getBytes("utf-8"),"ISO-8859-1"); 
    response.addHeader("Content-Disposition", "filename=" + filename +bill.util.JDate.getDateInt()+ ".xls");
%>
<html>
<head>
    <meta name="Generator" content="Microsoft Excel 11">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <style type="text/css">
    	table,tr,td,th{text-align:center};
    </style>
</head>
<body >
    <table border="1" align="center" cellpadding="0" cellspacing="1">
        <tr >
         <!--在这里用html写表格内容的代码，可以用jsp代码--> 
            <th>时间</th>
            <th>项目	</th>
            <th>金额</th>
            <th>备注</th>
        </tr>
        <%
        	BillShow show = JDBServer.getInstance().getUserBillList(userId);
        	List<BillShow.BillInfo> list =  show.getList(-1);
        	
        	for(BillShow.BillInfo info:list){
        		for(BillData billData:info.getSubjects()){
         %>
        <tr > 
            <td><%=billData.getBillTime().substring(0,10)%></td>
            <td><%=billData.getBillSubject()%></td>
            <td><%=billData.getBillType()==1?"+"+billData.getBillMoney():"-"+billData.getBillMoney()%></td>
            <td><%=billData.getBillDetial()%></td>
        </tr>
        <%		}
        	}
         %>
    </table>
</body>
</html>