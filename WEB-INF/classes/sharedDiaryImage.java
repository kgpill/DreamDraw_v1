

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class sharedDiaryImage
 */
@WebServlet("/sharedDiaryImage")
public class sharedDiaryImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public sharedDiaryImage() {
        super();
        // TODO Auto-generated constructor stub
    }

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String Url = request.getParameter("imgUrl");
        String title = request.getParameter("question");
        String dateString = request.getParameter("dateString");
        Url = URLDecoder.decode(Url, "UTF-8");
        title = URLDecoder.decode(title, "UTF-8");
        dateString = URLDecoder.decode(dateString, "UTF-8");
        
		request.setAttribute("Url",Url);
		request.setAttribute("title",title);
		request.setAttribute("dateString",dateString);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/diary/sharedDiaryImage.jsp");
		dispatcher.forward(request, response);
	}

}
