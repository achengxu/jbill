<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	if(null==session.getAttribute("userId")){
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		String newLocn = "./index.html";
		response.setHeader("Location",newLocn);
		return ;
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
	#newBill,#listBill{float:left;}
	#listBill{margin-left:40px;}
</style>
<script language="javascript" type="text/javascript" src="dp/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script language="javascript" type="text/javascript" src="js/billadd.js"></script>
<script type="text/javascript">
$(function(){
//文本框只能输入数字，并屏蔽输入法和粘贴
 $.fn.numeral = function() {   
            $(this).css("ime-mode", "disabled");   
            this.bind("keypress",function(e) {   
            var code = (e.keyCode ? e.keyCode : e.which);  //兼容火狐 IE    
                if(!$.browser.msie&&(e.keyCode==0x8))  //火狐下不能使用退格键   
                     return ;   
				var getValue = $(this).val();
				if(getValue.legth==0&&code==46){
					event.preventDefault();
					return false;
				}
                return code >= 48 && code<= 57||(code==46&&getValue.indexOf('.') == -1);   
            });   
            this.bind("blur", function() {   
                if (this.value.lastIndexOf(".") == (this.value.length - 1)) {   
                    this.value = this.value.substr(0, this.value.length - 1);   
                } else if (isNaN(this.value)) {   
                    this.value = "";   
                }   
            });   
            this.bind("paste", function() {   
                var s = clipboardData.getData('text');   
                if (!/\D/.test(s));   
                value = s.replace(/^0*/, '');   
                return false;   
            });   
            this.bind("dragenter", function() {   
                return false;   
            });   
            this.bind("keyup", function() {   
            if (/(^0+)/.test(this.value)) {   
                this.value = this.value.replace(/^0*/, '');   
                }   
            });   
        };  
        //调用文本框的id
  $("#billMoney").numeral();
});
</script>
</head>
<body>
	<div id="newBill">
	<ul>
		<li><span id="msg"></span></li>
		<li>项目:<input type="text" name="billSubject" id="billSubject" /></li>
		<li>时间:<input type="text" name="billTime" class="Wdate" onclick="WdatePicker()"/></li>
		<li>支出:<input type="radio" name="billType" value="1" checked="checked"/>收入:<input type="radio" name="billType" value="2"/></li>	
		<li>金额:<input type="text" name="billMoney" id="billMoney" /></li>
		<li>明细:<textarea rows="4" cols="20" name="billDetial"></textarea></li>
		<li><input type="button" value="提交" onclick="newBill()" /><input type="button" value="历史" onclick="listBill()" /></li>
	</ul>
	</div>
</body>
</html>