package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	
//	Class.forName() �� �̿��ؼ� ����̹� �ε�
//	DriverManager.getConnection() ���� ���� ���
//	Connection �ν��Ͻ��� �̿��ؼ� Statement ��ü ����
//	Statement ��ü�� ����� ResultSet �̳� int�� �ޱ�
	public BbsDAO() {
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
//�� �ۼ��� �����ð� �ֱ�	
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
		return ""; //�����ͺ��̽� ����
	}
	
//�� ��ȸ(���� �Խñ�)
//bID�� INT�� Ŭ���� �����͵� INT!
	public int getNext() {
		String SQL = "select bID FROM BOARD ORDER BY bID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; //�� ���� �Խñ��� ��ȸ�� �� �ֵ��� +1
			}
			return 1; //ù��° �Խñ��� ���			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
//�� �ۼ�	
	public int getWrite(String bTitle, String userID, String bContent) {
		String SQL = "INSERT INTO BOARD VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //db�� sql�� ����
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
		return -1; //�����ͺ��̽� ����
	}

//����¡ ó��	
//pageNumber = ���� ������
	public ArrayList<Board> getList(int pageNumber){
		
		String SQL = "SELECT * FROM BOARD WHERE bID < ? AND bAvailable = 1 ORDER BY bID DESC LIMIT 10"; //bID < ? Ư�����ں��� ���� ��
		ArrayList<Board> list = new ArrayList<>(); //list�� Board �ν��Ͻ� ����
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board board = new Board();
				
				//����� ���� �Խñ� ����� �� ��Ƽ� list�� ���
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

//�� ������ ���������� next�� �ȳ�Ÿ������ ó��	
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
	
//���� �Խñ� ����������
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
		return null; //�ش� �Խñ��� ���� ��
	}

//Ư�� bID�� ���� ����� ������ ����	
	public int update(int bID, String bTitle, String bContent) {
		
		String SQL = "UPDATE BOARD SET bTitle =?, bContent=? WHERE bID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //db�� sql�� ����
			pstmt.setString(1, bTitle);
			pstmt.setString(2, bContent);
			pstmt.setInt(3, bID);
			
			return pstmt.executeUpdate();	 //������		 	
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //���н�
	}
	
//�� ����
	public int delete(int bID) { //� ������ bID�� Ȯ��
		//���� �����͸� �����ϴ� ���� �ƴ϶� �Խñ� ��ȿ���ڸ� '0'���� �����Ѵ�
		String sql = "UPDATE BOARD SET bAvailable = 0 WHERE bID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bID);
				return pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //�����ͺ��̽� ���� 
		}
	
	
	
}
