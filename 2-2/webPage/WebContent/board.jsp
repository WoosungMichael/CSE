<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*"%>
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
				size="5">자유 게시판 </font> <font size="1"></font> <br>
		</center>
		<br>
		
		<div style="overflow:auto">
		<table align="center" width="1000px" cellpadding="0" cellspacing="0"
			border="0">
			<tr align="center" bgcolor="#cccccc">
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>등록일자</td>
				<td>&nbsp;</td>
			</tr>


			<%
				int id = 0, ref = 0;
			int rownum = 0;
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			String sql = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
				conn= DriverManager.getConnection(url,"root","qwerQWER@12");
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				sql = "select * from board_tbl order by ref desc, id asc";
				rs = stmt.executeQuery(sql);
			} catch (Exception e) {
				out.println("DB 연동오류입니다. : " + e.getMessage());
			}

			rs.last();
			rownum = rs.getRow();
			rs.beforeFirst();

			while (rs.next()) {
				id = Integer.parseInt(rs.getString("id"));
				ref = Integer.parseInt(rs.getString("ref"));
			%>

			<tr height="25" align="center">
				<td><%=rownum%></td>
				<td>
					<%
						if (id != ref)
						out.println("⤷");
					%><a href=board_read.jsp?id=<%=rs.getString("id")%>><%=rs.getString("title")%></a>
				</td>
				<td><%=rs.getString("name")%></td>
				<td><%=rs.getString("birth")%></td>
				<td>&nbsp;</td>
			</tr>
			<tr height="1" bgcolor="#D2D2D2">
				<td colspan="6"></td>
			</tr>
			<%
				rownum--;
			}
			%>
		</table>
		</div>

		<br>
		<center>
			<input type="button" class="my_button" value="글쓰기"
				onclick="location.href='board_insert.jsp'">
		</center>
		<%
			stmt.close();
		conn.close();
		%>
	</div>
	<div id="underbar">
		<img id="logo_white" src="image/end.PNG" width="175" height="110"><font
			color="white" size="2.5"><br> <br>&nbsp;&nbsp;&nbsp;&nbsp;충무로
			밥한술 : 서울 중구 퇴계로42길 14<br> <br>&nbsp;&nbsp;&nbsp;&nbsp;전화번호
			: 02-2268-0263</font>
	</div>

</body>
</html>