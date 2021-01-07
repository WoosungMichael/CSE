<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
	<% 
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String id=request.getParameter("id");
String phone_Num=request.getParameter("phone_Num");
String pw=request.getParameter("pw");
boolean check_id=false;
boolean check_pw=false;
boolean check_num=false;
String id_id=null;
String pw_id=null;
String num_id=null;
String sql=null;
String real_id=null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
	conn= DriverManager.getConnection(url,"root","qwerQWER@12");
	stmt = conn.createStatement();
	 sql= "select * from join_tbl";
	rs= stmt.executeQuery(sql);
	}

	catch(Exception e) {
	out.println("DB 연동오류입니다. : " + e.getMessage() );
	}

	while(rs.next()) {
		if(rs.getString("id").equals(id))
		{
			check_id=true;
			id_id=rs.getString("id");
			real_id=rs.getString("id");
	}
		if(rs.getString("phone_Num").equals(phone_Num))
		{
			check_num=true;
			num_id=rs.getString("id");
	}
		if(rs.getString("password").equals(pw))
		{
			check_pw=true;
			pw_id=rs.getString("id");
	}
	}
	if(check_id==true&&check_num==true&&check_pw==true)
	{
		if(id_id.equals(num_id))
		{if(id_id.equals(pw_id)){
			sql ="delete from join_tbl where id="+"'"+real_id+"'";
			stmt.executeUpdate(sql);
		}
		}%>
	<script>
			var name ="탈퇴되었습니다.";
			alert(name);
			</script>

	<%out.println("<SCRIPT>parent.location.href='main.html';</SCRIPT>");}else{%>
	<script>
			var caution ="아이디,비밀번호 또는 전화번호를 잘못입력하셨습니다.";
			alert(caution);
			</script>

	<%out.println("<SCRIPT>parent.location.href='main.html';</SCRIPT>");}%>


</body>
</html>