<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
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

	<br>
	<div style="height: 650px">
		<center>
			<img src="image/L&F.PNG" width="100" height="100"> <br> <font
				size="5">자유 게시판</font> <font size="1"></font> <br>
		</center>
		<br>
		<br>
		<br>
		<%
			int id = 0, ref = 0;
		String temp;
		String name = "", date = "", title = "", content = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		id = Integer.parseInt(request.getParameter("id"));

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

		while (rs.next()) {
			name = rs.getString("name");
			title = rs.getString("title");
			content = rs.getString("content");
			date = rs.getString("birth");
			ref = Integer.parseInt(rs.getString("ref"));
		}
		%>
		<center>
		<table width="1000px" cellpadding="0" cellspacing="0" border="0">

			<tr>
				<td>제목 : <%=title%></td>
			</tr>
			<tr height="1" bgcolor="#adadad">
				<td colspan="6"></td>
			</tr>
			<tr height="5" bgcolor="white">
				<td colspan="6"></td>
			</tr>
			<tr>
				<td>작성자 : <%=name%></td>
			</tr>
			<tr height="1" bgcolor="#adadad">
				<td colspan="6"></td>
			</tr>
		</table>
		</center>
		<br>
		<center>
		<div style="border: 1px solid #adadad; width: 980px; position: relative; height: 280px; padding: 10px;">
			<%=content.replace("\r\n", "<br>")%>
		</div>
		<p>
		<div style="position: relative">
			<input type="button" class="my_button" value="답글"
				onclick="location.href='board_insert.jsp?ref=<%=ref%>&flag=r'" />
			<input type="button" class="my_button" value="목록"
				onclick="location.href='board.jsp'" /> <input type="button"
				class="my_button" value="수정"
				onclick="location.href='board_modify_pw.jsp?id=<%=id%>'" /> <input
				type="button" class="my_button" value="삭제"
				onclick="location.href='board_delete_pw.jsp?id=<%=id%>'" />
		</div>
		</center>
	</div>
	<div id="underbar">
		<img id="logo_white" src="image/end.PNG" width="175" height="110"><font
			color="white" size="2.5"><br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;충무로 밥한술 : 서울 중구 퇴계로42길 14<br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;전화번호 : 02-2268-0263</font>
	</div>
</body>
</html>