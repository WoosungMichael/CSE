<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<meta charset="UTF-8">
<title>좌석 예약</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<br>
	<script language="JavaScript">
		alert("*공지사항*\n사회적 거리두기 2단계로 인해\n12월 18일까지 매일 17시-21시까지만 영업합니다.");
	</script>
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
	<script>
		$(document).ready(function() {
			$("img").hover(function() {
				var src = $(this).attr("src");
				if (src == "image/seat_ok.png") {
					$(this).attr("src", "image/seat_select.png");
				}
			}, function() {
				var src = $(this).attr("src");
				if (src == "image/seat_select.png") {
					$(this).attr("src", "image/seat_ok.png");
				}
			}

			);
		});
	</script>
	<center>
		<img src="image/reservation1.PNG" width="100" height="100"> <br>
		<br>
	</center>
	<div
		style="position: relative; margin-left: 140px; width: 960px; padding: 10px; border: solid 1px #9a9a9a">
		<font size="5"> 좌석예약 </font><br> <font size="2"> - 테이블은
			한자리만 예약 가능합니다.(두 테이블 이상을 예약하시려면 밥한술 번호로 전화주세요.)<br> - 이용이 끝나고
			계산하실 땐 꼭 이용 완료 처리해주세요.<br> - 원하는 테이블을 클릭해주세요.<br> - 예약 후,
			20분 이내에 도착하지 않으시면 예약이 취소됩니다.<br>
		</font>
	</div>

	<br>
	<br>
	<br>
	<br>
	<center>
		<font size="4"><b>밥한술 좌석현황</b></font>
	</center>
	<hr width="240">
	<div id="total">
		<%
			Connection conn = null;
		Statement stmt1 = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		String time = null;
		String my_name = null;
		int hour = 0;
		int min = 0;
		int count_out = 0;
		boolean timeout = false;
		String now = "now()";
		if (session.getAttribute("sessionId") == null) {
			my_name = "";
		} else {
			my_name = session.getAttribute("sessionId").toString();
		}
		int count = 1;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
			conn= DriverManager.getConnection(url,"root","qwerQWER@12");
			stmt = conn.createStatement();
			sql = "select * from seat_tbl";
			rs = stmt.executeQuery(sql);
		} catch (Exception e) {
			out.println("DB 연동오류입니다. : " + e.getMessage());
		}

		while (rs.next()) {

			int state = Integer.parseInt(rs.getString("state"));
			int seat_num = Integer.parseInt(rs.getString("seat_num"));
			String seat_src = "";

			if (state == 0) {
				seat_src = "image/seat_ok.png";
			} else if (state == 1) {
				if (rs.getString("name").equals(my_name)) {
			seat_src = "image/seat_mine.png";
				} else {
			seat_src = "image/seat_used.png";
				}

				time = rs.getString("ts");
				hour = Integer.parseInt(time.substring(11, 13));
				min = Integer.parseInt(time.substring(14, 16));
				Calendar cal = Calendar.getInstance();

				
			} else if (state == 2) {
				seat_src = "image/seat_mine.png";
			} else if (state == 3) {
				seat_src = "image/seat_no.png";
			}
		%>

		<div id="first">
			<a href=reservation_db.jsp?seat_num=<%=rs.getString("seat_num")%>><img
				src=<%=seat_src%> width="30" height="30" border="0"></a>
		</div>
		<%
			if (count == 2) {
		%>
		<br> <br>
		<%
			}
		if (count == 6) {
		%>
		<br>
		<%
			}
		if (count == 7) {
		%>
		<br> <br>
		<%
			}
		if (count == 10) {
		%>
		<br>입구 <br>
		<hr>
		<%
			}
		count++;
		}
		%>

		<img src="image/seat_ok.png" width="15" height="15"> <font
			size="1">:예약 가능 테이블</font><br> <img src="image/seat_used.png"
			width="15" height="15"> <font size="1">:이미 예약된 테이블</font><br>
		<img src="image/seat_mine.png" width="15" height="15"> <font
			size="1">:내가 예약한 테이블</font><br> <img src="image/seat_no.png"
			width="70" height="15">
		<iframe src="reserve_cancel.jsp"
			style="width: 80px; height: 33px; border: 0" scrolling="no"></iframe>
	</div>
	<br>
	

	<div id="underbar">
		<img id="logo_white" src="image/end.PNG" width="175" height="110"><font
			color="white" size="2.8"><br> <br>&nbsp;&nbsp;&nbsp;&nbsp;밥한술
			: 서울 중구 퇴계로42길 14<br> <br>&nbsp;&nbsp;&nbsp;&nbsp;전화번호 :
			02-2268-0263</font>
	</div>

</body>
</html>