	import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	
	import java.net.URLDecoder;
	
	
	@WebServlet("/askgpt")
	public class askgpt extends HttpServlet {
	    private static final long serialVersionUID = 1L;
	    
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	    	response.setContentType("text/html;charset=UTF-8");
	    	
	    	try {
	            // 클라이언트에서 보낸 파라미터 값을 읽기
	            String question = request.getParameter("question");
	            String imageUrl = request.getParameter("imageUrl");
	            String date = request.getParameter("date");
	            String day = request.getParameter("day");

	            // 필요한 경우에만 디코딩
	            question = URLDecoder.decode(question, "UTF-8");
	             imageUrl = URLDecoder.decode(imageUrl, "UTF-8");
	             date =  URLDecoder.decode(date, "UTF-8");
	             day =  URLDecoder.decode(day, "UTF-8");
	             date = date + " " +  day;

	            System.out.println("Question: " + question);
	            System.out.println("ImageUrl: " + imageUrl);
	            System.out.println("date: " + date + "\n");

	            request.setAttribute("question", question);
	    		request.setAttribute("imageurl",imageUrl);
	    		request.setAttribute("date",date);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/createImage/createimage.jsp");
	    		dispatcher.forward(request, response);
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	            response.getWriter().write("Error processing data");
	        }
	    	    }
	    }
