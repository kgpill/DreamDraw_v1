<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
    <%@ page import="javax.servlet.*" %>
    <%@ page import= "javax.servlet.http.HttpSession" %>
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/introduction/css/leftSide.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/introduction/css/introduction.css">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title></title>

    <script src="${pageContext.request.contextPath}/introduction/js/sidemenu.js"></script>
    <style>
        .bg {
            width: 100%;
            height: 100%;
            background: #522269;
            user-select: none;
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
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
        <div class="userArea"  onclick="javascript:goMain();" >
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


    <div class="title">"나의 꿈 일기"</div>
    <img src="${pageContext.request.contextPath}/introduction/img/dream.png" alt="Dream Image" class="dream">
    <div class="sleeping">
        <svg xmlns="http://www.w3.org/2000/svg" width="147" height="139" viewBox="0 0 147 139" fill="none">
            <path
                d="M71.932 138.655C37.3302 138.655 0 116.952 0 69.3276C0 21.7036 37.3302 0 71.932 0C91.1552 0 108.89 6.32506 122.036 17.859C136.299 30.5091 143.864 48.3681 143.864 69.3276C143.864 90.2871 136.299 108.022 122.036 120.672C108.89 132.206 91.0312 138.655 71.932 138.655Z"
                fill="url(#paint0_radial_138_232)" />
            <path
                d="M131.326 28.1155C137.936 38.7813 141.384 51.481 141.384 65.6069C141.384 86.5664 133.818 104.301 119.556 116.952C106.41 128.485 88.5508 134.935 69.4516 134.935C47.0535 134.935 23.5639 125.819 9.69843 106.484C23.0431 128.386 48.1448 138.655 71.932 138.655C91.0312 138.655 108.89 132.206 122.036 120.672C136.299 108.022 143.864 90.2871 143.864 69.3276C143.864 53.5273 139.561 39.4882 131.326 28.1155Z"
                fill="#EB8F00" />
            <path
                d="M54.5815 59.1581L54.3334 59.4061C54.1474 59.6294 53.9242 59.8402 53.7009 60.0262L52.8452 60.7332C52.4855 61.006 52.0763 61.3036 51.605 61.6013C51.1213 61.9113 50.6252 62.1966 50.1167 62.457C48.9881 63.0275 47.7851 63.412 46.5449 63.6228C45.9 63.7344 45.2551 63.7841 44.5978 63.7841H44.0149C43.8537 63.7965 43.6801 63.7965 43.5188 63.7841C43.3204 63.7841 42.9607 63.7096 42.6383 63.6724C42.0182 63.5608 41.3981 63.3996 40.7904 63.2136C40.2075 63.0151 39.637 62.7795 39.0789 62.5066C38.5704 62.2462 38.0743 61.961 37.5906 61.6509C36.8465 61.1672 36.1396 60.6215 35.4823 60.0138L34.701 59.2945L34.3909 58.9969C32.8034 57.5458 30.4098 57.459 28.7232 58.786C27.5202 59.7286 27.1357 61.3781 27.7806 62.7671L27.9542 63.1392C28.1155 63.4988 28.3015 63.8461 28.5123 64.1809C29.2441 65.4459 30.1494 66.5869 31.1912 67.6039C31.9229 68.3232 32.7166 68.9681 33.5724 69.5386C34.5521 70.2207 35.5939 70.8036 36.6977 71.2749C37.8883 71.8082 39.1409 72.2299 40.4183 72.5151C41.1004 72.6391 41.7329 72.7632 42.5639 72.8376C42.9483 72.8376 43.4072 72.912 43.6056 72.912H44.5606C45.9496 72.8872 47.3387 72.7508 48.7029 72.4779C49.9803 72.1927 51.2329 71.771 52.4235 71.2377C53.5149 70.7664 54.5691 70.1835 55.5488 69.5014C56.3922 68.9309 57.1859 68.286 57.9176 67.5667C58.5625 66.9962 59.1578 66.3885 59.7035 65.7312L60.2864 64.9126L60.7825 64.1189C60.9686 63.8213 61.1298 63.4988 61.2662 63.1764C61.353 62.9655 61.4026 62.8663 61.4026 62.8663C62.1467 61.0928 61.3034 59.0465 59.5299 58.3023C59.4059 58.2527 59.2819 58.2031 59.1578 58.1783C57.5704 57.5954 55.7969 57.9799 54.5815 59.1581Z"
                fill="#422B0D" />
            <path
                d="M110.267 59.1579L110.019 59.4059C109.833 59.6292 109.609 59.84 109.386 60.026L108.531 60.733C108.171 61.0058 107.762 61.3034 107.29 61.6011C106.807 61.9111 106.311 62.1964 105.802 62.4568C105.256 62.7297 104.686 62.9653 104.103 63.1638C103.495 63.3498 102.875 63.511 102.243 63.6226C101.598 63.7343 100.953 63.7839 100.296 63.7839H99.7126C99.539 63.7963 99.3778 63.7963 99.2042 63.7839C99.0181 63.7839 98.6585 63.7095 98.336 63.6722C97.7035 63.5606 97.0834 63.3994 96.4757 63.2134C95.8804 63.0025 95.3099 62.7421 94.7518 62.4568C94.2433 62.1964 93.7472 61.9111 93.2636 61.6011C92.5194 61.1174 91.8125 60.5717 91.1552 59.964L90.3739 59.2447L90.0638 58.9471C88.4764 57.496 86.0828 57.4092 84.3961 58.7362C83.1683 59.6788 82.759 61.3655 83.4287 62.7669C83.4287 62.7669 83.4287 62.9033 83.6147 63.139C83.776 63.4986 83.962 63.8459 84.1604 64.1807C85.4379 66.3263 87.1617 68.1494 89.2329 69.5384C90.2127 70.2205 91.2544 70.8034 92.3458 71.2747C93.5612 71.8204 94.8262 72.2297 96.1284 72.5149C96.8106 72.6389 97.4431 72.763 98.274 72.8374C98.6585 72.8374 99.1049 72.9118 99.3034 72.9118H100.271C101.66 72.887 103.036 72.7506 104.401 72.4777C105.703 72.1925 106.968 71.7832 108.183 71.2375C109.275 70.7662 110.316 70.1833 111.296 69.5012C112.152 68.9307 112.946 68.2858 113.677 67.5665C114.285 66.996 114.856 66.3883 115.376 65.731L115.972 64.9125L116.468 64.1187C116.654 63.8211 116.815 63.4986 116.952 63.1762C117.038 62.9653 117.088 62.8661 117.088 62.8661C117.832 61.0926 116.989 59.0463 115.215 58.3021C115.091 58.2525 114.967 58.2029 114.843 58.1781C113.256 57.5952 111.482 57.9797 110.267 59.1579Z"
                fill="#422B0D" />
            <path
                d="M131.189 120.151C157.593 114.31 149.557 69.1788 104.264 75.1318C96.4013 76.1735 88.1415 81.3328 82.2505 86.5293C80.8119 87.7695 81.4444 90.2499 83.3667 90.1135C102.255 88.8236 101.697 126.662 131.189 120.151Z"
                fill="#4FC3F7" />
            <path
                d="M132.764 83.7264C133.521 84.3713 134.091 85.1898 134.438 86.1076C134.786 87.0377 134.637 88.0671 134.054 88.8732C133.173 89.977 131.574 90.1134 130.123 89.915C126.241 89.5305 122.508 88.2779 119.171 86.2688C117.274 85.1278 115.042 83.1683 115.562 80.6506C115.922 78.9764 117.559 78.5795 119.072 78.5547C124.108 78.5547 128.982 80.3902 132.764 83.7264Z"
                fill="#B3E5FC" />
            <path
                d="M37.2558 38.7811H37.4171C40.0711 38.161 39.9719 34.1675 36.9458 34.2667C34.5026 34.3907 32.0966 34.8868 29.8022 35.7302C23.626 37.9625 18.5287 42.4893 15.5894 48.3679C15.0561 49.5089 15.5522 50.8731 16.6932 51.394C17.7102 51.8652 18.9132 51.5304 19.5457 50.6126C23.936 44.7713 30.1867 40.6042 37.2558 38.7811Z"
                fill="#422B0D" />
            <path
                d="M106.521 38.7812H106.36C105.12 38.6324 104.227 37.5162 104.363 36.2636C104.5 35.0358 105.604 34.1552 106.831 34.2669C109.275 34.3909 111.668 34.887 113.963 35.7303C120.164 37.9627 125.273 42.477 128.237 48.368C128.771 49.509 128.275 50.8732 127.134 51.3941C126.117 51.8654 124.914 51.5305 124.281 50.6128C119.878 44.7714 113.615 40.5919 106.521 38.7812Z"
                fill="#422B0D" />
            <path
                d="M62.1344 114.471C57.3844 114.384 53.6018 110.453 53.6886 105.703C53.7134 104.103 54.1971 102.54 55.0652 101.201C58.9099 95.2477 64.9869 92.1472 72.4281 92.1472C79.8694 92.1472 85.9464 95.2477 89.791 101.201C91.5149 103.805 91.6513 107.141 90.1631 109.882C88.6872 112.635 85.8472 114.397 82.7218 114.471C81.7421 114.496 80.7747 114.335 79.8694 113.975C77.4758 113.144 74.9582 112.722 72.4281 112.735C69.8981 112.71 67.3805 113.132 64.9869 113.975C64.0691 114.31 63.1018 114.483 62.1344 114.471Z"
                fill="#422B0D" />
            <defs>
                <radialGradient id="paint0_radial_138_232" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse"
                    gradientTransform="translate(71.932 69.3275) scale(70.6418)">
                    <stop offset="0.5" stop-color="#FDE030" />
                    <stop offset="0.92" stop-color="#F7C02B" />
                    <stop offset="1" stop-color="#F4A223" />
                </radialGradient>
            </defs>
        </svg>
    </div>
    <div class="coment1">꿈속에서 일어나는 일들을 재현해 볼 수 있다면 어떨까요?</div>
    <img src="${pageContext.request.contextPath}/introduction/img/whale.png" alt="Whale Image" class="whale">
    <div class="coment2">정말 비현실적이기도 하고</div>
    <img src="${pageContext.request.contextPath}/introduction/img/ghost.png" alt="Ghost Image" class="ghost">
    <div class="coment3">가끔은 무섭기도 하고</div>
    <img src="${pageContext.request.contextPath}/introduction/img/love2.png" alt="Love Image" class="love">
    <div class="coment4">때로는 달콤하기도 하면서</div>
    <img src="${pageContext.request.contextPath}/introduction/img/sky.png" alt="Sky Image" class="sky">
    <div class="coment5">짜릿한 모든 순간들을 말이에요!</div>
    <img src="${pageContext.request.contextPath}/introduction/img/diary.png" alt="Diary Image" class="diary">
    <div class="coment6">꿈속 세상을 사진으로 정리해서 보관할 수 있다면 정말 환상적일 거예요.</div>
    <img src="${pageContext.request.contextPath}/introduction/img/drawing.png" alt="Drawing Image" class="drawing">
    <div class="coment7">이제 상상 속에서 벗어나 여러분들의<br>꿈속 세상을 나만의 꿈 일기로 저장해보세요.</div>
    <img src="${pageContext.request.contextPath}/introduction/img/sotong.png" alt="Comunication Image" class="sotong">
    <div class="coment8">그리고 꿈 이야기를 친구들과 공유해보세요.</div>
    
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