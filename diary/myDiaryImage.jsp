<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
    <%@ page import="javax.servlet.*" %>
    <%@ page import= "javax.servlet.http.HttpSession" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
    <%
    // 세션에서 사용자 정보를 가져옴
    session = request.getSession();	
    String userEmail = (String) session.getAttribute("userEmail");
    String userName = (String) session.getAttribute("userName");
%>

<%
String dateString = (String) request.getAttribute("dateString");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/dreamdraw?serverTimezone=UTC";
    conn = DriverManager.getConnection(url, "root", "0821");
    stmt = conn.createStatement();

        // 쿼리 작성
        String sql = "SELECT imgUrl, question, email FROM images WHERE email = ? AND date = ?";
        // Prepared statement를 사용하여 쿼리 실행
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, userEmail);
        psmt.setString(2, dateString); // 사용자의 이메일을 추가
        rs = psmt.executeQuery();

        // 결과 확인 및 JSP 페이지에 전달
        if (rs.next()) {
        	String imgUrl = request.getContextPath()+ rs.getString("imgUrl");
            System.out.println("경로: " +imgUrl);
            String question = rs.getString("question");
            String email = rs.getString("email");
            request.setAttribute("imageurl", imgUrl);
            request.setAttribute("question", question);
            request.setAttribute("email", email);
            
        } else {
        	String imgUrl =  request.getContextPath() + "/nullImage.png";
        	request.setAttribute("imageurl", imgUrl);
            request.setAttribute("question", "등록된 일기가 없어요ㅠㅠ");
            System.out.println("경로: " + imgUrl);
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
    <meta charset="utf-8" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/diary/css/leftSide.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/diary/css/diary2.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/diary/css/popup.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/diary/css/sharedBox.css">
    <style>
        .bg {
            width: 100%;
            height: 100%;
            background: #522269;
            display: flex;
            user-select: none;
        }
    </style>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="${pageContext.request.contextPath}/diary/js/sidemenu.js"></script>
    <script src="${pageContext.request.contextPath}/diary/js/blur.js"></script>
</head>
<body class="bg">
    <!--사이드 박스 영역-->
  <div class="sideBox">   
        <!--토글 버튼 -->
        <div class="sidebarToggle" onclick="toggleSidebar()">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 30 30">
                <polygon points="30,0 0,15 30,30" fill="#FFF"/>
            </svg>
        </div>     
    <!--사용자 계정 영역-->
        <div class="userArea"  onclick="javascript:goMain();">
           <% if (userEmail != null && userName != null) { %>
            <div class="userIcon">
                 <svg xmlns="http://www.w3.org/2000/svg" width="37" height="31" viewBox="0 0 37 31" fill="none">
                        <path
                            d="M18.5 0C13.4125 0 9.25 4.34 9.25 9.6875C9.25 15.035 13.4125 19.375 18.5 19.375C23.5875 19.375 27.75 15.035 27.75 9.6875C27.75 4.34 23.5875 0 18.5 0ZM8.83375 19.375C3.93125 19.5688 0 22.94 0 27.125V31H37V27.125C37 22.94 33.115 19.5688 28.1663 19.375C25.6688 21.7388 22.2463 23.25 18.5 23.25C14.7537 23.25 11.3313 21.7388 8.83375 19.375Z"
                            fill="white" />
            </div>
            <div class="name"><%= userName %>님</div>
            <div class="email"><%= userEmail %></div>
            <div class= "logout"  onclick="javascript: logout();"> 로그아웃 </div> <!--  이거 추가할 건데 -->
        <% } else { %>
            <!-- 로그인 되어 있지 않을 때의 내용 -->
            <a href="${pageContext.request.contextPath}/login/login.html">
                <div class="userIcon">
                    <!-- 로그인 아이콘 이미지 -->
                </div>
                <div class="name">로그인이<br>필요합니다</div>
                <div class="email"></div>
            </a>
        <% } %>
        </div>

         <!--메뉴 영역-->
        <ul>
            <li class="sideText">
                <svg xmlns="http://www.w3.org/2000/svg" width="37" height="37" viewBox="0 0 36 36" fill="none">
                    <path
                        d="M18 34C26.8365 34 34 26.8365 34 18C34 9.16344 26.8365 2 18 2C9.16344 2 2 9.16344 2 18C2 26.8365 9.16344 34 18 34Z"
                        stroke="white" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                    <path d="M13.2 13.2C13.2 7.59994 22 7.59999 22 13.2C22 17.2 18 16.3998 18 21.1998" stroke="white"
                        stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                    <path d="M18 27.616L18.0163 27.5982" stroke="white" stroke-width="4" stroke-linecap="round"
                        stroke-linejoin="round" />
                </svg>
                <a onclick="javascript:goIntroduction();">&nbsp;&nbsp;일기란?</a>
            </li>
            <li class="sideText">
                <svg xmlns="http://www.w3.org/2000/svg" width="37" height="37" viewBox="0 0 31 38" fill="none">
                    <path
                        d="M27.6101 18.9662V8.35981C27.6101 8.08983 27.5089 7.83091 27.3289 7.63999L22.2891 2.29816C22.109 2.10724 21.8648 2 21.6101 2H2.96038C2.42998 2 2 2.45576 2 3.01797V34.9143C2 35.4766 2.42998 35.9323 2.96038 35.9323H13.2044"
                        stroke="white" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                    <path d="M8.40254 15.5729H21.2076M8.40254 8.78647H14.8051M8.40254 22.3594H13.2044" stroke="white"
                        stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                    <path
                        d="M24.3354 27.3464L25.936 25.6498C26.6369 24.9069 27.7734 24.9069 28.4743 25.6498C29.1752 26.3927 29.1752 27.5973 28.4743 28.3403L26.8737 30.0369M24.3354 27.3464L19.5477 32.4212C19.3078 32.6755 19.1503 33.0041 19.0981 33.3594L18.7097 36L21.2007 35.5884C21.5361 35.5329 21.8459 35.366 22.0859 35.1117L26.8737 30.0369M24.3354 27.3464L26.8737 30.0369"
                        stroke="white" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                    <path d="M21.2075 2V7.76849C21.2075 8.3307 21.6375 8.78646 22.1679 8.78646H27.6101" stroke="white"
                        stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
                <a onclick="javascript:goDirection();">&nbsp;&nbsp;꿈 일기 사용법</a> 
            </li>
            <li class="sideText">
                <svg xmlns="http://www.w3.org/2000/svg" width="37" height="37" viewBox="0 0 33 35" fill="none">
                    <path d="M3 17.5H16.5M16.5 17.5H30M16.5 17.5V3M16.5 17.5V32" stroke="white" stroke-width="6"
                        stroke-linecap="round" stroke-linejoin="round" />
                </svg>
                <a onclick="javascript:goMain();">&nbsp;&nbsp;오늘의 꿈 입력</a> 
            </li>
            <li class="sideText">
                <svg xmlns="http://www.w3.org/2000/svg" width="37" height="37" viewBox="0 0 45 34" fill="none">
                    <path
                        d="M22.5 2C11.3182 2 11.3182 9.44681 11.3182 13.1702C8.21212 13.1702 2 15.0319 2 22.4787C2 29.9255 8.21212 31.7872 11.3182 31.7872H33.6818C36.7879 31.7872 43 29.9255 43 22.4787C43 15.0319 36.7879 13.1702 33.6818 13.1702C33.6818 9.44681 33.6818 2 22.5 2Z"
                        stroke="white" stroke-width="4" stroke-linejoin="round" />
                </svg>
                <a onclick="javascript:goDiary();">&nbsp;&nbsp;나의 꿈 일기장</a> 
            </li>
            <li class="sideText">
               <svg xmlns="http://www.w3.org/2000/svg" width="37" height="37" viewBox="0 0 112 110" fill="none">
                 <path d="M0 99.6875C0 105.381 5.375 110 12 110H100C106.625 110 112 105.381 112 99.6875V41.25H0V99.6875ZM80 57.5781C80 56.1602 81.35 55 83 55H93C94.65 55 96 56.1602 96 57.5781V66.1719C96 67.5898 94.65 68.75 93 68.75H83C81.35 68.75 80 67.5898 80 66.1719V57.5781ZM80 85.0781C80 83.6602 81.35 82.5 83 82.5H93C94.65 82.5 96 83.6602 96 85.0781V93.6719C96 95.0898 94.65 96.25 93 96.25H83C81.35 96.25 80 95.0898 80 93.6719V85.0781ZM48 57.5781C48 56.1602 49.35 55 51 55H61C62.65 55 64 56.1602 64 57.5781V66.1719C64 67.5898 62.65 68.75 61 68.75H51C49.35 68.75 48 67.5898 48 66.1719V57.5781ZM48 85.0781C48 83.6602 49.35 82.5 51 82.5H61C62.65 82.5 64 83.6602 64 85.0781V93.6719C64 95.0898 62.65 96.25 61 96.25H51C49.35 96.25 48 95.0898 48 93.6719V85.0781ZM16 57.5781C16 56.1602 17.35 55 19 55H29C30.65 55 32 56.1602 32 57.5781V66.1719C32 67.5898 30.65 68.75 29 68.75H19C17.35 68.75 16 67.5898 16 66.1719V57.5781ZM16 85.0781C16 83.6602 17.35 82.5 19 82.5H29C30.65 82.5 32 83.6602 32 85.0781V93.6719C32 95.0898 30.65 96.25 29 96.25H19C17.35 96.25 16 95.0898 16 93.6719V85.0781ZM100 13.75H88V3.4375C88 1.54688 86.2 0 84 0H76C73.8 0 72 1.54688 72 3.4375V13.75H40V3.4375C40 1.54688 38.2 0 36 0H28C25.8 0 24 1.54688 24 3.4375V13.75H12C5.375 13.75 0 18.3691 0 24.0625V34.375H112V24.0625C112 18.3691 106.625 13.75 100 13.75Z" fill="#ECECEC"/>
            </svg>
               <a onclick="javascript:goSharing();">&nbsp;공유 일기</a>
            </li>
        </ul>
    </div>
    
    
    <div id="blurContainer">

    <div class="background">
        <div class="leftArrow2" onclick="javascript: leftArrow();" >
            <svg xmlns="http://www.w3.org/2000/svg" width="58" height="92" viewBox="0 0 58 92" fill="none">
                <path
                    d="M57.2128 6.19933V85.8008C57.2128 91.3127 49.905 94.073 45.6312 90.1755L1.98696 50.3748C-0.66232 47.9588 -0.66232 44.0413 1.98696 41.6253L45.6312 1.8246C49.905 -2.07313 57.2128 0.687448 57.2128 6.19933Z"
                    fill="#FFE786" />
            </svg>
        </div>
        <div class="rightArrow2"  onclick="javascript: rightArrow();">
            <svg xmlns="http://www.w3.org/2000/svg" width="57" height="92" viewBox="0 0 57 92" fill="none">
                <path
                    d="M0 85.8007V6.19919C0 0.687311 7.28056 -2.07296 11.5385 1.82446L55.0204 41.6252C57.6599 44.0412 57.6599 47.9587 55.0204 50.3747L11.5385 90.1754C7.28056 94.0731 0 91.3126 0 85.8007Z"
                    fill="#FFE786" />
            </svg>
        </div>
        
        
            <div class="dates"><%=request.getAttribute("dateString") %></div>
            <div class="instagram">
                <svg xmlns="http://www.w3.org/2000/svg" width="34" height="34" viewBox="0 0 34 34" fill="none">
                    <path
                        d="M23.9172 2H10.0829C5.61884 2 2 5.61884 2 10.0829V23.9171C2 28.3812 5.61884 32 10.0829 32H23.9171C28.3812 32 32 28.3812 32 23.9171V10.0829C32.0001 5.61884 28.3812 2 23.9172 2Z"
                        stroke="#D9D9D9" stroke-width="3" stroke-miterlimit="10" />
                    <path
                        d="M17.0002 24.2414C20.9995 24.2414 24.2416 20.9994 24.2416 17C24.2416 13.0007 20.9995 9.75864 17.0002 9.75864C13.0009 9.75864 9.75879 13.0007 9.75879 17C9.75879 20.9994 13.0009 24.2414 17.0002 24.2414Z"
                        stroke="#D9D9D9" stroke-width="3" stroke-miterlimit="10" />
                    <path
                        d="M25.7929 9.75869C26.65 9.75869 27.3447 9.06395 27.3447 8.20695C27.3447 7.34995 26.65 6.65521 25.7929 6.65521C24.9359 6.65521 24.2412 7.34995 24.2412 8.20695C24.2412 9.06395 24.9359 9.75869 25.7929 9.75869Z"
                        fill="#D9D9D9" />
                </svg>
            </div>
            <button class="x" id="closeButton">
                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
                    <path
                        d="M21.6773 20.1217C21.7796 20.2238 21.8607 20.3451 21.9161 20.4786C21.9714 20.6121 22 20.7552 22 20.8997C22 21.0442 21.9716 21.1873 21.9163 21.3208C21.8611 21.4543 21.78 21.5756 21.6778 21.6778C21.5756 21.78 21.4543 21.8611 21.3208 21.9163C21.1873 21.9716 21.0442 22 20.8997 22C20.7552 22 20.6121 21.9714 20.4786 21.9161C20.3451 21.8607 20.2238 21.7796 20.1217 21.6773L10.9995 12.5551L1.8773 21.6773C1.67096 21.8834 1.39125 21.9991 1.09964 21.999C0.808022 21.9989 0.528378 21.883 0.322177 21.6768C0.115975 21.4706 9.14952e-05 21.191 5.41563e-08 20.8994C-9.13869e-05 20.6078 0.115617 20.3281 0.321689 20.1217L9.44391 10.9995L0.321689 1.8773C0.115617 1.67096 -9.13869e-05 1.39125 5.41563e-08 1.09964C9.14952e-05 0.808022 0.115975 0.528378 0.322177 0.322177C0.528378 0.115975 0.808022 9.14952e-05 1.09964 5.41563e-08C1.39125 -9.13869e-05 1.67096 0.115617 1.8773 0.321689L10.9995 9.44391L20.1217 0.321689C20.3281 0.115617 20.6078 -9.13869e-05 20.8994 5.41563e-08C21.191 9.14952e-05 21.4706 0.115975 21.6768 0.322177C21.883 0.528378 21.9989 0.808022 21.999 1.09964C21.9991 1.39125 21.8834 1.67096 21.6773 1.8773L12.5551 10.9995L21.6773 20.1217Z"
                        fill="#D9D9D9" />
                </svg>
            </button>
            <div class="image-container">
            	<div class="image">
    				<img  src="<%=request.getAttribute("imageurl") %>"  alt="Generated Image">
    					<div class="overlay">
            			<div class="overlay-text" onclick="handleImageClick()">이미지 공유</div>
            			</div>
        		</div>
			</div>
<div class="explanation">
    <h1><%=request.getAttribute("question") %></h1>
</div>
        </div>
    </div>
    
    <div class="box">
      <div class="dreamRegisterText">나의 꿈 등록</div>
      <div class="x">
        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
          <path d="M21.6773 20.1217C21.7796 20.2238 21.8607 20.3451 21.9161 20.4786C21.9714 20.6121 22 20.7552 22 20.8997C22 21.0442 21.9716 21.1873 21.9163 21.3208C21.8611 21.4543 21.78 21.5756 21.6778 21.6778C21.5756 21.78 21.4543 21.8611 21.3208 21.9163C21.1873 21.9716 21.0442 22 20.8997 22C20.7552 22 20.6121 21.9714 20.4786 21.9161C20.3451 21.8607 20.2238 21.7796 20.1217 21.6773L10.9995 12.5551L1.8773 21.6773C1.67096 21.8834 1.39125 21.9991 1.09964 21.999C0.808022 21.9989 0.528378 21.883 0.322177 21.6768C0.115975 21.4706 9.14952e-05 21.191 5.41563e-08 20.8994C-9.13869e-05 20.6078 0.115617 20.3281 0.321689 20.1217L9.44391 10.9995L0.321689 1.8773C0.115617 1.67096 -9.13869e-05 1.39125 5.41563e-08 1.09964C9.14952e-05 0.808022 0.115975 0.528378 0.322177 0.322177C0.528378 0.115975 0.808022 9.14952e-05 1.09964 5.41563e-08C1.39125 -9.13869e-05 1.67096 0.115617 1.8773 0.321689L10.9995 9.44391L20.1217 0.321689C20.3281 0.115617 20.6078 -9.13869e-05 20.8994 5.41563e-08C21.191 9.14952e-05 21.4706 0.115975 21.6768 0.322177C21.883 0.528378 21.9989 0.808022 21.999 1.09964C21.9991 1.39125 21.8834 1.67096 21.6773 1.8773L12.5551 10.9995L21.6773 20.1217Z" fill="#D9D9D9"/>
        </svg>
      </div>

      <input id="anonymous"  type="checkbox" class="anonymousBox">
      <div class="anonymous">익명</div>
      <input type="text" id="title" placeholder="제목 입력" class="dreamTitle">
      <div class="titleLine">
         <svg xmlns="http://www.w3.org/2000/svg" width="435" height="2" viewBox="0 0 435 2" fill="none">
           <path d="M0 0.972046L434.501 0.972047" stroke="#3E3E3E"/>
         </svg>
      </div>
      <div class="registerButton"  onclick="javascript: sharedImage();">
         꿈 등록하기
      </div>
   </div>
	
     <script>
     
     function handleImageClick() {
         var overlay = document.querySelector('.overlay');
         var box = document.querySelector('.box');
         var blurContainer = document.getElementById('blurContainer'); // blur 효과를 적용할 부모 요소

         // Toggle the display of the overlay and box
         overlay.style.display = (overlay.style.display === '' || overlay.style.display === 'none') ? 'block' : 'none';
         box.style.display = (box.style.display === '' || box.style.display === 'none') ? 'block' : 'none';

         // Toggle the blur effect on the parent container
         blurContainer.classList.toggle('blur-background');
    }
     
    function sharedImage() {
    	// 폼 엘리먼트 생성
    	var form = document.createElement('form');
    	form.method = 'POST';
    	form.action = 'sharedImage';  // 실제 서블릿 URL로 변경

    	var inputDate = document.createElement('input');
    	inputDate.type = 'hidden';  // hidden 필드로 설정
    	inputDate.name = 'date';  // 파라미터 이름
    	inputDate.value = encodeURIComponent("<%=request.getAttribute("dateString") %>");   // 실제 값
    	form.appendChild(inputDate);
    	
    	var inputImageUrl = document.createElement('input');
    	inputImageUrl.type = 'hidden';
    	inputImageUrl.name = 'imageurl';
    	inputImageUrl.value = encodeURIComponent("<%= request.getAttribute("imageurl") %>");
    	form.appendChild(inputImageUrl);
    	
    	
    	var inputId = document.createElement('input');
    	inputId.type = 'hidden';
    	inputId.name = 'id';
    	inputId.value = encodeURIComponent("<%=request.getAttribute("email") %>");
    	form.appendChild(inputId);
    	
    	var inputTile = document.createElement('input');
    	inputTile.type = 'hidden';
    	inputTile.name = 'dreamTitle';
    	inputTile.value = encodeURIComponent(document.getElementById('title').value);
    	form.appendChild(inputTile);
    	
    	var inputAnanymous = document.createElement('input');
    	inputAnanymous.type = 'hidden';
    	inputAnanymous.name = 'anonymousBox';
    	inputAnanymous.value = encodeURIComponent(document.getElementById('anonymous').innerHTML);
    	form.appendChild(inputAnanymous);
    	
    	// 폼을 바디에 추가하고 서브밋
    	document.body.appendChild(form);
    	form.submit();
    }
</script>
        <script>
        document.getElementById('closeButton').addEventListener('click', function() {
        	// 폼 엘리먼트 생성
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/diary';  // 실제 서블릿 URL로 변경
            // 폼을 바디에 추가하고 서브밋	
            document.body.appendChild(form);
            form.submit();
        });
        
        function logout() {
       	 swal('LOGOUT','로그아웃하고 메인으로 이동합니다!!','success')
   	 .then(function(){
   		 var form = document.createElement('form');
   	        form.method = 'GET';
   	        form.action = '${pageContext.request.contextPath}/logout';  // 실제 서블릿 URL로 변경;

   	        // 폼을 바디에 추가하고 서브밋
   	        document.body.appendChild(form);
   	        form.submit();          
   })
       }
        function goDiary() {
            // 폼 엘리먼트 생성
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/diary';  // 실제 서블릿 URL로 변경
            // 폼을 바디에 추가하고 서브밋
            document.body.appendChild(form);
            form.submit();
        }
        </script>
        
        <script>
    function logout() {
    	 swal('LOGOUT','로그아웃하고 메인으로 이동합니다!!','success')
	 .then(function(){
		 var form = document.createElement('form');
	        form.method = 'GET';
	        form.action = '${pageContext.request.contextPath}/logout';  // 실제 서블릿 URL로 변경;

	        // 폼을 바디에 추가하고 서브밋
	        document.body.appendChild(form);
	        form.submit();          
})
    }
    
    function goMain() {
        // 폼 엘리먼트 생성
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/main';  // 실제 서블릿 URL로 변경
        // 폼을 바디에 추가하고 서브밋
        document.body.appendChild(form);
        form.submit();
    }
    
    function goIntroduction() {
        // 폼 엘리먼트 생성
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/introduction';  // 실제 서블릿 URL로 변경
        // 폼을 바디에 추가하고 서브밋
        document.body.appendChild(form);
        form.submit();
    }
    
    function goDirection() {
        // 폼 엘리먼트 생성
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/direction';  // 실제 서블릿 URL로 변경
        // 폼을 바디에 추가하고 서브밋
        document.body.appendChild(form);
        form.submit();
    }
    
    function goDiary() {
        // 폼 엘리먼트 생성
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/diary';  // 실제 서블릿 URL로 변경
        // 폼을 바디에 추가하고 서브밋
        document.body.appendChild(form);
        form.submit();
    }
    function goSharing(){
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/sharedDiary';
        document.body.appendChild(form);
        form.submit();
     }
    
    function formatDate(year, month, day) {
        return `${year}/${month}/${day}`;
    }

    function leftArrow() {
        var year = '<%=request.getAttribute("year") %>';
        var month = '<%=request.getAttribute("month") %>';
        var day = '<%=request.getAttribute("day") %>';
        var dayName = '<%=request.getAttribute("dayName") %>';

        // Date 객체 생성
        var currentDate = new Date(year, month - 1, day);

        // 이전 날짜 계산
        currentDate.setDate(currentDate.getDate() - 1);

        // 연도, 월, 일, 요일 추출
        var prevYear = currentDate.getFullYear();
        var prevMonth = currentDate.getMonth() + 1;
        var prevDay = currentDate.getDate();
        var prevDayName = new Intl.DateTimeFormat('en-US', { weekday: 'long' }).format(currentDate);

     // 이전 날짜가 해당 달의 첫 날짜보다 이전으로 가면 이전 달의 마지막 날짜로 이동
        if (prevDay === 0) {
            if (prevMonth === 1) {
                prevYear--;
                prevMonth = 12;
            } else {
                prevMonth--;
            }
            prevDay = new Date(prevYear, prevMonth, 0).getDate(); // 이전 달의 마지막 날짜
        }

        // 이전 날짜가 해당 년도의 첫 달의 첫 날짜보다 이전으로 가면 작년 12월 31일로 이동
        if (prevDay === 0 && prevMonth === 1) {
            prevYear--;
            prevMonth = 12;
            prevDay = new Date(prevYear, prevMonth, 0).getDate(); // 작년 12월 31일
        }

        // 폼 엘리먼트 생성
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/mydiary';

        // 데이터를 폼에 추가
        var yearInput = document.createElement('input');
        yearInput.type = 'hidden';
        yearInput.name = 'year';
        yearInput.value = encodeURIComponent(prevYear);
        form.appendChild(yearInput);

        var monthInput = document.createElement('input');
        monthInput.type = 'hidden';
        monthInput.name = 'month';
        monthInput.value = encodeURIComponent(prevMonth);
        form.appendChild(monthInput);

        var dayInput = document.createElement('input');
        dayInput.type = 'hidden';
        dayInput.name = 'day';
        dayInput.value = encodeURIComponent(prevDay);
        form.appendChild(dayInput);

        var dayNameInput = document.createElement('input');
        dayNameInput.type = 'hidden';
        dayNameInput.name = 'dayName';
        dayNameInput.value = encodeURIComponent(prevDayName);
        form.appendChild(dayNameInput);

        // 폼을 바디에 추가하고 서브밋
        document.body.appendChild(form);
        form.submit();
    }

    function rightArrow() {
        var year = '<%=request.getAttribute("year") %>';
        var month = '<%=request.getAttribute("month") %>';
        var day = '<%=request.getAttribute("day") %>';
        var dayName = '<%=request.getAttribute("dayName") %>';

        // Date 객체 생성
        var currentDate = new Date(year, month - 1, day);

        // 다음 날짜 계산
        currentDate.setDate(currentDate.getDate() + 1);

        // 연도, 월, 일, 요일 추출
        var nextYear = currentDate.getFullYear();
        var nextMonth = currentDate.getMonth() + 1;
        var nextDay = currentDate.getDate();
        var nextDayName = new Intl.DateTimeFormat('en-US', { weekday: 'long' }).format(currentDate);

     // 해당 달의 마지막 날짜로 조정
        var lastDayOfMonth = new Date(nextYear, nextMonth, 0).getDate();
        if (nextDay > lastDayOfMonth) {
            nextDay = 1;
            if (nextMonth === 12) {
                nextYear++;
                nextMonth = 1;
            } else {
                nextMonth++;
            }
        }

        // 해당 년도의 마지막 달의 마지막 날짜로 조정
        if (nextDay === 1 && nextMonth === 12) {
            nextYear++;
            nextMonth = 1;
            nextDay = 1;
        }

        // 폼 엘리먼트 생성
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/mydiary';

        // 데이터를 폼에 추가
        var yearInput = document.createElement('input');
        yearInput.type = 'hidden';
        yearInput.name = 'year';
        yearInput.value = encodeURIComponent(nextYear);
        form.appendChild(yearInput);

        var monthInput = document.createElement('input');
        monthInput.type = 'hidden';
        monthInput.name = 'month';
        monthInput.value = encodeURIComponent(nextMonth);
        form.appendChild(monthInput);

        var dayInput = document.createElement('input');
        dayInput.type = 'hidden';
        dayInput.name = 'day';
        dayInput.value = encodeURIComponent(nextDay);
        form.appendChild(dayInput);

        var dayNameInput = document.createElement('input');
        dayNameInput.type = 'hidden';
        dayNameInput.name = 'dayName';
        dayNameInput.value = encodeURIComponent(nextDayName);
        form.appendChild(dayNameInput);

        // 폼을 바디에 추가하고 서브밋
        document.body.appendChild(form);
        form.submit();
    }

    
    
</script>


</body>


</html>