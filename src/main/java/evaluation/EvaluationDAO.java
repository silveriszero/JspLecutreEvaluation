package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.DatabaseConnection;

public class EvaluationDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public EvaluationDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public int write(EvaluationDTO evaluationDTO) {
		String SQL = "insert into evaluation values (NULL,?,?,?,?,?,?,?,?,?,?,?,?,0);";
		PreparedStatement pstmt = null;
		rs = null;
		try {
			if(conn == null ) {
				System.out.println("텅 비었음 새끼야"); 
			}
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationDTO.getUserID());
			pstmt.setString(2, evaluationDTO.getLectureName());
			pstmt.setString(3, evaluationDTO.getProfessorName());
			pstmt.setInt(4, evaluationDTO.getLectureYear());
			pstmt.setString(5, evaluationDTO.getSemesterDivide());
			pstmt.setString(6, evaluationDTO.getLectureDivide());
			pstmt.setString(7, evaluationDTO.getEvaluationTitle());
			pstmt.setString(8, evaluationDTO.getEvaluationContent());
			pstmt.setString(9, evaluationDTO.getTotalScore());
			pstmt.setString(10, evaluationDTO.getCreditScore());
			pstmt.setString(11, evaluationDTO.getComfortableScore());
			pstmt.setString(12, evaluationDTO.getLectureScore());
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber ){
		if(lectureDivide.equals("전체")) {
			lectureDivide ="";
		}
		
		ArrayList<EvaluationDTO> evaluationList = new ArrayList<>();
		String SQL = "";
		
		if(searchType.equals("최신순")) {
			 SQL = "SELECT * FROM evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY evaluationID DESC LIMIT ? OFFSET ?";
					
		} else if(searchType.equals("추천순")){
			SQL = "SELECT * FROM evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY likeCount DESC LIMIT ? OFFSET ?";
	    
			
		}
		
		try (PreparedStatement pstmt = conn.prepareStatement(SQL)) { 
			pstmt.setString(1, "%" + lectureDivide + "%");
            pstmt.setString(2, "%" + search + "%");
            pstmt.setInt(3, 6);
            pstmt.setInt(4, pageNumber * 5);
            rs = pstmt.executeQuery();
			
			while(rs.next()) {
				evaluationList.add(new EvaluationDTO(
						rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14)
						));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} 
		
		return evaluationList;
		
	}
	//추천수 증가
	public int like(String evaluationID) {
		PreparedStatement pstmt = null;
		try{
			String SQL = "update  evaluation set likeCount = likeCount+1 where evaluationID = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	//삭제
	public int delete(String evaluationID) {
		PreparedStatement pstmt = null ;
		try {
			String SQL = "delete from evaluation where evaluationID = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	//작성한 사용자의 아이디
	public String getUserID(String evaluationID) {
		PreparedStatement pstmt = null;
		try {
			String SQL = "select userID from evaluation where evaluationID = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,Integer.parseInt(evaluationID));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	

}


