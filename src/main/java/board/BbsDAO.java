package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	
//	Class.forName() 을 이용해서 드라이버 로드
//	DriverManager.getConnection() 으로 연결 얻기
//	Connection 인스턴스를 이용해서 Statement 객체 생성
//	Statement 객체의 결과를 ResultSet 이나 int에 받기
	public BbsDAO() {
		try {
			String dbURL="jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";	
			String dbID="root";
			String dbPassword="root1234";
			Class.forName("com.mysql.cj.jdbc.Driver"); //드라이버 로드
			conn =DriverManager.getConnection(dbURL,dbID,dbPassword); // 연결 얻기 
			//db접근 방식이 변경되어 jdbc와 이클립스 버전을 맞추고 dbURL설정을 약간 바꿔야 한다.
			//포트번호 꼭 확인!
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
//글 작성시 서버시간 넣기	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
//글 조회(현재 게시글)
//bID가 INT라서 클래스 데이터도 INT!
	public int getNext() {
		String SQL = "select bID FROM BOARD ORDER BY bID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; //그 다음 게시글이 조회될 수 있도록 +1
			}
			return 1; //첫번째 게시글인 경우			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
//글 작성	
	public int getWrite(String bTitle, String userID, String bContent) {
		String SQL = "INSERT INTO BOARD VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //db에 sql문 전달
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();			 	
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}

//페이징 처리	
//pageNumber = 현재 페이지
	public ArrayList<Board> getList(int pageNumber){
		
		String SQL = "SELECT * FROM BOARD WHERE bID < ? AND bAvailable = 1 ORDER BY bID DESC LIMIT 10"; //bID < ? 특정숫자보다 작을 때
		ArrayList<Board> list = new ArrayList<>(); //list에 Board 인스턴스 저장
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board board = new Board();
				
				//결과로 나온 게시글 목록을 다 담아서 list에 담아
				board.setbID(rs.getInt(1));
				board.setbTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setbDate(rs.getString(4));
				board.setbContent(rs.getString(5));
				board.setbAvailable(rs.getInt(6));
				
				list.add(board);
			}
					
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

//젤 마지막 페이지에는 next가 안나타나도록 처리	
	public boolean nextPage(int pageNumber) {
		
		String SQL = "SELECT * FROM BOARD WHERE bID < ? AND bAvailable = 1"; 
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1)*10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
					
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
//선택 게시글 보여지도록
	public Board getBoard(int bID) {
		
		String SQL = "SELECT * FROM BOARD WHERE bID = ?"; 
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				Board board = new Board();
				
				board.setbID(rs.getInt(1));
				board.setbTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setbDate(rs.getString(4));
				board.setbContent(rs.getString(5));
				board.setbAvailable(rs.getInt(6));
				
				return board;
			}
					
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; //해당 게시글이 없을 때
	}

//특정 bID로 들어온 제목과 내용을 수정	
	public int update(int bID, String bTitle, String bContent) {
		
		String SQL = "UPDATE BOARD SET bTitle =?, bContent=? WHERE bID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //db에 sql문 전달
			pstmt.setString(1, bTitle);
			pstmt.setString(2, bContent);
			pstmt.setInt(3, bID);
			
			return pstmt.executeUpdate();	 //성공시		 	
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //실패시
	}
	
//글 삭제
	public int delete(int bID) { //어떤 글인지 bID로 확인
		//실제 데이터를 삭제하는 것이 아니라 게시글 유효숫자를 '0'으로 수정한다
		String sql = "UPDATE BOARD SET bAvailable = 0 WHERE bID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bID);
				return pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류 
		}
	
	
	
}
