package test.bean;

import java.sql.*;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;

public class joinDAO {
	private Connection conn;
	private Statement stmt=null;
	private ResultSet rs=null;
	
	private static joinDAO joindao=new joinDAO();
	public static joinDAO getInstance() {
		return joindao;
	}
	private joinDAO() {}
	
	public ArrayList<joinDTO> select(){
		ArrayList<joinDTO> list=new ArrayList<joinDTO>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
			conn= DriverManager.getConnection(url,"root","qwerQWER@12");
			stmt = conn.createStatement();
			String sql="select * from join_tbl";
			rs=stmt.executeQuery(sql);
			
			while(rs.next()) {
				joinDTO dto=new joinDTO();
				dto.setName(rs.getString("name"));
				dto.setphone_Num(rs.getString("phone_Num"));
				dto.setId(rs.getString("id"));
				dto.setPassword(rs.getString("password"));
				dto.setYear(rs.getString("year"));
				dto.setMonth(rs.getString("month"));
				dto.setDay(rs.getString("day"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {rs.close();}catch(SQLException s) {}
			try {stmt.close();}catch(SQLException s) {}
			try {conn.close();}catch(SQLException s) {}
		}return list;
	}
	
	public void insert(joinDTO joindto) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
			conn= DriverManager.getConnection(url,"root","qwerQWER@12");
			stmt = conn.createStatement();
			String sql="";
			
			String name=joindto.getName();
			String phone_Num= joindto.getphone_Num();
			String id=joindto.getId();
			String pw= joindto.getPassword();
			String year=joindto.getYear();
			String month=joindto.getMonth();
			String day=joindto.getDay();
			
			sql="insert into join_tbl values ("+"'"+name+"'"+","+"'"+phone_Num+"'"+","+"'"+id+"'"+","+"'"+pw+"'"+","+"'"+year+"'"+","+"'"+month+"'"+","+"'"+day+"'"+")";
			stmt.executeUpdate(sql);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{stmt.close();}catch(SQLException s) {}
			try{conn.close();}catch(SQLException s) {}
		}
	}
	
	public int userCheck(String id, String password)throws Exception {
		String dbpasswd="";
		int x=-1;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
			conn= DriverManager.getConnection(url,"root","qwerQWER@12");
			stmt = conn.createStatement();
			String sql="";
			
			String id1=id;
	
			sql="select * from join_tbl where id= "+"'"+id1+"'";
			rs=stmt.executeQuery(sql);
			
			if(rs.next()) {
				dbpasswd=rs.getString("password");
				if(dbpasswd.equals(password))
					x=1;
				else
					x=0;
			}
			else
				x=-1;
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException ex) {}
			if(stmt!=null)try {stmt.close();}catch(SQLException ex) {}
			if(conn!=null)try {conn.close();}catch(SQLException ex) {}
		}
		return x;
	}
	
	public int confirmId(String id)throws Exception{
		int x=-1;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/wptest?serverTimezone=UTC";
			conn= DriverManager.getConnection(url,"root","qwerQWER@12");
			stmt = conn.createStatement();
			String sql="";
			
			String id1=id;
	
			sql="select id from join_tbl where id= "+"'"+id1+"'";
			rs=stmt.executeQuery(sql);
			
			if(rs.next())
				x=1;
			else
				x=-1;
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException ex) {}
			if(stmt!=null)try {stmt.close();}catch(SQLException ex) {}
			if(conn!=null)try {conn.close();}catch(SQLException ex) {}
		}
		return x;
	}
}
