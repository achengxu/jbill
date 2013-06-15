$(document).ready(
		function() {
			$("#user").focus();
			$(".u_name").bind(
					'keyup',
					function(event) {
						if (document.activeElement.id == 'user'
								|| document.activeElement.id == 'pwd') {
							if (event.keyCode == '13') {
								logins();
							}
						}
					});
		});

function logins() {
	$("#sub").focus();
	var _param = new Object();
	_param['user'] = $('#user').val();
	_param['pwd'] = $('#pwd').val();
	_param['scookie'] = $('#scookie option:selected').val();
	_param['refer'] = "";
	_param['code'] = $('#imgcode').val();
	if (_param['user'].length < 1) {
		alert('用户名不能为空');
		return false;
	}

	if (_param['pwd'].length < 1) {
		alert('密码不能为空');
		return false;
	}
	var _send = '{"user":"' + _param['user'] + '", "pwd":"' + _param['pwd']+ '"}';
	$.ajax( {
		cache : false,
		type : 'POST',
		url : 'action.jsp',
		data : "login=" + _send,
		beforeSend : function(XMLHttpRequest) {
			
		},
		success : function(data, textStatus) {
			if (data == 0) {
				alert('用户名或密码错误');
			} else if (data == 1) {
				location.href = 'note.jsp';
			} else if (data.indexOf(".jsp")) {
				location.href = data;
			} else if (data.indexOf("ttp")) {
				location.href = encodeURI(data);
			} else {
				location.href = "index.html";
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
}

if (window.top !== window.self) {
	setTimeout(function() {
		window.top.location = window.self.location;
		document.body.innerHTML = '';
	}, 0);
	window.self.onload = function() {
		alert(1);
		document.body.innerHTML = '';
	};
}