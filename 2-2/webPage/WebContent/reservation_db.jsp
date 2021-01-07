<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 예약</title>
</head>
<body>
	<%
		if (session.getAttribute("sessionId") == null) {
	%>
	<script>
		alert("로그인해주세요.");
	</script>

	<%
		out.println("<SCRIPT>parent.location.href='reservation.jsp';</SCRIPT>");
	} else {
	int seat_num = 0, state = 0;
	String temp;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String my_name = session.getAttribute("sessionId").toString();
	String now = "now()";
	boolean overlap = false;

	if (request.getParameter("seat_num") == null) {
		seat_num = 0;
	} else {
		seat_num = Integer.parseInt(request.getParameter("seat_num"));
	}
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

	while (rs.next()) {
		if (rs.getString("name").equals(my_name)) {
			overlap = true;
	%>
	<script>
		alert("이미 테이블을 예약하셨습니다.");
	</script>
	<%
		out.println("<SCRIPT>parent.location.href='reservation.jsp';</SCRIPT>");
	}
	}
	if (overlap == false) {
	String sql = "select * from seat_tbl where seat_num=" + seat_num;
	rs = stmt.executeQuery(sql);

	while (rs.next()) {
	state = Integer.parseInt(rs.getString("state"));
	}
	if (state == 1) {
	%>
	<script>
		alert("이미 예약된 테이블입니다.");
	</script>
	<%
		out.println("<SCRIPT>parent.location.href='reservation.jsp';</SCRIPT>");
	} else if (state == 3) {
	%>
	<script>
		alert("존재하지 않는 테이블입니다.");
	</script>
	<%
		out.println("<SCRIPT>parent.location.href='reservation.jsp';</SCRIPT>");
	} else {
	sql = "update seat_tbl set state=1" + "," + "name=" + "'" + my_name + "'," + "ts=" + now + "where seat_num=" + seat_num;
	stmt.executeUpdate(sql);
	}
	%>

	<script>  
	var now = new Date(); 
	var name ="<%=(String) session.getAttribute("sessionName")%>
		"
				+ "님 예약 완료되었습니다.";
		alert((now.getMonth() + 1) + "월 " + now.getDate() + "일 "
				+ now.getHours() + "시 " + now.getMinutes() + "분 " + name + "\n");
	</script>
	<%
		out.println("<SCRIPT>parent.location.href='reservation.jsp';</SCRIPT>");
	}
	}
	%>
</body>
</html>