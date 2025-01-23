<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
    <%@ page import="javax.servlet.*" %>
    <%@ page import= "javax.servlet.http.HttpSession" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>

<%
String dateString = (String) request.getAttribute("dateString");
String title = null;
String email = null;
String imgUrl = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
//결과를 저장할 리스트 생성
// dateList를 JSON 형태로 변환
    String jsonArrayString = null;
   List<String> dateList = new ArrayList<>();
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/dreamdraw?serverTimezone=UTC";
    conn = DriverManager.getConnection(url, "root", "0821");
    stmt = conn.createStatement();
        // 쿼리 작성
        String sql = "SELECT *  FROM sharedimages WHERE date = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, dateString);
        rs = psmt.executeQuery();
        // 결과 확인 및 리스트에 추가
        while (rs.next()) {
            title = rs.getString("title");
            email = rs.getString("email");
            imgUrl = rs.getString("imgUrl");
            System.out.println("불러온 제목: " + title);
            System.out.println("불러온 id: " + email);
            System.out.println("불러온 Url: " + imgUrl);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 연결 해제
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }

%>


<!DOCTYPE html>
<html>
<head>
<style>
        .bg {
            background: #522269;
            overflow: hidden;
            width: 100%;
            height: 100%;
            user-select: none;
        }
    </style>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/diary/css/sharedList.css">
</head>
<body  class="bg">
	<div class="calenderText">
		공유 달력
	</div>
	<div class="outsideBox">
		<div class="dateText">
			<%=dateString%>
		</div>
		<div class="x" onclick="javascript: goBack();">
			<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
  				<path d="M21.6773 20.1217C21.7796 20.2238 21.8607 20.3451 21.9161 20.4786C21.9714 20.6121 22 20.7552 22 20.8997C22 21.0442 21.9716 21.1873 21.9163 21.3208C21.8611 21.4543 21.78 21.5756 21.6778 21.6778C21.5756 21.78 21.4543 21.8611 21.3208 21.9163C21.1873 21.9716 21.0442 22 20.8997 22C20.7552 22 20.6121 21.9714 20.4786 21.9161C20.3451 21.8607 20.2238 21.7796 20.1217 21.6773L10.9995 12.5551L1.8773 21.6773C1.67096 21.8834 1.39125 21.9991 1.09964 21.999C0.808022 21.9989 0.528378 21.883 0.322177 21.6768C0.115975 21.4706 9.14952e-05 21.191 5.41563e-08 20.8994C-9.13869e-05 20.6078 0.115617 20.3281 0.321689 20.1217L9.44391 10.9995L0.321689 1.8773C0.115617 1.67096 -9.13869e-05 1.39125 5.41563e-08 1.09964C9.14952e-05 0.808022 0.115975 0.528378 0.322177 0.322177C0.528378 0.115975 0.808022 9.14952e-05 1.09964 5.41563e-08C1.39125 -9.13869e-05 1.67096 0.115617 1.8773 0.321689L10.9995 9.44391L20.1217 0.321689C20.3281 0.115617 20.6078 -9.13869e-05 20.8994 5.41563e-08C21.191 9.14952e-05 21.4706 0.115975 21.6768 0.322177C21.883 0.528378 21.9989 0.808022 21.999 1.09964C21.9991 1.39125 21.8834 1.67096 21.6773 1.8773L12.5551 10.9995L21.6773 20.1217Z" fill="#D9D9D9"/>
			</svg>
		</div>
		<div class="insideBox">
			<div class="diaryBox"  onclick="javascript: goSharedDiary();">
				<div class="number" >1</div>
				<div class="name" ><%=email %>	</div>
				<div class="title" ><%=title %>	</div>
				<div class="divingLine">
				</div>
			</div>
		</div>
	</div>
	
	<script>
	
	function goBack	(){
		var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/sharedDiary';
        document.body.appendChild(form);
        form.submit();
	}
	
	function goSharedDiary() {
	    var form = document.createElement('form');
	    form.method = 'POST';
	    form.action = '${pageContext.request.contextPath}/sharedDiaryImage';

	    var questionInput = document.createElement('input');
	    questionInput.type = 'hidden';
	    questionInput.name = 'question';
	    questionInput.value = '<%= title %>'; // 수정된 부분
	    form.appendChild(questionInput);

	    var UrlInput = document.createElement('input');
	    UrlInput.type = 'hidden';
	    UrlInput.name = 'imgUrl';
	    UrlInput.value = '<%= imgUrl %>'; // 수정된 부분
	    form.appendChild(UrlInput);

	    var dateInput = document.createElement('input');
	    dateInput.type = 'hidden';
	    dateInput.name = 'dateString';
	    dateInput.value = '<%= dateString %>'; // 수정된 부분
	    form.appendChild(dateInput);

	    document.body.appendChild(form);
	    form.submit();
	}

</script>
	

</body>
</html>