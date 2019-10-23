package tinyHome.photo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.swing.plaf.synth.SynthScrollPaneUI;

public class PhotoDAO {
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
	
	// insertPhoto(pb)
	public void insertPhoto(PhotoBean pb){
		int num = 0;
		
		try {
			con = getCon();
			// 1. 글번호 계산 
			sql = "select max(num) from photo";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
				//num = rs.getInt("max(num)") + 1;
			}
			
			System.out.println("num : "+num);
			// 2. 전달받은 pb객체를 사용 글쓰기 
			sql="insert into "
					+ "photo(num,id,name,pw,subject,content,"
					+ "readcount,re_ref,re_lev,re_seq,"
					+ "date,ip,file) "
					+ "values(?,?,?,?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, pb.getId());
			pstmt.setString(3, pb.getName());
			pstmt.setString(4, pb.getPw());
			pstmt.setString(5, pb.getSubject());
			pstmt.setString(6, pb.getContent());
			pstmt.setInt(7, 0);  // 조회수 - 0 초기화
			pstmt.setInt(8, num); // 답글 그룹번호 == 글번호
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 0);
			pstmt.setString(11, pb.getIp());
			pstmt.setString(12, pb.getFile());
			
			// 실행 
		    pstmt.executeUpdate();
			
		    System.out.println("글쓰기 완료!!");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
	}
	// insertPhoto(pb)
	
	// getPhotoCount()
	public int getPhotoCount(){
		int cnt = 0;
		
		try {
			// 디비연결
			con = getCon();
			// 게시판의 글개수 계산
			sql ="select count(*) from photo";
			
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
	// getPhotoCount()
	
	// getPhotoList(startRow,pageSize)
	public List getPhotoList(int startRow,int pageSize){
		List PhotoList = new ArrayList();
		
		 try {
			con = getCon();
			
			// 최신글이 제일 위쪽으로 오게 정렬(내림차순),그룹별 오름차순 정렬
			// +) 필요한 만큼씩 데이터를 짤라가기 
			sql ="select * from photo "
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
				// 게시판 글이 존재한다. -> 정보를 저장 -> PhotoBean 객체담아서
				// -> arrayList에 저장  -> arrayList만 전달
				PhotoBean pb = new PhotoBean();
				
				pb.setNum(rs.getInt("num"));
				pb.setId(rs.getString("id"));
				pb.setName(rs.getString("name"));
				pb.setPw(rs.getString("pw"));
				pb.setSubject(rs.getString("subject"));
				pb.setContent(rs.getString("content"));
				pb.setDate(rs.getDate("date"));
				pb.setReadcount(rs.getInt("readcount"));
				pb.setRe_ref(rs.getInt("re_ref"));
				pb.setRe_lev(rs.getInt("re_lev"));
				pb.setRe_seq(rs.getInt("re_seq"));
				pb.setIp(rs.getString("ip"));
				pb.setFile(rs.getString("file"));
				//  글 하나의 정보를 모두 저장 완료 
				
				// 글하나의 정보를 PhotoList 한칸에 저장
				PhotoList.add(pb);	
			}
            System.out.println(" 게시판 글 목록 전달 완료 ");			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return PhotoList;
	}
	// getPhotoList(startRow,pageSize)
	
	// getPhoto(num)
	public PhotoBean getPhoto(int num){
		PhotoBean pb = null;
		
		try {
			con = getCon();
			
			sql="select * from photo where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				pb = new PhotoBean();
				
				pb.setName(rs.getString("name"));
				pb.setId(rs.getString("id"));
				pb.setNum(rs.getInt("num"));
				pb.setPw(rs.getString("pw"));
				pb.setSubject(rs.getString("subject"));
				pb.setContent(rs.getString("content"));
				pb.setReadcount(rs.getInt("readcount"));
				pb.setRe_ref(rs.getInt("re_ref"));
				pb.setRe_lev(rs.getInt("re_lev"));
				pb.setRe_seq(rs.getInt("re_seq"));
				pb.setDate(rs.getDate("date"));
				pb.setIp(rs.getString("ip"));
				pb.setFile(rs.getString("file"));			
			}
			System.out.println(" 글번호에 해당하는 글정보 저장완료 ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
		return pb;
	}
	// getPhoto(num)
	
	// updatePhoto(pb)
	public int updatePhoto(PhotoBean pb){
		int check =-1;
		
		try {
			con = getCon();
			
			sql="select pw from photo where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, pb.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				// 글번호에 해당하는 비밀번호가 있다 => 글이 존재한다
				if(pb.getPw().equals(rs.getString("pw"))){
					// 정보 수정 
					sql ="update photo set subject=?,content=? where num=? ";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, pb.getSubject());
					pstmt.setString(2, pb.getContent());
					pstmt.setInt(3, pb.getNum());
					
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
	// updatePhoto(pb)
	
	// updateReadCount(num)
	public void updateReadCount(int num){
		try {
			 con = getCon();
			 // readcount 값을 1증가 해당 글번호만 
			 sql="update photo set readcount=readcount+1 where num=?";
			 
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
	
	// deletePhoto(num,pw)
	public int deletePhoto(int num,String pw){
		int check =-1;
		
		try {
			con = getCon();
			
			sql ="select pw from photo where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){
					// delete sql
					sql ="delete from photo where num=?";
					
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
	// deletePhoto(num,pw)
	
	// reInsertPhoto(pb)
	public void reInsertPhoto(PhotoBean pb){
		
		int num = 0;
		
		try {
			con = getCon();
			// 글번호 계산 
			sql ="select max(num) from photo";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println(" 답글 번호 : "+num);
			
			// 답글의 순서 재배치 
			// 같은 그룹re_ref / re_seq값이 기존값보다 크면 => re_seq+1
			
			sql ="update photo set re_seq = re_seq + 1 "
					+ "where re_ref=? and re_seq > ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pb.getRe_ref());
			pstmt.setInt(2, pb.getRe_seq());
			
			pstmt.executeUpdate();
			
			System.out.println(" 답글 순서 재배치 완료 ");
			
			// 답글 저장 
			
			sql="insert into "
					+ "photo(num,id,name,pw,subject,content,"
					+ "readcount,re_ref,re_lev,re_seq,"
					+ "date,ip,file) "
					+ "values(?,?,?,?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, pb.getId());
			pstmt.setString(3, pb.getName());
			pstmt.setString(4, pb.getPw());
			pstmt.setString(5, pb.getSubject());
			pstmt.setString(6, pb.getContent());
			pstmt.setInt(7, 0);  // 조회수 - 0 초기화
			pstmt.setInt(8, pb.getRe_ref());
			pstmt.setInt(9, pb.getRe_lev()+1);
			pstmt.setInt(10, pb.getRe_seq()+1);
			pstmt.setString(11, pb.getIp());
			pstmt.setString(12, pb.getFile());
			
			
			pstmt.executeUpdate();		

			System.out.println(" 답글 저장 완료 ");			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
	}
	
	// reInsertPhoto(pb)
	
	// getPhotoCount(search)
	//  검색어에 해당하는 게시판의 글개수 리턴
	public int getPhotoCount(String search){
		int count = 0;
		
		try {
			con = getCon();
			//sql -> 게시판에 있는 글중에서 내 검색어에 해당하는 글의 개수 체크
			sql = "select count(*) from photo where subject like ?";
			
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
	
	
	// getPhotoCount(search)
	
	// getPhotoList(startRow,pageSize,search)
	public List getPhotoList(int startRow,int pageSize,String search){
		ArrayList PhotoList = new ArrayList();
		
		try {
			con = getCon();
			
			sql="select * from photo "
					+ "where subject like ? "
					+ "order by re_ref desc,re_seq asc "
					+ "limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				PhotoBean pb = new PhotoBean();
				
				pb.setNum(rs.getInt("num"));
				pb.setId(rs.getString("id"));
				pb.setName(rs.getString("name"));
				pb.setPw(rs.getString("pw"));
				pb.setSubject(rs.getString("subject"));
				pb.setContent(rs.getString("content"));
				pb.setDate(rs.getDate("date"));
				pb.setFile(rs.getString("file"));
				pb.setIp(rs.getString("ip"));
				pb.setReadcount(rs.getInt("readcount"));
				pb.setRe_ref(rs.getInt("re_ref"));
				pb.setRe_lev(rs.getInt("re_lev"));
				pb.setRe_seq(rs.getInt("re_seq"));
				
				// PhotoList 한칸에 해당정보 저장
				PhotoList.add(pb);				
				
			}
			
			System.out.println("검색어 해당 글 리스트 저장 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return PhotoList;
	}
	// getPhotoList(startRow,pageSize,search)
}
