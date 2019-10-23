package tinyHome.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sun.org.apache.bcel.internal.generic.ATHROW;

public class MemberDAO {
	//필수변수 선언+초기화
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql="";
	//필수변수 선언+초기화

	//DB연결
	private Connection getCon() throws Exception{
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysqlDB");
		con=ds.getConnection();
		System.out.println("DB연결");
		return con;
	}//DB연결

	//DB연결 해제
	public void closeDB(){
		try{
			if(con!=null){con.close();}
			if(pstmt!=null){pstmt.close();}
			if(rs!=null){rs.close();}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}//DB연결 해제
	
	//insertMember(mb)
	public void insertMember(MemberBean mb){
		try{
			con=getCon();
			
			sql="INSERT INTO member (id,pw,name,nick,jumin,gender,age,"
					+ "phone,mail,post,addr,reg_date) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPw());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getNick());
			pstmt.setString(5, mb.getJumin());
			pstmt.setString(6, mb.getGender());
			pstmt.setInt(7, mb.getAge());
			pstmt.setString(8, mb.getPhone());
			pstmt.setString(9, mb.getMail());
			pstmt.setString(10, mb.getPost());
			pstmt.setString(11, mb.getAddr());
			pstmt.setTimestamp(12, mb.getReg_date());
			pstmt.executeUpdate();
			System.out.println("회원가입완료");
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}//insertMember(mb)
	//joinIdCheck(id)
	public int joinIdCheck(String id){
		int check=0;
		try{
			getCon();
			sql="SELECT * FROM member WHERE id=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			System.out.println("아이디 조회");
			if(rs.next()){//아이디 있음
				check=1;
			}else{//아이디 없음
				check=0;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return check;
	}//joinIdCheck(id)
	//joinNickCheck(nick)
	public int joinNickCheck(String nick){
		int check=0;
		try{
			getCon();
			sql="SELECT * FROM member WHERE nick=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs=pstmt.executeQuery();
			System.out.println("닉네임 조회");
			if(rs.next()){//닉네임 있음
				check=1;
			}else{//닉네임 없음
				check=0;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return check;
	}//joinNickCheck(nick)
	//joinMailCheck(mail)
	public int joinMailCheck(String mail){
		int check=0;
		try{
			getCon();
			sql="SELECT * FROM member WHERE mail=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mail);
			rs=pstmt.executeQuery();
			System.out.println("메일 조회");
			if(rs.next()){//메일 있음
				check=1;
			}else{//메일 없음
				check=0;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return check;
	}//joinMailCheck(mail)
	
	//idCheck(id,pw)
	public int idCk(String id, String pw){
		int check=-1;
		
		try {
			con=getCon();
			sql="SELECT pw FROM member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next()){//횐
				if(pw.equals(rs.getString("pw"))){
					check = 1;
				}else{
					check = 0;
				}
			}else{//노횐
				check = -1;
			}
			System.out.println("로그인 처리 값 : "+check);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return check;
	}//idCheck(id,pw)
	
	//getMember(id)
	public MemberBean getMember(String id){
		MemberBean mb = null;
		
		try {
			con=getCon();
			sql="SELECT * FROM member WHERE id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				mb = new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPw(rs.getString("pw"));
				mb.setName(rs.getString("name"));
				mb.setNick(rs.getString("nick"));
				mb.setJumin(rs.getString("jumin"));
				mb.setGender(rs.getString("gender"));
				mb.setAge(rs.getInt("age"));
				mb.setPhone(rs.getString("phone"));
				mb.setMail(rs.getString("mail"));
				mb.setPost(rs.getString("post"));
				mb.setAddr(rs.getString("addr"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
			}
			System.out.println("회원 정보 저장 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return mb;
	}//getMember(id)
	//updateMember(mb)
	public int updateMember(MemberBean mb){
		int check=-1;
		
		try {
			con=getCon();
			
			sql="SELECT pw FROM member WHERE id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,mb.getId());
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				if(mb.getPw().equals(rs.getString("pw"))){
					sql="UPDATE member SET pw=?,nick=?,phone=?,mail=?,post=?,addr=? WHERE id=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, mb.getPw());
					pstmt.setString(2, mb.getNick());
					pstmt.setString(3, mb.getPhone());
					pstmt.setString(4, mb.getMail());
					pstmt.setString(5, mb.getPost());
					pstmt.setString(6, mb.getAddr());
					pstmt.setString(7, mb.getId());
					
					pstmt.executeUpdate();
					System.out.println("회원 정보 수정 완료");
					check=1;
				}else{
					check=0;
				}
			}else{//아이디없음
				check=-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return check;
	}//updateMember(mb)
	
	
	//deleteMember(id, pw)
	public int deleteMember(String id, String pw){
		int check=-1;
		
		try {
			con=getCon();
			
			sql="SELECT pw FROM member WHERE id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){
					sql="DELETE FROM member WHERE id=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					System.out.println("회원 정보 삭제 완료");
					check=1;
				}else{
					check=0;
				}
			}else{
				check=-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return check;
	}//deleteMember(id, pw)
	
	//getMemberList(mb)
	public ArrayList<MemberBean> getMemberList(){
		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		try {
			con=getCon();
			
			sql="SELECT * FROM member";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				MemberBean mb = new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPw(rs.getString("pw"));
				mb.setName(rs.getString("name"));
				mb.setNick(rs.getString("nick"));
				mb.setJumin(rs.getString("jumin"));
				mb.setGender(rs.getString("gender"));
				mb.setAge(rs.getInt("age"));
				mb.setPhone(rs.getString("phone"));
				mb.setMail(rs.getString("mail"));
				mb.setPost(rs.getString("post"));
				mb.setAddr(rs.getString("addr"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				
				memberList.add(mb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return memberList;
	}
	//getMemberList(mb)
}
