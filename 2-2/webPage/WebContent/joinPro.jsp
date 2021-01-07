<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="test.bean.joinDAO"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
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
 request.setCharacterEncoding("UTF-8");
 String name=request.getParameter("name");
 String phone_Num=request.getParameter("phone_Num");
 String id=request.getParameter("id");
 String password=request.getParameter("password");
 String passwordconfirm=request.getParameter("passwordconfirm");
 String year=request.getParameter("year");
 String month=request.getParameter("month");
 String day=request.getParameter("day");

%>
	<jsp:useBean id="joindto" class="test.bean.joinDTO" />
	<jsp:setProperty property="*" name="joindto" />

	<%
	 joinDAO joindao=joinDAO.getInstance();
	 joindao.insert(joindto);
%>
	<br>
	<br>
	<br>
	<center>
		<h2><%=joindto.getName()%>님의 가입을 환영합니다
		</h2>
	</center>
	<br>
	<table border="0" width="400" height="150" align=center>
		<tr>
			<td>이름</td>
			<td><%=joindto.getName()%></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%=joindto.getphone_Num() %></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><%=joindto.getId() %></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><%=joindto.getPassword() %></td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td><%=joindto.getYear() %>.<%=joindto.getMonth() %>.<%=joindto.getDay() %></td>
		</tr>
	</table>
	<br>
	<br>

	<center>
		<input type="button" value="홈으로" class="my_button"
			onclick="javascript:window.location='main.html'" />
	</center>
	<br>
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