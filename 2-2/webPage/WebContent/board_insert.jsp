<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
	<br>
	<div id="top">
		<a href="main.html"> <img src="image/logo1.png" width="150" height="150" alt="밥한술" title="밥한술"></a>
		<iframe src="login_menu.jsp" style="width: 250px; height: 35px; border: 0" scrolling="no"></iframe>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="button" class="button_upper" onclick="location.href='find_id.jsp'">ID 찾기</button>
		<button type="button" class="button_upper" onclick="location.href='join.jsp'">회원가입</button>
		<button type="button" class="button_upper" onclick="location.href='deleteID.jsp'">탈퇴</button>
		<button type="button" class="button_upper" onclick="location.href='main.html'">HOME</button>
	</div>

	<div class="menubar">
		<center>
			<ul>
				<li><a href="main.html">밥한술 소개</a></li>
				<li><a href="reservation.jsp">밥한술 예약하기</a>
					<ul>
						<li><a href="reservation.jsp">좌석예약</a></li>
						<li><a href="reserve_check.jsp">예약 현황/취소</a></li>
					</ul></li>
				<li><a href="board.jsp">커뮤니티</a>
					<ul>
						<li><a href="board.jsp">자유 게시판</a></li>
						<li><a href="question.jsp">자주묻는질문</a></li>
					</ul></li>
				<li><a href="map.html">오시는 길 안내</a></li>
			</ul>
			<br>
		</center>
	</div>

	<%
		if (session.getAttribute("sessionId") == null) {
	%>
	<script>
		alert("로그인해주세요.");
	</script>
	<%
		out.println("<SCRIPT>parent.location.href='board.jsp';</SCRIPT>");
	} else {
	%>
	<div style="height: 700px">
		<center>
			<img src="image/L&F.PNG" width="100" height="100"> <br> <font
				size="5">자유 게시판 </font> <font size="1"></font> <br>
		</center>
		
		<br><br>

		<table align="center" width="1000px" cellpadding="0" cellspacing="0"
			border="0">
			<tr>
				<td>
					<form name="addForm" method="post" target="action"
						action="board_insertdb.jsp" onSubmit='return chkForm(this)'>


						<tr align="center" bgcolor="#cccccc">
							<td>게시글 작성</td>
						</tr>
		</table>
		<center>
		<table align="center" width="1000px">

			<tr>
				<td>제목&nbsp;</td>
				<td><input name="title" style="width: 300px" maxlength="100"></td>
			</tr>
			<tr height="1" bgcolor="#cccccc">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td>작성자&nbsp;</td>
				<td><%=session.getAttribute("sessionName")%></td>
			</tr>
			<tr height="1" bgcolor="#cccccc">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td>내용&nbsp;</td>
				<td><textarea name="content" cols="130" rows="13"></textarea></td>
			</tr>
			<tr height="1" bgcolor="#cccccc">
				<td colspan="2"></td>
			</tr>
			<tr>
				<td>비밀번호&nbsp;</td>
				<td><input type="password" name="password" size="10%"
					maxlength="50"></td>
			</tr>
			<tr height="1" bgcolor="#cccccc">
				<td colspan="2"></td>
			</tr>
			<tr height="1" bgcolor="#cccccc">
				<td colspan="2"></td>
			</tr>
			<tr height="3" bgcolor="#ffffff">
				<td colspan="2"></td>
			</tr>
			<tr align="center">
				<br>
				<td colspan="2">
				<input type="image" src="image/write.png" width="50" height="25" border="0"> 
				<a href="board.jsp"><img src="image/cancel.png" width="50" height="25" border="0"></a></td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</center>
		<%
			String flag = request.getParameter("flag");
		if ("r".equals(flag)) {
		%>
		<input type=hidden name=ref value="<%=request.getParameter("ref")%>">
		<input type=hidden name=reply value="y">
		<%
			} else {
		%>
		<input type=hidden name=reply value="n">
		<%
			}
		}
		%>

		<br>
		<br>
	</div>
	<div id="underbar">
		<img id="logo_white" src="image/end.PNG" width="175" height="110"><font
			color="white" size="2.5"><br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;충무로 밥한술 : 서울 중구 퇴계로42길 14<br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;전화번호 : 02-2268-0263</font>
	</div>
</body>
</html>