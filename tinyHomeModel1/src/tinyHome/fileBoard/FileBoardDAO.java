package tinyHome.fileBoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.swing.plaf.synth.SynthScrollPaneUI;

public class FileBoardDAO {
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
	
	// insertFileBoard(fbb)
	public void insertFileBoard(FileBoardBean fbb){
		int num = 0;
		
		try {
			con = getCon();
			// 1. 글번호 계산 
			sql = "select max(num) from FileBoard";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
				//num = rs.getInt("max(num)") + 1;
			}
			
			System.out.println("num : "+num);
			// 2. 전달받은 fbb객체를 사용 글쓰기 
			sql="insert into "
					+ "FileBoard(num,id,name,pw,subject,content,"
					+ "readcount,re_ref,re_lev,re_seq,"
					+ "date,ip,file) "
					+ "values(?,?,?,?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, fbb.getId());
			pstmt.setString(3, fbb.getName());
			pstmt.setString(4, fbb.getPw());
			pstmt.setString(5, fbb.getSubject());
			pstmt.setString(6, fbb.getContent());
			pstmt.setInt(7, 0);  // 조회수 - 0 초기화
			pstmt.setInt(8, num); // 답글 그룹번호 == 글번호
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 0);
			pstmt.setString(11, fbb.getIp());
			pstmt.setString(12, fbb.getFile());
			
			// 실행 
		    pstmt.executeUpdate();
			
		    System.out.println("글쓰기 완료!!");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
	}
	// insertFileBoard(fbb)
	
	// getFileBoardCount()
	public int getFileBoardCount(){
		int cnt = 0;
		
		try {
			// 디비연결
			con = getCon();
			// 게시판의 글개수 계산
			sql ="select count(*) from FileBoard";
			
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
	// getFileBoardCount()
	
	// getFileBoardList(startRow,pageSize)
	public List getFileBoardList(int startRow,int pageSize){
		List FileBoardList = new ArrayList();
		
		 try {
			con = getCon();
			
			// 최신글이 제일 위쪽으로 오게 정렬(내림차순),그룹별 오름차순 정렬
			// +) 필요한 만큼씩 데이터를 짤라가기 
			sql ="select * from FileBoard "
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
				// 게시판 글이 존재한다. -> 정보를 저장 -> FileBoardBean 객체담아서
				// -> arrayList에 저장  -> arrayList만 전달
				FileBoardBean fbb = new FileBoardBean();
				
				fbb.setNum(rs.getInt("num"));
				fbb.setId(rs.getString("id"));
				fbb.setName(rs.getString("name"));
				fbb.setPw(rs.getString("pw"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
				fbb.setDate(rs.getDate("date"));
				fbb.setReadcount(rs.getInt("readcount"));
				fbb.setRe_ref(rs.getInt("re_ref"));
				fbb.setRe_lev(rs.getInt("re_lev"));
				fbb.setRe_seq(rs.getInt("re_seq"));
				fbb.setIp(rs.getString("ip"));
				fbb.setFile(rs.getString("file"));
				//  글 하나의 정보를 모두 저장 완료 
				
				// 글하나의 정보를 FileBoardList 한칸에 저장
				FileBoardList.add(fbb);	
			}
            System.out.println(" 게시판 글 목록 전달 완료 ");			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return FileBoardList;
	}
	// getFileBoardList(startRow,pageSize)
	
	// getFileBoard(num)
	public FileBoardBean getFileBoard(int num){
		FileBoardBean fbb = null;
		
		try {
			con = getCon();
			
			sql="select * from FileBoard where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				fbb = new FileBoardBean();
				
				fbb.setName(rs.getString("name"));
				fbb.setId(rs.getString("id"));
				fbb.setNum(rs.getInt("num"));
				fbb.setPw(rs.getString("pw"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
				fbb.setReadcount(rs.getInt("readcount"));
				fbb.setRe_ref(rs.getInt("re_ref"));
				fbb.setRe_lev(rs.getInt("re_lev"));
				fbb.setRe_seq(rs.getInt("re_seq"));
				fbb.setDate(rs.getDate("date"));
				fbb.setIp(rs.getString("ip"));
				fbb.setFile(rs.getString("file"));			
			}
			System.out.println(" 글번호에 해당하는 글정보 저장완료 ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
		return fbb;
	}
	// getFileBoard(num)
	
	// updateFileBoard(fbb)
	public int updateFileBoard(FileBoardBean fbb){
		int check =-1;
		
		try {
			con = getCon();
			
			sql="select pw from FileBoard where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, fbb.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				// 글번호에 해당하는 비밀번호가 있다 => 글이 존재한다
				if(fbb.getPw().equals(rs.getString("pw"))){
					// 정보 수정 
					sql ="update FileBoard set subject=?,content=? where num=? ";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, fbb.getSubject());
					pstmt.setString(2, fbb.getContent());
					pstmt.setInt(3, fbb.getNum());
					
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
	// updateFileBoard(fbb)
	
	// updateReadCount(num)
	public void updateReadCount(int num){
		try {
			 con = getCon();
			 // readcount 값을 1증가 해당 글번호만 
			 sql="update FileBoard set readcount=readcount+1 where num=?";
			 
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
	
	// deleteFileBoard(num,pw)
	public int deleteFileBoard(int num,String pw){
		int check =-1;
		
		try {
			con = getCon();
			
			sql ="select pw from FileBoard where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){
					// delete sql
					sql ="delete from FileBoard where num=?";
					
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
	// deleteFileBoard(num,pw)
	
	// reInsertFileBoard(fbb)
	public void reInsertFileBoard(FileBoardBean fbb){
		
		int num = 0;
		
		try {
			con = getCon();
			// 글번호 계산 
			sql ="select max(num) from FileBoard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println(" 답글 번호 : "+num);
			
			// 답글의 순서 재배치 
			// 같은 그룹re_ref / re_seq값이 기존값보다 크면 => re_seq+1
			
			sql ="update FileBoard set re_seq = re_seq + 1 "
					+ "where re_ref=? and re_seq > ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fbb.getRe_ref());
			pstmt.setInt(2, fbb.getRe_seq());
			
			pstmt.executeUpdate();
			
			System.out.println(" 답글 순서 재배치 완료 ");
			
			// 답글 저장 
			
			sql="insert into "
					+ "FileBoard(num,id,name,pw,subject,content,"
					+ "readcount,re_ref,re_lev,re_seq,"
					+ "date,ip,file) "
					+ "values(?,?,?,?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, fbb.getId());
			pstmt.setString(3, fbb.getName());
			pstmt.setString(4, fbb.getPw());
			pstmt.setString(5, fbb.getSubject());
			pstmt.setString(6, fbb.getContent());
			pstmt.setInt(7, 0);  // 조회수 - 0 초기화
			pstmt.setInt(8, fbb.getRe_ref());
			pstmt.setInt(9, fbb.getRe_lev()+1);
			pstmt.setInt(10, fbb.getRe_seq()+1);
			pstmt.setString(11, fbb.getIp());
			pstmt.setString(12, fbb.getFile());
			
			
			pstmt.executeUpdate();		

			System.out.println(" 답글 저장 완료 ");			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
	}
	
	// reInsertFileBoard(fbb)
	
	// getFileBoardCount(search)
	//  검색어에 해당하는 게시판의 글개수 리턴
	public int getFileBoardCount(String search){
		int count = 0;
		
		try {
			con = getCon();
			//sql -> 게시판에 있는 글중에서 내 검색어에 해당하는 글의 개수 체크
			sql = "select count(*) from FileBoard where subject like ?";
			
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
	
	
	// getFileBoardCount(search)
	
	// getFileBoardList(startRow,pageSize,search)
	public List getFileBoardList(int startRow,int pageSize,String search){
		ArrayList FileBoardList = new ArrayList();
		
		try {
			con = getCon();
			
			sql="select * from FileBoard "
					+ "where subject like ? "
					+ "order by re_ref desc,re_seq asc "
					+ "limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				FileBoardBean fbb = new FileBoardBean();
				
				fbb.setNum(rs.getInt("num"));
				fbb.setId(rs.getString("id"));
				fbb.setName(rs.getString("name"));
				fbb.setPw(rs.getString("pw"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
				fbb.setDate(rs.getDate("date"));
				fbb.setFile(rs.getString("file"));
				fbb.setIp(rs.getString("ip"));
				fbb.setReadcount(rs.getInt("readcount"));
				fbb.setRe_ref(rs.getInt("re_ref"));
				fbb.setRe_lev(rs.getInt("re_lev"));
				fbb.setRe_seq(rs.getInt("re_seq"));
				
				// FileBoardList 한칸에 해당정보 저장
				FileBoardList.add(fbb);				
				
			}
			
			System.out.println("검색어 해당 글 리스트 저장 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return FileBoardList;
	}
	// getFileBoardList(startRow,pageSize,search)
}
