

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class mydiary
 */
@WebServlet("/mydiary")
public class mydiary extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public mydiary() {
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
		 // 클라이언트로부터 전달받은 년, 월, 일, 요일 정보 추출
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        String day = request.getParameter("day");
        String dayName = request.getParameter("dayName");
        year = URLDecoder.decode(year, "UTF-8");
        month = URLDecoder.decode(month, "UTF-8");
        day = URLDecoder.decode(day, "UTF-8");
        dayName = URLDecoder.decode(dayName, "UTF-8");

        // 날짜 문자열 생성
        String dateString = year + "/" + month + "/" + day + " " + dayName;
        System.out.println("dateString: " + dateString + "\n");
		request.setAttribute("dateString",dateString);
		request.setAttribute("year",year);
		request.setAttribute("month",month);
		request.setAttribute("day",day);
		request.setAttribute("dayName",dayName);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/diary/myDiaryImage.jsp");
		dispatcher.forward(request, response);
        
        
	}

}
