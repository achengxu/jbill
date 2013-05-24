function listBill(){
	location.href = "./list.jsp";
}
function newBill(){
		var billSubject = $$("billSubject")[0].value;
		var billTime = $$("billTime")[0].value;
		var billMoney = $$("billMoney")[0].value;
		var billDetial = $$("billDetial")[0].value;
		billDetial = billDetial.replace(/\n/g, "<br/>\\n");
		var billType  = $('input[name="billType"]:checked').val();
		if(billSubject==""){
			$("#msg").fadeIn(1000); 
			$("#msg").fadeOut(1000); 
			$("#msg").html("请输入账单项目");
			return ;
		}
		if(billTime==""){
			$("#msg").fadeIn(1000); 
			$("#msg").fadeOut(1000); 
			$("#msg").html("请输入账单时间");
			return ;
		}
		if(billMoney==""){
			$("#msg").fadeIn(1000); 
			$("#msg").fadeOut(1000); 
			$("#msg").html("请输入账单金额");
			return ;
		}
		var _param_json = '{"billTime":"' + billTime + '", "billMoney":' +billMoney+  ', "billSubject":"' +billSubject+'", "billDetial":"' +billDetial +'", "billType":' + billType + '}';
		send(_param_json);
	}

	function send(_param_json){
		$.ajax({

		cache : false,

		type : 'POST',

		url : 'action.jsp',

		data : "action=" + _param_json,

		beforeSend : function(XMLHttpRequest) {
		},

		success : function(data, textStatus) {
			
			if(data==1){
				$("#msg").fadeIn(1000); 
				$("#msg").fadeOut(1000); 
				$("#msg").html("添加成功");
			}else{
				$("#msg").fadeIn(1000); 
				$("#msg").fadeOut(1000)
				$("#msg").html("添加失败");
			}
		},

		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}

	});
	}
	function $$(tagName){
		return document.getElementsByName(tagName);
	}