<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

	<div style="height: 488px">
		<br>
		<center>
			<font size="5">회원가입</font><br>
		</center>
		<hr width="1000">
		<br>
		<br>
		<form action="joinPro.jsp" method="post" name="userinput"
			onSubmit="return checkIt()">
			<table border="0" width="600" height="150" align=center>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" /></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="phone_Num" /></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" /> <input type="button"
						class="my_button" value="중복확인" OnClick="openConfirmid(this.form)" /></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="password" /></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="passwordconfirm" /></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><select name="year">
							<option value="1990" selected>1990</option>
							<option value="1991" selected>1991</option>
							<option value="1992" selected>1992</option>
							<option value="1993" selected>1993</option>
							<option value="1994" selected>1994</option>
							<option value="1995" selected>1995</option>
							<option value="1996" selected>1996</option>
							<option value="1997" selected>1997</option>
							<option value="1998" selected>1998</option>
							<option value="1999" selected>1999</option>
							<option value="2000" selected>2000</option>
							<option value="2001" selected>2001</option>
					</select> 년 <select name="month">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
					</select> 월 <select name="day">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
					</select> 일</td>
				</tr>
			</table>
			<br>
			<center>
				<input type="submit" class="my_button" name="submit" value="완료" />
				<input type="reset" class="my_button" name="reset" value="다시입력" />
			</center>
		</form>

		<script language="JavaScript">
 function checkIt(){
	 if(!document.userinput.id.value){
		 alert("ID를 입력하세요");
		 return false;
	 }
	 
	 if(!document.userinput.password.value){
		 alert("비밀번호를 입력하세요");
		 return false;
	 }
	 if(document.userinput.password.value!=document.userinput.passwordconfirm.value){
		 alert("비밀번호를 동일하게 입력하세요");
		 return false;
	 }
	 if(!document.userinput.name.value){
		 alert("사용자 이름을 입력하세요");
		 return false;
	 }
 }
 
 //아이디 중복 확인
 function openConfirmid(inputid){
	 if(inputid.id.value==""){
		 alert("중복확인에러 : 아이디를 입력하세요");
		 return;
	 }
	 url="confirmId.jsp?id="+inputid.id.value;
	 
	 open(url,"confirm","toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=310, height=180");
 }
</script>
	</div>
	<div id="underbar">
		<img id="logo_white" src="image/end.PNG" width="175" height="110"><font
			color="white" size="2.5"><br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;충무로 밥한술 : 서울 중구 퇴계로42길 14<br>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;전화번호 : 02-2268-0263</font>
	</div>
</body>
</html>