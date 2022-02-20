package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
//	Class.forName() 을 이용해서 드라이버 로드
//	DriverManager.getConnection() 으로 연결 얻기
//	Connection 인스턴스를 이용해서 Statement 객체 생성
//	Statement 객체의 결과를 ResultSet 이나 int에 받기
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) {
		String SQL="SELECT userPassword FROM USER WHERE userID=?";
		try {
			pstmt=conn.prepareStatement(SQL); // SQL 실행 객체
			pstmt.setString(1, userID);  // SQL 객체의 첫 번째 물음표 값 지정
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;
				}else {
					return 0;
				}
			}
			return -1;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return -2;
	}
	
	public int join(User user) { //user클래스를 이용해 만들어질 수 있는 하나의 인스턴스
		String SQL="INSERT INTO USER VALUES (?,?,?,?,?)";
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,user.getUserID());
			pstmt.setString(2,user.getUserPassword());
			pstmt.setString(3,user.getUserName());
			pstmt.setString(4,user.getUserGender());
			pstmt.setString(5,user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("오류가 발생했습니다.");
			// TODO: handle exception
		}
		return -1;
	}
	
}