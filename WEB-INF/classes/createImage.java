import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.net.URL;
import java.nio.file.Path;
import java.nio.file.Paths;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
//import javax.servlet.http.HttpSession;

@WebServlet("/createImage")
public class createImage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // 클라이언트에서 보낸 파라미터 값을 읽기
            String dbquestion = request.getParameter("question");
            String dbimageUrl = request.getParameter("imageUrl");
            dbimageUrl = URLDecoder.decode(dbimageUrl, "UTF-8");
            String dbdate = request.getParameter("date");
			

            // 이미지 다운로드 및 저장
            dbimageUrl = saveImage(dbimageUrl, "/createImage/image");
            dbimageUrl = URLEncoder.encode(dbimageUrl, "UTF-8");

            System.out.println("서버 Question: " + dbquestion);
            System.out.println("서버 ImageUrl: " + dbimageUrl);
            System.out.println("서버 date: " + dbdate);
            request.setAttribute("dbquestion", dbquestion);
            request.setAttribute("dbimageUrl", dbimageUrl);
            request.setAttribute("dbdate", dbdate);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/createImage/saveData.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Error processing data");
        }
    }

    public String saveImage(String imageUrl, String destinationDirectory) throws IOException {
        // 이미지 파일 이름 생성 (예: 현재 시간을 기반으로)
        String imageName = System.currentTimeMillis() + ".jpg";

        // 이미지 다운로드 및 저장
        Path destinationPath = Paths.get(getServletContext().getRealPath(destinationDirectory), imageName);
        System.out.println("절대 경로: " + destinationPath);
        try (InputStream in = new URL(imageUrl).openStream();
             FileOutputStream out = new FileOutputStream(destinationPath.toFile())) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            
        }
        catch (IOException e) {
            e.printStackTrace();
            throw e;  // 예외 다시 던지기
        }

        // 저장된 이미지의 상대 경로 반환
        System.out.println("경로: " + getServletContext().getRealPath(destinationDirectory));
        return destinationDirectory + "/" + imageName;
    }
    
}
