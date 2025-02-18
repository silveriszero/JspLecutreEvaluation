package user;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
	private static Connection conn = null;
	
	private DatabaseConnection() {}
	
	public static Connection getConnection() {
		if (conn == null) {
			try {
				String dbURL = "jdbc:mysql://localhost:3306/lectureevaluation";
				String dbID = "root";
				String dbPassword = "root";
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn =  DriverManager.getConnection(dbURL,dbID,dbPassword);
				System.out.println("데이터베이스 연결 성공 이래 ㅠㅠ");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return conn;
	}
}
