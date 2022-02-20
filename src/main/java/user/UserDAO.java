package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
//	Class.forName() �� �̿��ؼ� ����̹� �ε�
//	DriverManager.getConnection() ���� ���� ���
//	Connection �ν��Ͻ��� �̿��ؼ� Statement ��ü ����
//	Statement ��ü�� ����� ResultSet �̳� int�� �ޱ�
	public UserDAO() {
		try {
			String dbURL="jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";	
			String dbID="root";
			String dbPassword="root1234";
			Class.forName("com.mysql.cj.jdbc.Driver"); //����̹� �ε�
			conn =DriverManager.getConnection(dbURL,dbID,dbPassword); // ���� ��� 
			//db���� ����� ����Ǿ� jdbc�� ��Ŭ���� ������ ���߰� dbURL������ �ణ �ٲ�� �Ѵ�.
			//��Ʈ��ȣ �� Ȯ��!
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL="SELECT userPassword FROM USER WHERE userID=?";
		try {
			pstmt=conn.prepareStatement(SQL); // SQL ���� ��ü
			pstmt.setString(1, userID);  // SQL ��ü�� ù ��° ����ǥ �� ����
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
	
	public int join(User user) { //userŬ������ �̿��� ������� �� �ִ� �ϳ��� �ν��Ͻ�
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
			System.out.println("������ �߻��߽��ϴ�.");
			// TODO: handle exception
		}
		return -1;
	}
	
}