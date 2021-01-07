<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);

body {
	font-family: NanumGothic;
}

#login_button {
	background-color: white;
	color: darkorange;
	border: 2px solid darkorange;
}

#logout_button {
	background-color: white;
	color: darkorange;
	border: 2px solid darkorange;
}
</style>
<script>
	function focusIt() {
		document.inform.id.focus();
	}

	function check() {
		inputForm = eval("document.inform");
		if (!inputForm.id.value) {
			alert("아이디를 입력하시오");
			inputForm.id.focus();
			return false;
		}
		if (!inputForm.passwd.value) {
			alert("비밀번호를 입력하시오");
			inputForm.passwd.focus();
			return false;
		}
	}

	function b_function() {
		var button = document.getElementById('login_button');
		var div = document.getElementById('login');
		if (div.style.display !== 'none') {
			button.type = "submit";
			parent.document.location.reload();
		} else {
			div.style.display = 'inline';
		}
	};
</script>
</head>
<body>
	<%
		if (session.getAttribute("sessionId") == null) {
	%>
	<form name="inform" method="post" action="loginPro.jsp" onSubmit="return check();">
		<div style="display: none" id="login">
			<input type="text" name="id" placeholder="id" size="7" />
			<input type="password" name="password" placeholder="password" size="7" />
		</div>
		<button type="button" id="login_button" onclick="b_function()">로그인</button>
	</form>
	<%
		} else {
	%>
	<script>
		(function() {
			var button = document.getElementById('login_button');
			var div = document.getElementById('login');
			div.style.display = "none";
			button.style.display = "none";
		})();
	</script>
	<form method="post" action="logout.jsp">
		<font size="2"><b> 
		<%=session.getAttribute("sessionName")%></b>님 환영합니다!&nbsp;</font> 
		<input type="submit" id="logout_button" onclick="parent.document.location.reload()"
			style="width: 60px; height: 23px; font-size: 11px;" value="로그아웃" />

	</form>
	<%
	} 
	%>

</body>
</html>