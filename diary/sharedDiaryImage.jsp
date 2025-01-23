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
    				<img  src="<%=request.getAttribute("Url") %>"  alt="Generated Image">
    					<div class="overlay">
            			<div class="overlay-text" onclick="handleImageClick()">이미지 공유</div>
            			</div>
        		</div>
			</div>
<div class="explanation">
    <h1><%=request.getAttribute("title") %></h1>
</div>
        </div>
    
     
    
        <script>
        document.getElementById('closeButton').addEventListener('click', function() {
        	// 폼 엘리먼트 생성
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/sharedDiary';  // 실제 서블릿 URL로 변경
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
    
    

    
    
</script>
    
</body>
</html>