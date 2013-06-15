<%@ page language="java" import="java.util.*,bill.bean.*,bill.db.*,org.json.JSONObject
" pageEncoding="utf-8"%>
<%
if(null==session.getAttribute("userId")){
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		String newLocn = "./index.jsp";
		response.setHeader("Location",newLocn);
		return ;
}
int userId = (Integer)session.getAttribute("userId");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int day = 7;
if(null!=request.getParameter("day")){
	day = Integer.parseInt(request.getParameter("day"));
}
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
<script language="javascript" type="text/javascript" src="dp/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="js/jquery.1.4.2-min.js"></script>
<script src="js/jquery-webox.js"></script>
<script type="text/javascript">
function getValue(){
	var key = $("#key ").val();
	if("2"==key){
		key = $.trim($("#s").val());
		if(key.length==0){
			info("项目不能为空");
			return;
		}
	}
	var type = $("#type ").val();
	var start = $("#start").val();
	var end = $("#end").val();
	if(""==start){
		info("起始时间不能为空");
		return;
	}
	if(""==end){
		info("结束时间不能为空");
		return;
	}
	var _send = '{"key":"' + key + '","type":' + type + ',"start":"' + start+'", "end":"' + end+ '"}';
	//search(_send);
	window.location.href="list.jsp?search="+_send;
}

function info(html){
	$("#msg").fadeIn(1000); 
	$("#msg").fadeOut(1000); 
	$("#msg").html(html);
}
function getKey(){
	var value = $("#key ").val();
	if("1"==value){
		$("#s").css("display", "none");
	}else if("2"==value){
		$("#s").css("display", "inline");
	}
}
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
	<br/><br/>
	条件:
	<select onchange="getKey()" id="key">
		<option value="1">日期</option>
		<option value="2">项目</option>
	</select>
	<input id="s" type="text" style="display:none;" />
	类型:
	<select id="type">
		<option value="0">全部</option>
		<option value="1">支出</option>
		<option value="2">收入</option>
	</select>
	<br/><br/>
	起始时间:<input id="start" class="Wdate" type="text" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'end\')||\'%y-%M-%d\'}'})"/>
	截至时间:<input id="end" class="Wdate" type="text" onclick="WdatePicker({minDate:'#F{$dp.$D(\'start\')}',maxDate:'%y-%M-%d'})"/>
	<br/><br/>
	<a href="#" onclick="getValue()">搜 索 !</a>
	<br/><br/>
	<span id="msg"></span>
	<%
	  	String search = request.getParameter("search");
	  	BillShow show =null;
	  	String key =null;
	  	int type = 0;
	  	String start = null;
	  	String end = null;
		if(null!=search){
			//JDBServer.getInstance().search(userId,search);
		try {
			JSONObject object = new JSONObject(search);
			 key = object.getString("key");
			 type = object.getInt("type");
			 start = object.getString("start");
			 end = object.getString("end");
			if ("1".equals(key)) {
				show = JDBServer.getInstance().getUserBillList(userId,start,end,type);
			} else {
				%>
				<jsp:include    page="item.jsp"    flush="true">   
           			  <jsp:param   name="s"  value="<%=search%>"/>
           			  <jsp:param   name="uid"  value="<%=userId%>"/>   
				</jsp:include>
			<%
			return;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		}else{
		}
	  	 
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
				System.out.println(info);
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
	<br/>
	<%if(null!=start&&null!=end){%>
	<div><%=start%>至<%=end%> 支出(收入):<span style="color:red"><%=total%></span></div>
	<%} %>
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