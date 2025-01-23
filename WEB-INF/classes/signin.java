import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class signin
 */
@WebServlet("/signin")
public class signin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public signin() {
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
		 response.setContentType("text/html;charset=UTF-8");

	        try {
	            // 클라이언트에서 보낸 파라미터 값을 읽기
	            String email = request.getParameter("idInput");
	            String pwd = request.getParameter("passwordInput");
	            String name = request.getParameter("nameInput");
	            String birth = request.getParameter("birthInput");
	            email = URLDecoder.decode(email, "UTF-8");
	             pwd = URLDecoder.decode(pwd, "UTF-8");
	             name =  URLDecoder.decode(name, "UTF-8");
	             birth =  URLDecoder.decode(birth, "UTF-8");

	            System.out.println("서버 email: " + email);
	            System.out.println("서버 pwd: " + pwd);
	            System.out.println("서버 name: " + name);
	            System.out.println("서버 birth: " + birth + "\n");
	            if(email == null || pwd == null || name ==null || birth == null || email.isEmpty() || pwd.isEmpty() || name.isEmpty() || birth.isEmpty() ) {
	            	 RequestDispatcher dispatcher = request.getRequestDispatcher("/signIn/signinError.jsp");
	 	            dispatcher.forward(request, response);
	            }
	            request.setAttribute("idInput", email);
	            request.setAttribute("passwordInput", pwd);
	            request.setAttribute("nameInput", name);
	            request.setAttribute("birthInput", birth);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/signIn/saveSignin.jsp");
	            dispatcher.forward(request, response);
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	            response.getWriter().write("Error processing data");
	        }
	}

}
