<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<meta charset="UTF-8">
<title>예약 확인</title>
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
		out.println("<SCRIPT>parent.location.href='main.html';</SCRIPT>");
	} else {
	int seat_num = 0, state = 0;
	String temp;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String my_name = session.getAttribute("sessionId").toString();
	String now = "now()";
	boolean overlap = false;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
		conn= DriverManager.getConnection(url,"root","qwerQWER@12");
		stmt = conn.createStatement();
		String sql = "select * from seat_tbl";
		rs = stmt.executeQuery(sql);
	} catch (Exception e) {
		out.println("DB 연동오류입니다. : " + e.getMessage());
	}

	String res_date = "예약 내역이 없습니다.";
	while (rs.next()) {
		if (rs.getString("name").equals(my_name))
			res_date = rs.getString("ts");
	}
	%>

	<div id="middle1">
		<center>
			<br>
			<br>


			<div>
				<img src="image/reservation1.PNG" width="100" height="100"> <br>
				<font size="5">예약 현황 / 취소</font> <br>
				<br> <font size="3"> 예약 일시 : <%=res_date%><br> 예약자
					명 : <%=(String) session.getAttribute("sessionName")%><br> 연락처 :
					<%=(String) session.getAttribute("sessionNum")%><br>
				<br> <iframe src="reserve_cancel.jsp"
						style="width: 80px; height: 33px; border: 0" scrolling="no"></iframe>
					<br>

				</font>
			</div>
			<br>
			<br>
		</center>
		<br>
		<br>
	</div>
	<%
		}
	%>
	<div id="underbar">
		<img id="logo_white" src="image/end.PNG" width="175" height="110"><font
			color="white" size="2.5"><br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;충무로 밥한술 : 서울 중구 퇴계로42길 14<br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;전화번호 : 02-2268-0263</font>
	</div>
</body>
</html>