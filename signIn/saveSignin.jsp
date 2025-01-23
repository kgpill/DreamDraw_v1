<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>

<%
    // 사용자로부터 받은 데이터
    String compName = request.getParameter("nameInput");
String compBirth = request.getParameter("birthInput");
String compEmail = request.getParameter("idInput");
String compPwd = request.getParameter("passwordInput");
    String name = (String) request.getAttribute("nameInput");
    String birth = (String) request.getAttribute("birthInput");
    String email = (String) request.getAttribute("idInput");
    String pwd = (String) request.getAttribute("passwordInput");
    System.out.println("동작 email: " + email);
    System.out.println("동작 pwd: " + pwd);
    System.out.println("동작 name: " + name);
    System.out.println("동작 birth: " + birth + "\n");
        Connection conn = null;
        Statement stmt = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/dreamdraw?serverTimezone=UTC";
            conn = DriverManager.getConnection(url, "root", "0821");
            stmt = conn.createStatement();

            String checkQuery = "SELECT * FROM users WHERE email = '" + email + "'";
            resultSet = stmt.executeQuery(checkQuery);

            if (resultSet.next()) {
%>
                <html>
                <head>
                    <meta charset="UTF-8">
                    <title>Email 중복 에러</title>
                    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
                  
                </head>
                <body>
                <script>
                    swal('WARNING!','이미 사용 중인 이메일입니다. 다른 이메일을 사용해주세요!','error')
               	 .then(function(){
               		history.go(-1);          
               })
                    </script></body>
                </html>
<%
            } else {
                String sql = "INSERT INTO users (email, pwd, name, birth) VALUES (?, ?, ?, ?)";
                PreparedStatement preparedStatement = conn.prepareStatement(sql);
                preparedStatement.setString(1, email);
                preparedStatement.setString(2, pwd);
                preparedStatement.setString(3, name);
                preparedStatement.setString(4, birth);
                preparedStatement.executeUpdate();
%>
                <html>
                <head>
                    <meta charset="UTF-8">
                    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/signIn/css/signIn.css">
                    <style>
                        body {
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            height: 100vh;
                            margin: 0;
                        }
                        h2 {
                            position: absolute;
                            top: 50%;
                            left: 50%;
                            transform: translate(-50%, -50%);
                        }
                    </style>
                    <title>회원가입 성공</title>
                </head>
                <body class="background">
                    <div class="background">
                        <div class="signInPage">
                            <div class="profile">
                                <svg xmlns="http://www.w3.org/2000/svg" width="151" height="152" viewBox="0 0 151 152" fill="none">
                                    <ellipse cx="75.5" cy="76" rx="75.5" ry="76" fill="#142C67" />
                                </svg>
                                <div class="person1">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="90" height="93" viewBox="0 0 90 93" fill="none">
                                        <path
                                            d="M45 57.625C59.8427 57.625 71.875 45.1729 71.875 29.8125C71.875 14.4521 59.8427 2 45 2C30.1573 2 18.125 14.4521 18.125 29.8125C18.125 45.1729 30.1573 57.625 45 57.625Z"
                                            stroke="#D9D9D9" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                                        <path
                                            d="M88 91L86.366 80.8651C85.3201 74.371 82.0821 68.4714 77.2279 64.2159C72.3738 59.9604 66.2183 57.625 59.8565 57.625H30.1435C23.7817 57.625 17.6262 59.9604 12.7721 64.2159C7.91792 68.4714 4.67987 74.371 3.634 80.8651L2 91"
                                            stroke="#D9D9D9" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                </div>
                            </div>
                            <center>
                                <h2>회원가입이 완료<br>되었습니다.</h2>
                            </center>
                            <button class="signInBox" onclick="window.location.href='${pageContext.request.contextPath}/login/login.html'">GO TO LOGIN</button>
                        </div>
                    </div>
                </body>
                </html>
<%
            }
        } catch (Exception e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
        } finally {
            if (resultSet != null) resultSet.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
%>
