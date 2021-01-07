<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

	<% 
int id;
String password="",sql,sql1;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
id=Integer.parseInt(request.getParameter("id"));

try{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
	conn= DriverManager.getConnection(url,"root","qwerQWER@12");
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	sql="select * from board_tbl where id="+id;
	rs=stmt.executeQuery(sql);
	}
	catch(Exception e) {
	out.println("DB 연동오류입니다. : " + e.getMessage() );
	}
	
	password=request.getParameter("password");
	while(rs.next())
	{
		if(!password.equals(rs.getString("password")))
		{
			%>
	<center>
		<h2>비밀번호를 잘못 입력하셨습니다.</h2>
	</center>

	<%
		}else{
			sql1="delete from board_tbl where id="+id;
			stmt.executeUpdate(sql1);%>

	<center>
		<h2>게시글이 삭제되었습니다.</h2>
		<input type="button" class="mybutton" value="목록"
			onclick="location.href='board.jsp'" />
	</center>
	<%break;
		}
	}
	
	
	%>

</body>
</html>