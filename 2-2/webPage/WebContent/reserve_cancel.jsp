<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<%
		if(session.getAttribute("sessionId")!=null){
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		String check_id;
		String seat_num;
		try{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
		conn= DriverManager.getConnection(url,"root","qwerQWER@12");
		stmt = conn.createStatement();
		sql= "select * from seat_tbl";
		rs= stmt.executeQuery(sql);
		}
		catch(Exception e) {
		out.println("DB 연동오류입니다. : " + e.getMessage() );
		}
		while (rs.next()) {
		check_id=session.getAttribute("sessionId").toString();
		if(rs.getString("name").equals(check_id)) {
		seat_num=rs.getString("seat_num");%>
	<input type="button" id="exit"
		onclick="location.href='reserve_cancel_db.jsp?seat_num=<%=rs.getString("seat_num")%>'"
		value="예약취소" />

	<%}}}%>

</body>
</html>