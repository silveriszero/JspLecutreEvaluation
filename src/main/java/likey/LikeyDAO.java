
package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;

import user.DatabaseConnection;

public class LikeyDAO {
	private Connection conn;
	
	public LikeyDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public int like(String userID, String evaluationID, String userIP) {
		String SQL = "insert into likey values (?,?,?);";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			pstmt.setString(2,evaluationID);
			pstmt.setString(3,userIP);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //추천 중복 오류
	}
}