

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.net.URLDecoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 사용자가 입력한 이메일과 비밀번호
		response.setContentType("text/html;charset=UTF-8");
        String userEmail = request.getParameter("emailInput");
        String userPwd = request.getParameter("passwordInput");
        userEmail = URLDecoder.decode(userEmail, "UTF-8");
        userPwd = URLDecoder.decode(userPwd, "UTF-8");
        System.out.println("입력 id: " + userEmail);
        System.out.println("입력 pwd: " + userPwd);

        // 데이터베이스 연결 정보
        String url = "jdbc:mysql://localhost:3306/dreamdraw?serverTimezone=UTC";
        String dbUser = "root";
        String dbPassword = "0821";

        // JDBC 변수
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        try {
            // JDBC 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 데이터베이스 연결
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // SQL 쿼리문
            String sql = "SELECT * FROM users WHERE email = ? AND pwd = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userEmail);
            pstmt.setString(2, userPwd);

            // 쿼리 실행
            resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                // 로그인 성공 시 사용자 정보를 세션에 저장
                String userName = resultSet.getString("name");
                HttpSession session = request.getSession();
               
                session.setAttribute("userEmail", userEmail);
                session.setAttribute("userName", userName);

                // 로그인 성공 후 다른 페이지로 리다이렉트
                RequestDispatcher dispatcher = request.getRequestDispatcher("/main/mainWeb.jsp");
                dispatcher.forward(request, response);
            } else {
                // 로그인 실패 시 처리 (예: 다시 로그인 페이지로 이동)
            	RequestDispatcher dispatcher = request.getRequestDispatcher("/login/loginError.html");
                dispatcher.forward(request, response);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // JDBC 자원 해제
            try {
                if (resultSet != null) resultSet.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
