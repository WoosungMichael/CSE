<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

	<div style="height: 700px">
		<%
			int id;
		String name, title, content, password;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String my_pw = "";
		if (request.getParameter("id") == null) {
			id = 0;
		} else {
			id = Integer.parseInt(request.getParameter("id"));
		}

		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
			conn= DriverManager.getConnection(url,"root","qwerQWER@12");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String sql = "select * from board_tbl where id=" + id;
			rs = stmt.executeQuery(sql);
		} catch (Exception e) {
			out.println("DB 연동오류입니다. : " + e.getMessage());
		}
		password = request.getParameter("password");

		while (rs.next()) {
			my_pw = rs.getString("password");
			if (my_pw.equals(password)) {
		%>
		<center>
			<img src="image/L&F.PNG" width="100" height="100"> <br> <font
				size="5">자유 게시판</font> <font size="1"></font> <br>
		</center>
		<br>

		<table align="center" width="1000px">
			<tr align="center" bgcolor="#cccccc">
				<td>게시글 수정</td>
			</tr>
		</table>
		<form action="board_modify_db.jsp" method="post">
			<table align="center" width="1000px">
				<tr>
					<td>&nbsp;</td>
					<td>제목&nbsp;</td>
					<td><input name="title" style="width: 300px" maxlength="100"></td>
					<td>&nbsp;</td>
				</tr>
				<tr height="1" bgcolor="#cccccc">
					<td colspan="4"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>작성자&nbsp;</td>
					<td><%=session.getAttribute("sessionName")%></td>
					<td>&nbsp;</td>
				</tr>
				<tr height="1" bgcolor="#cccccc">
					<td colspan="4"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>내용&nbsp;</td>
					<td><textarea name="content" cols="130" rows="13"></textarea></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>비밀번호&nbsp;</td>
					<td><input type="password" name="password" size="10%"
						maxlength="50"></td>
					<td>&nbsp;</td>
				</tr>
				<tr height="1" bgcolor="#cccccc">
					<td colspan="4"></td>
				</tr>
				<tr height="3" bgcolor="#ffffff">
					<td colspan="4"></td>
				</tr>
				<tr align="center">
					<td>&nbsp;</td>
					<td colspan="2"><input type="image" src="image/write.png"
						width="50" height="25" border="0"> <a
						href="board.jsp"><img src="image/cancel.png" width="50"
							height="25" border="0"></a></td>
					<td>&nbsp;</td>
				</tr>

			</table>
			<p>
				<input type="hidden" name="id"
					value="<%=request.getParameter("id")%>">
		</form>

		<%
			} else {
		%>
		<center>
			<h2>비밀번호가 잘못되었습니다.</h2>
		</center>
		<%
			}
		}
		%>
	</div>

	<div id="underbar">
		<img id="logo_white" src="image/end.PNG" width="175" height="110"><font
			color="white" size="2.5"><br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;충무로 밥한술 : 서울 중구 퇴계로42길 14<br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;전화번호 : 02-2268-0263</font>
	</div>
</body>
</html>