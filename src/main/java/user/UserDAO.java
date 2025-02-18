package user; 

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public UserDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "select userPassword From user where userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) return 1; //로그인 성공
				else return 0; //비밀번호 틀림
			}
			return -1; //아이디 없음
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2; //데이터 베이스 오류
	}
	
	public int Join(UserDTO  user) {
		String SQL = "insert into user values(?,?,?,?,false)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,user.getUserID());
			pstmt.setString(2,user.getUserPassword());
			pstmt.setString(3,user.getUserEmail());
			pstmt.setString(4,user.getUserEmailHash());
			return pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return -1; //회원가입 실패
	}
	
	public String getUserEmail(String userID) {
		String SQL = "select userEmail From user where userID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1); //이메일 주소 반환
			}
		} catch (SQLException e){
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean getUserEmailChecked(String userID) {
		String SQL = "select userEmailChecked from user where userID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getBoolean(1); //이메일 등록 여부 반환
			}
		} catch (SQLException e){
			e.printStackTrace();
		}		
		return false ; //데이터 베이스 오류
	}
	
	public boolean setUserEmailChecked(String userID) {
		String SQL = "update user set userEmailChecked = true where userID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			//rs = pstmt.executeQuery();
			pstmt.executeUpdate(); 
			return true; // 이메일 등록 설정 사용
			
		} catch (SQLException e){
			e.printStackTrace();
		}		
		return false ; // 이메일 등록 설정 실패
	}
	
}





















