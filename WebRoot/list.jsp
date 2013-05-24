<%@ page language="java" import="java.util.*,bill.bean.*,bill.db.*" pageEncoding="utf-8"%>
<%
if(null==session.getAttribute("userId")){
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		String newLocn = "./index.html";
		response.setHeader("Location",newLocn);
		return ;
}
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>账单</title>
<style type="text/css">
	*{font-size:12px;}
	ul{list-style:none;}
	li{margin-bottom:10px;}
	a{text-decoration:none;cursor:pointer;}
	a:hover{color:red;cursor:pointer;}
	table{text-align:center;}
</style>
<link href="images/jquery-webox.css" rel="stylesheet" type="text/css" />
<link href="css/common.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script src="js/jquery-webox.js"></script>
<script type="text/javascript">
$(document).ready(function(){
})
function detial(data){
		$.webox({
				height:180,
				width:240,
				bgvisibel:true,
				title:'明细',
				//html:$("#"+billId).html()
				html: data
				//html:'hello world'
			});
}
	function deleteInfo(userId,billId){
		$.ajax({

		cache : false,

		type : 'POST',

		url : 'action.jsp',

		data : "userId=" + userId+"&delKey="+billId,

		beforeSend : function(XMLHttpRequest) {
		},

		success : function(data, textStatus) {
			if(data==1){
				$("#msg").fadeIn(1000); 
				$("#msg").fadeOut(1000); 
				$("#msg").html("删除成功");
				location.href = "./list.jsp";
			}else{
				$("#msg").fadeIn(1000); 
				$("#msg").fadeOut(1000); 
				$("#msg").html("删除失败");
			}
		},

		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}

	});
	}
</script>
</head>
<body>
	<div id="listBill">
	<a onclick="javascript:window.location.href='note.jsp';">新建项目</a> | 
	<a onclick="javascript:window.location.href='total/index.jsp';">统计</a> |
	<a onclick="javascript:window.location.href='exp.jsp';">导出数据</a>
	<span id="msg"></span>
	<table>
		<tr>
		    <th>时间</th>
		    <th>金额</th>
	  	</tr>
	  	<%
	  	int userId = (Integer)session.getAttribute("userId");
	  	BillShow show = JDBServer.getInstance().getUserBillList(userId);
	  	%>
	  	<%  
	  		List<BillShow.BillInfo> list = show.getList(7);
			for(BillShow.BillInfo info:list){
		 %>
	  	<tr>
	  		<td><%=info.getDate().substring(0,10)%></td>
	  		<td><%=info.getMoney()>0?"+"+info.getMoney():info.getMoney()%></td>
	  		<td style="display:none;" id="1">1</td>
	  		<td><a onclick='detial("<%=show.getDetail(info.getDate())%>")'>明细</a></td>
	  	</tr>
	  	<%} %>
	 </table>
	</div>
	
	
<div id="box" style="display:none;">
	<div class="mainlist">
		<ul>
			<li></li>
		</ul>
	</div>
</div>
</body>
</html>