

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class sharedImage
 */
@WebServlet("/sharedImage")
public class sharedImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public sharedImage() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 사용자가 입력한 이메일과 비밀번호
				response.setContentType("text/html;charset=UTF-8");
		        String sharedDate = request.getParameter("date");
		        String sharedUrl = request.getParameter("imageurl");
		        String sharedId = request.getParameter("id");
		        String sharedTitle = request.getParameter("dreamTitle");
		        String sharedAnanymous = request.getParameter("anonymousBox");
		        System.out.println("공유 변환 전 날짜: " + sharedDate);
		        System.out.println("공유 변환 전 url: " + sharedUrl);
		        System.out.println("공유 변환 전 id: " + sharedId);
		        System.out.println("공유 변환 전 제목: " + sharedTitle);
		        System.out.println("익명 변환 전 여부: " + sharedAnanymous);
		        sharedDate = URLDecoder.decode(sharedDate, "UTF-8");
		        sharedUrl = URLDecoder.decode(sharedUrl, "UTF-8");
		        sharedId = URLDecoder.decode(sharedId, "UTF-8");
		        sharedTitle = URLDecoder.decode(sharedTitle, "UTF-8");
		        sharedAnanymous = URLDecoder.decode(sharedAnanymous, "UTF-8");
		        System.out.println("공유 날짜: " + sharedDate);
		        System.out.println("공유 url: " + sharedUrl);
		        System.out.println("공유 id: " + sharedId);
		        System.out.println("공유 제목: " + sharedTitle);
		        System.out.println("익명 여부: " + sharedAnanymous);

		        // 데이터베이스 연결 정보
		        String url = "jdbc:mysql://localhost:3306/dreamdraw?serverTimezone=UTC";
		        String dbUser = "root";
		        String dbPassword = "0821";

		        // JDBC 변수
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        //ResultSet resultSet = null;

		        try {
		            // JDBC 드라이버 로드
		            Class.forName("com.mysql.cj.jdbc.Driver");

		            // 데이터베이스 연결
		            conn = DriverManager.getConnection(url, dbUser, dbPassword);
		         // Check if sharedAnanymous is "on"
		            if ("on".equals(sharedAnanymous)) {
		                // Insert data into the shared_images table with id
		                String insertQuery = "INSERT INTO sharedimages (date, email, imgUrl, title) VALUES (?, ?, ?, ?)";
		                pstmt = conn.prepareStatement(insertQuery);
		                pstmt.setString(1, sharedDate);
		                pstmt.setString(2, sharedId);
		                pstmt.setString(3, sharedUrl);
		                pstmt.setString(4, sharedTitle);
		            } else {
		                // Insert data into the shared_images table without id
		                String insertQuery = "INSERT INTO sharedimages (date,email, imgUrl, title) VALUES (?, ?, ?, ?)";
		                pstmt = conn.prepareStatement(insertQuery);
		                pstmt.setString(1, sharedDate);
		                pstmt.setString(2, "익명");
		                pstmt.setString(3, sharedUrl);
		                pstmt.setString(4, sharedTitle);
		            }

			            // 쿼리 실행
			            //resultSet = pstmt.executeQuery();
			         // 쿼리 실행
			            int rowsAffected = pstmt.executeUpdate();
			         // rowsAffected 변수를 사용하여 영향을 받은 행의 수 확인
			            System.out.println(rowsAffected + " 행이 영향을 받았습니다.");

		            
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            // JDBC 자원 해제
		            try {
		                //if (resultSet != null) resultSet.close();
		                if (pstmt != null) pstmt.close();
		                if (conn != null) conn.close();
		            } catch (SQLException e) {
		                e.printStackTrace();
		            }
		        }
                RequestDispatcher dispatcher = request.getRequestDispatcher("/diary/diaryWeb.jsp");
                dispatcher.forward(request, response);
	}

}
