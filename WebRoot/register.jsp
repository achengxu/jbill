<%@ page language="java" import="java.util.*,bill.bean.*,bill.db.*,org.json.JSONObject
" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注册</title>
<script language="javascript" type="text/javascript" src="js/jquery.1.4.2-min.js"></script>
<style type="text/css">
	*{font-size:12px;}
	ul{list-style:none;}
	a{text-decoration:none;}
</style>
<script type="text/javascript">
		
		
	function checkLength(){
		var name =  $.trim($("#name").val());
		if(name.length<4){
			info("nameInfo","用户名长度不能小于4为",true);
			return false;
		}
		var pwd = $.trim($("#password").val());
		if(pwd.length<4){
			info("passwordInfo","密码长度不能小于4为",true);
			return false;
		}
		return true;
	}	
	function check(){
		var name =  $.trim($("#name").val());
		if(name.length<4){
			info("nameInfo","用户名长度不能小于4为",true);
			return false;
		}
		var pwd = $.trim($("#password").val());
		if(pwd.length<4){
			info("passwordInfo","密码长度不能小于4为",true);
			return false;
		}
		send("check",$.trim($("#name").val()),"nameInfo","恭喜","用户名已经存在",false);
		
		//info(id+"Info","ok...",true);
	}
	
	function reg(){
		
		if(!checkLength()){
			return ;
		}
		var name =  $.trim($("#name").val());
		var pwd = $.trim($("#password").val());
		var _param_json = '{"name":"' + name + '","password":"' + pwd + '"}';
		send("reg",_param_json,"msg","注册成功","注册失败",true);
	}
	
	function info(id,value,flag){
		if(flag){
			$("#"+id).fadeIn(1000);
			$("#"+id).fadeOut(1000);
		}
		$("#"+id).html(value);
	}
	
	function send(action,_param_json,id,successMsg,failedMsg,flag){
		$.ajax({

		cache : false,

		type : 'POST',

		url : 'action.jsp',

		data : action +"="+ _param_json,

		beforeSend : function(XMLHttpRequest) {
		},

		success : function(data, textStatus) {
			if(data==1){
				info(id,successMsg,flag);
			}else if(data.indexOf(".jsp")){
				location.href = data;
			}else{
				info(id,failedMsg,flag);
			}
		},

		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}

	});
	}
	
</script>
</head>
<body>
	<div id="reg">
		<ul>
			<li><span id="msg"></span></li>
			<li>帐号:<input type="text" name="name" id="name" onblur="check()"/><span id="nameInfo"></span></li>
			<li>密码:<input type="password" name="password" id="password" onblur="check()"/><span id="passwordInfo"></span></li>
			<li><a href="javascript:void(0)" onclick="reg()">注册</a></li>
		</ul>
	</div>
</body>
</html>