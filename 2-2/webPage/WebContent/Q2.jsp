<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<meta charset="UTF-8">
<title>자주 묻는 질문</title>
<link rel="stylesheet" type="text/css" href="style.css">
<style>
table {
	width: 100%;
	border-top: 1px solid #444444;
	border-collapse: collapse;
}

th, td {
	border-bottom: 1px solid #444444;
	padding: 10px;
}
</style>
</head>
<body>
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
	<br>
	
	<div id="body1">

		<div>
			<center>
				<img src="image/Q&A.PNG" width="200" height="120"><br>
				<br> <font size="5">자주 묻는 질문</font>
			</center>

			<br>
			<br>
			<br>

			<table align="center" width="1000px" cellpadding="0" cellspacing="0"
				border="0">
				<tr height="50" align="center">
					<td>Q. 예약창을 보니 테이블을 하나밖에 선택할 수 없던데 혹시 단체예약은 불가능한가요 ?</td>
				</tr>
				<tr align="center">
					<td>
						<h2>가능합니다.</h2>
						<br>
						<h4>
							현재 사회적 거리두기가 2단계인 관계로, 현재는 하나의 테이블만 선택 가능하도록 하였습니다.<br>
							<br> 거리두기 지침을 지키는 선에서의 단체 예약을 원하시는 경우 아래 번호로 전화를 주시면 예약을
							도와드리겠습니다 .<br>
							<br> 전화번호 : 02-2268-0263
						</h4>
					</td>
				</tr>
			</table>

		</div>
	</div>

	<br>
	<br>
	<br>
	<div id="underbar">
		<img id="logo_white" src="image/end.PNG" width="175" height="110"><font
			color="white" size="2.5"><br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;충무로 밥한술 : 서울 중구 퇴계로42길 14<br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;전화번호 : 02-2268-0263</font>
	</div>

</body>
</html>