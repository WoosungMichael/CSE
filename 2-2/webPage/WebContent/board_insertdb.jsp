<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
</head>
<body>
	<% int temp=0;
int id=0,ref=0;
int new_id=0;
String name,title,content,reply,password;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String fullpath = null;
String sql_update;
String now="now()";
try{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
	conn= DriverManager.getConnection(url,"root","qwerQWER@12");
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	String sql= "select max(id) as max_id from board_tbl";
	rs= stmt.executeQuery(sql);
	}

	catch(Exception e) {
	out.println("DB 연동오류입니다. : " + e.getMessage() );
	}

	while(rs.next()) {
		if(rs.getString("max_id")==null)
		{new_id=0;}
		else{
		new_id=Integer.parseInt(rs.getString("max_id"));
		}
	}
	new_id++;

	title=request.getParameter("title");
	content=request.getParameter("content");
	reply=request.getParameter("reply");
	password=request.getParameter("password");
	
	
	if("y".equals(reply)){
		ref=Integer.parseInt(request.getParameter("ref"));
	} else{
		ref=new_id;
	}
	
	
	sql_update="insert into board_tbl values ("+new_id+","+"'"+ref+"'"+","+"'"+session.getAttribute("sessionName")+"'"+","+"'"+title+"'"+","+"'"+content+"'"+","+"'"+reply+"'"+","+"'"+password+"'"+","+now+")";

	
stmt.executeUpdate(sql_update);
out.println("<SCRIPT>parent.location.href='board.jsp';</SCRIPT>");
%>
</body>
</html>