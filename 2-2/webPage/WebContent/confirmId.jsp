<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="test.bean.joinDAO"%>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<title>ID 중복확인</title>
<% request.setCharacterEncoding("utf-8");%>
<%
 String id=request.getParameter("id");
 joinDAO joindao=joinDAO.getInstance();
 int check=joindao.confirmId(id);
 
 if(check==1){%>
<b><font color="Red"><%=id %></font>는 이미 사용중인 아이디입니다.</b>
<form name="checkForm" method="post" action="confirmId.jsp">
	<b>다른 아이디를 입력하세요.</b><br>
	<br> <input type="text" name="id" /> <input type="submit"
		value="ID중복확인" />
</form>
<%
  }else{
  %><center>
	<br>
	<br> <b>입력하신 <font color="Red"><%=id %></font>는 <br> 사용하실 수 있는 아이디입니다.
	</b><br>
	<br> <input type="button" class="my_button" value="닫기"
		onclick="setid()">
</center>
<%}%>

<script language="javascript">
 function setid()
 {
	 opener.document.userinput.id.value="<%=id%>";
	 self.close();
 }
</script>
