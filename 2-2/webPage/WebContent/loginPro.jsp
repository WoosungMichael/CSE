<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="test.bean.joinDAO,test.bean.joinDTO"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="joindto" class="test.bean.joinDTO" />

<%

String id=request.getParameter("id");
String password=request.getParameter("password");
String phone_Num=null;
String name=null;

 //DB id&pw 확인 - joinDAO.java에서의 userCheck()메소드
 joinDAO dao=joinDAO.getInstance();
 int check=dao.userCheck(id,password);
 
 if(check==1){
	 Connection conn = null;
	 Statement stmt = null;
	 ResultSet rs = null;
	 try{
	 	Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
		conn= DriverManager.getConnection(url,"root","qwerQWER@12");
	 	stmt = conn.createStatement();
	 	String sql= "select * from join_tbl where id="+"'"+id+"'";
	 	rs= stmt.executeQuery(sql);
	 	}
	 	catch(Exception e) {
	 	out.println("DB 연동오류입니다. : " + e.getMessage() );
	 	}
	 while(rs.next()){
	  name=rs.getString("name");
	  phone_Num=rs.getString("phone_Num");
	 }
	 
	 session.setAttribute("sessionName",name);
	 session.setAttribute("sessionId",id);
	 session.setAttribute("sessionNum",phone_Num);
	 response.sendRedirect("login_menu.jsp");
	 %>
<% }else if(check==0){%>
<script>
  alert("비밀번호가 맞지 않습니다.");
  history.go(-1);
 </script>
<% }else{ %>
<script>
  alert("아이디가 맞지 않습니다.");
  history.go(-1);
 </script>
<%} %>
