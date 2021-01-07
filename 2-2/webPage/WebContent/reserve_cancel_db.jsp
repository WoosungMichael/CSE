<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	String name=null;
	int seat_num=Integer.parseInt(request.getParameter("seat_num"));
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
		conn= DriverManager.getConnection(url,"root","qwerQWER@12");
		stmt = conn.createStatement();
		name=session.getAttribute("sessionId").toString();
		sql= "update seat_tbl set state=0,name="+"'"+"'"+"where seat_num="+seat_num;
		stmt.executeUpdate(sql);
	} catch (Exception e) {
		out.println("DB 연동오류입니다. : " + e.getMessage());
	}
	%>
	<script>
	var now = new Date(); 
alert((now.getMonth() + 1) + "월 " +now.getDate() + "일 " + now.getHours() + "시 " + now.getMinutes() + "분 "+" 이용 완료 처리되었습니다.");
	</script>

	<% out.println("<SCRIPT>parent.location.href='reservation.jsp';</SCRIPT>");%>