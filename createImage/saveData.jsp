<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="javax.servlet.*" %>
<%@ page import= "javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Data Saved</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/createImage/css/login.css">
    <style>
    	.bg{
    		background: #522269;
            overflow: hidden;
            width: 100%;
            height: 100%;
            user-select: none;
    	}
    	.saveText{
    		color:#FFF;
    		margin-top: 80px;
    		text-align:center;
    		font-size: 50px;
    	}
    	svg{
			width: 500px;
    		height: 500px;
    		margin: 90px auto 0; /* auto를 사용하여 수평 가운데 정렬 */
    		display: block; /* 가운데 정렬을 위해 블록 요소로 설정 */
		}
    </style>
</head>
<body class="bg">

<%
    
    // 세션에서 사용자 정보를 가져옴
     session = request.getSession();	
    String userEmail = (String) session.getAttribute("userEmail");
    String userName = (String) session.getAttribute("userName");
    System.out.println("세션 email: " + userEmail + "\n");
    
    %>

<%
	String dbquestion = (String) request.getAttribute("dbquestion");
    String dbimageUrl = (String) request.getAttribute("dbimageUrl");
    String dbdate = (String) request.getAttribute("dbdate");
    dbquestion = URLDecoder.decode(dbquestion, "UTF-8");
    dbdate = URLDecoder.decode(dbdate, "UTF-8");
    dbimageUrl = URLDecoder.decode(dbimageUrl, "UTF-8");
    System.out.println("동작 Question: " + dbquestion);
    System.out.println("동작 imageUrl: " + dbimageUrl);
    System.out.println("동작 date: " + dbdate + "\n");
    System.out.println("세션 email: " + userEmail + "\n");
    

    Connection conn = null;
    Statement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/dreamdraw?serverTimezone=UTC";
        conn = DriverManager.getConnection(url, "root", "0821");
        stmt = conn.createStatement();

        // SQL 질의문
         String sql = "INSERT INTO images (date, email,  imgUrl, question) VALUES ( ?, ?, ?, ?)" +
       	               			"ON DUPLICATE KEY UPDATE imgUrl = VALUES(imgurl), question = VALUES(question)";
        PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, dbdate);
			preparedStatement.setString(2, userEmail); // 사용자의 이메일을 추가
	        preparedStatement.setString(3, dbimageUrl);
			preparedStatement.setString(4, dbquestion);
			preparedStatement.executeUpdate();
%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
    	 swal('이미지 저장 완료!!','<%= userName %>님의 이미지를 저장했습니다.','success')
	 .then(function(){
		 var form = document.createElement('form');
	        form.method = 'POST';
	        form.action = '${pageContext.request.contextPath}/main';  // 실제 서블릿 URL로 변경;

	        // 폼을 바디에 추가하고 서브밋
	        document.body.appendChild(form);
	        form.submit();          
})
</script>


<%
} catch (Exception e) {
    // Send an error response to the client
    response.getWriter().write("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
} finally {
    // Close database resources
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
}
%>
    
 

</body>
</html>
