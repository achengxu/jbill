<%@ page language="java" import="java.util.*,bill.bean.*,bill.db.*,org.json.JSONObject
" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>账单系统</title>
<link href="css/oo.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/jquery.1.4.2-min.js"></script>
<script type="text/javascript" src="js/logoPage.js"></script>
</head>
<body>
	<div id="warp">

		<div id="logo">
		</div>
		<div id="login">

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="30%">用户：</td>
					<td width="70%"><label><input class="u_name"
							type="text" name="user" id="user" style="width: 100px;" /></label></td>
				</tr>

				<tr>
					<td>密码：</td>
					<td><input class="u_name" type="password" name="pwd" id="pwd"
						style="width: 100px;" /></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td height="40" valign="middle"><a href="javascript:void(0)"
						onclick="logins();" id="sub"><img src="images/login_button.jpg" /></a></td>
				</tr>
			</table>
		</div>
	</div>

</body>
</html>