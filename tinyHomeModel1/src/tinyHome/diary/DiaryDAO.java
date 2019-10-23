package tinyHome.diary;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.swing.plaf.synth.SynthScrollPaneUI;

public class DiaryDAO {
	// 필요변수 선언
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	// 디비 연결
	private Connection getCon() throws Exception {
		// Context 객체
		Context init = new InitialContext();
		// 디비 연동 정보를 불러오기 -> DataSource 객체에 정보 저장
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/mysqlDB");
		// 디비 연결
		con = ds.getConnection();

		System.out.println("디비 연결 성공!! ");
		return con;
	}

	// 디비 연결 해제
	public void closeDB() {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// insertDiary(dib)
	public void insertDiary(DiaryBean dib){
		int num = 0;
		
		try {
			con = getCon();
			// 1. 글번호 계산 
			sql = "select max(num) from diary";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
				//num = rs.getInt("max(num)") + 1;
			}
			
			System.out.println("num : "+num);
			// 2. 전달받은 dib객체를 사용 글쓰기 
			sql="insert into "
					+ "diary(num,id,name,pw,subject,content,"
					+ "readcount,re_ref,re_lev,re_seq,"
					+ "date,ip,file) "
					+ "values(?,?,?,?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, dib.getId());
			pstmt.setString(3, dib.getName());
			pstmt.setString(4, dib.getPw());
			pstmt.setString(5, dib.getSubject());
			pstmt.setString(6, dib.getContent());
			pstmt.setInt(7, 0);  // 조회수 - 0 초기화
			pstmt.setInt(8, num); // 답글 그룹번호 == 글번호
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 0);
			pstmt.setString(11, dib.getIp());
			pstmt.setString(12, dib.getFile());
			
			// 실행 
		    pstmt.executeUpdate();
			
		    System.out.println("글쓰기 완료!!");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
	}
	// insertDiary(dib)
	
	// getDiaryCount()
	public int getDiaryCount(){
		int cnt = 0;
		
		try {
			// 디비연결
			con = getCon();
			// 게시판의 글개수 계산
			sql ="select count(*) from diary";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt(1);
			}
			
			System.out.println("게시판 글개수 계산 완료 : "+cnt+"개");			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		} 	
		
		return cnt;
	}
	// getDiaryCount()
	

	// getDiary(id)
	public DiaryBean getDiary(String id){
		DiaryBean dib = null;
		
		try {
			con = getCon();
			
			sql="select * from diary where id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dib = new DiaryBean();
				
				dib.setName(rs.getString("name"));
				dib.setId(rs.getString("id"));
				dib.setNum(rs.getInt("num"));
				dib.setPw(rs.getString("pw"));
				dib.setSubject(rs.getString("subject"));
				dib.setContent(rs.getString("content"));
				dib.setReadcount(rs.getInt("readcount"));
				dib.setRe_ref(rs.getInt("re_ref"));
				dib.setRe_lev(rs.getInt("re_lev"));
				dib.setRe_seq(rs.getInt("re_seq"));
				dib.setDate(rs.getDate("date"));
				dib.setIp(rs.getString("ip"));
				dib.setFile(rs.getString("file"));			
			}
			System.out.println(" 아이디에 해당하는 글정보 저장완료 ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
		return dib;
	}
	// getDiary(id)
	
	
	// getDiaryList(startRow,pageSize)
	public List getDiaryList(int startRow,int pageSize){
		List DiaryList = new ArrayList();
		
		 try {
			con = getCon();
			
			// 최신글이 제일 위쪽으로 오게 정렬(내림차순),그룹별 오름차순 정렬
			// +) 필요한 만큼씩 데이터를 짤라가기 
			sql ="select * from diary "
					+ "order by re_ref desc,re_seq asc "
					+ "limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1); // 시작행 -1
			pstmt.setInt(2, pageSize); // 가져갈 글의 개수
			
			rs = pstmt.executeQuery();
			
			// if(rs.next()){
			//
			// }
			while(rs.next()){
				// 게시판 글이 존재한다. -> 정보를 저장 -> DiaryBean 객체담아서
				// -> arrayList에 저장  -> arrayList만 전달
				DiaryBean dib = new DiaryBean();
				
				dib.setNum(rs.getInt("num"));
				dib.setId(rs.getString("id"));
				dib.setName(rs.getString("name"));
				dib.setPw(rs.getString("pw"));
				dib.setSubject(rs.getString("subject"));
				dib.setContent(rs.getString("content"));
				dib.setDate(rs.getDate("date"));
				dib.setReadcount(rs.getInt("readcount"));
				dib.setRe_ref(rs.getInt("re_ref"));
				dib.setRe_lev(rs.getInt("re_lev"));
				dib.setRe_seq(rs.getInt("re_seq"));
				dib.setIp(rs.getString("ip"));
				dib.setFile(rs.getString("file"));
				//  글 하나의 정보를 모두 저장 완료 
				
				// 글하나의 정보를 DiaryList 한칸에 저장
				DiaryList.add(dib);	
			}
            System.out.println(" 게시판 글 목록 전달 완료 ");			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return DiaryList;
	}
	// getDiaryList(startRow,pageSize)
	
	// getDiary(num)
	public DiaryBean getDiary(int num){
		DiaryBean dib = null;
		
		try {
			con = getCon();
			
			sql="select * from diary where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dib = new DiaryBean();
				
				dib.setName(rs.getString("name"));
				dib.setId(rs.getString("id"));
				dib.setNum(rs.getInt("num"));
				dib.setPw(rs.getString("pw"));
				dib.setSubject(rs.getString("subject"));
				dib.setContent(rs.getString("content"));
				dib.setReadcount(rs.getInt("readcount"));
				dib.setRe_ref(rs.getInt("re_ref"));
				dib.setRe_lev(rs.getInt("re_lev"));
				dib.setRe_seq(rs.getInt("re_seq"));
				dib.setDate(rs.getDate("date"));
				dib.setIp(rs.getString("ip"));
				dib.setFile(rs.getString("file"));			
			}
			System.out.println(" 글번호에 해당하는 글정보 저장완료 ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
		return dib;
	}
	// getDiary(num)
	
	// updateDiary(dib)
	public int updateDiary(DiaryBean dib){
		int check =-1;
		
		try {
			con = getCon();
			
			sql="select pw from diary where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, dib.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				// 글번호에 해당하는 비밀번호가 있다 => 글이 존재한다
				if(dib.getPw().equals(rs.getString("pw"))){
					// 정보 수정 
					sql ="update diary set subject=?,content=? where num=? ";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, dib.getSubject());
					pstmt.setString(2, dib.getContent());
					pstmt.setInt(3, dib.getNum());
					
					pstmt.executeUpdate();					
					
					check = 1;
				}else{
					check = 0;
				}
				
			}else{
				// 글번호에 해당하는 비밀번호가 없다 => 글이 없음
				check = -1;
			}
			
			System.out.println(" 글 정보 수정 완료 ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return check;
	}
	// updateDiary(dib)
	
	// updateReadCount(num)
	public void updateReadCount(int num){
		try {
			 con = getCon();
			 // readcount 값을 1증가 해당 글번호만 
			 sql="update diary set readcount=readcount+1 where num=?";
			 
			 pstmt = con.prepareStatement(sql);
			 
			 pstmt.setInt(1, num);
			 
			 pstmt.executeUpdate();
			 
			 System.out.println(" 글 조회수 1증가 ");
			 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	// updateReadCount(num)
	
	// deleteDiary(num,pw)
	public int deleteDiary(int num,String pw){
		int check =-1;
		
		try {
			con = getCon();
			
			sql ="select pw from diary where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){
					// delete sql
					sql ="delete from diary where num=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();			
					
					check = 1;
				}else{
					check = 0;
				}
			}else{
				check = -1;
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return check;
	}
	// deleteDiary(num,pw)
	
	// reInsertDiary(dib)
	public void reInsertDiary(DiaryBean dib){
		
		int num = 0;
		
		try {
			con = getCon();
			// 글번호 계산 
			sql ="select max(num) from diary";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println(" 답글 번호 : "+num);
			
			// 답글의 순서 재배치 
			// 같은 그룹re_ref / re_seq값이 기존값보다 크면 => re_seq+1
			
			sql ="update diary set re_seq = re_seq + 1 "
					+ "where re_ref=? and re_seq > ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dib.getRe_ref());
			pstmt.setInt(2, dib.getRe_seq());
			
			pstmt.executeUpdate();
			
			System.out.println(" 답글 순서 재배치 완료 ");
			
			// 답글 저장 
			
			sql="insert into "
					+ "diary(num,id,name,pw,subject,content,"
					+ "readcount,re_ref,re_lev,re_seq,"
					+ "date,ip,file) "
					+ "values(?,?,?,?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, dib.getId());
			pstmt.setString(3, dib.getName());
			pstmt.setString(4, dib.getPw());
			pstmt.setString(5, dib.getSubject());
			pstmt.setString(6, dib.getContent());
			pstmt.setInt(7, 0);  // 조회수 - 0 초기화
			pstmt.setInt(8, dib.getRe_ref());
			pstmt.setInt(9, dib.getRe_lev()+1);
			pstmt.setInt(10, dib.getRe_seq()+1);
			pstmt.setString(11, dib.getIp());
			pstmt.setString(12, dib.getFile());
			
			
			pstmt.executeUpdate();		

			System.out.println(" 답글 저장 완료 ");			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
	}
	
	// reInsertDiary(dib)
	
	// getDiaryCount(search)
	//  검색어에 해당하는 게시판의 글개수 리턴
	public int getDiaryCount(String search){
		int count = 0;
		
		try {
			con = getCon();
			//sql -> 게시판에 있는 글중에서 내 검색어에 해당하는 글의 개수 체크
			sql = "select count(*) from diary where subject like ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%"+search+"%");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
		
		return count;
	}
	
	
	// getDiaryCount(search)
	
	// getDiaryList(startRow,pageSize,search)
	public List getDiaryList(int startRow,int pageSize,String search){
		ArrayList DiaryList = new ArrayList();
		
		try {
			con = getCon();
			
			sql="select * from diary "
					+ "where subject like ? "
					+ "order by re_ref desc,re_seq asc "
					+ "limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				DiaryBean dib = new DiaryBean();
				
				dib.setNum(rs.getInt("num"));
				dib.setId(rs.getString("id"));
				dib.setName(rs.getString("name"));
				dib.setPw(rs.getString("pw"));
				dib.setSubject(rs.getString("subject"));
				dib.setContent(rs.getString("content"));
				dib.setDate(rs.getDate("date"));
				dib.setFile(rs.getString("file"));
				dib.setIp(rs.getString("ip"));
				dib.setReadcount(rs.getInt("readcount"));
				dib.setRe_ref(rs.getInt("re_ref"));
				dib.setRe_lev(rs.getInt("re_lev"));
				dib.setRe_seq(rs.getInt("re_seq"));
				
				// DiaryList 한칸에 해당정보 저장
				DiaryList.add(dib);				
				
			}
			
			System.out.println("검색어 해당 글 리스트 저장 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return DiaryList;
	}
	// getDiaryList(startRow,pageSize,search)
}
