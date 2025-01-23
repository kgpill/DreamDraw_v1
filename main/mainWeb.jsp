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
<%
    String openaiApiKey = "";
String karloApiKey = "";
%>
<!DOCTYPE html>
<html>

<head>
    <title>Web Project</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/main/css/leftSide.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/main/css/center.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/main/css/rightSide.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/main/css/popup.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/main/css/loading.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/main/css/createImage.css">

    <script src="${pageContext.request.contextPath}/main/js/sidemenu.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <style>
        .bg {
            background: #522269;
            overflow: hidden;
            width: 100%;
            height: 100%;
            user-select: none;
        }

    </style>
</head>

<body class="bg">
    <div id="load">
        <center>
            <div class="logo">
                <div class="loadingio-spinner-wedges-urwotppjau">
                    <div class="ldio-6uuui3j12f5">
                        <div>
                            <div>
                                <div></div>
                            </div>
                            <div>
                                <div></div>
                            </div>
                            <div>
                                <div></div>
                            </div>
                            <div>
                                <div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </center>
    </div>
    <!--사이드 박스 영역-->
    <div class="sideBox">   
        <!--토글 버튼 -->
        <div class="sidebarToggle" onclick="toggleSidebar()">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 30 30">
                <polygon points="30,0 0,15 30,30" fill="#FFF"/>
            </svg>
        </div>     
        <!--사용자 계정 영역-->
        <div class="userArea"  onclick="javascript:goMain(event);">
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
                <a onclick="javascript:goToMain();">&nbsp;&nbsp;오늘의 꿈 입력</a> 
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
               <a  onclick="javascript:goSharing();">&nbsp;공유 일기</a>
            </li>
        </ul>
    </div>

    <!--센터 영역-->
    <div class="center">
    <div class="moon">
        <svg xmlns="http://www.w3.org/2000/svg" width="267" height="269" viewBox="0 0 267 269" fill="none">
            <path
                d="M137 268.167H135.666C117.38 268.027 99.3052 264.216 82.5005 256.96C65.6958 249.703 50.4989 239.145 37.7997 225.904C14.2509 200.564 0.86476 167.345 0.224568 132.657C-0.415624 97.97 11.7355 64.2735 34.333 38.0709C48.8914 21.6535 67.1934 9.0383 87.6664 1.30921C90.0552 0.384244 92.6581 0.170712 95.1643 0.694113C97.6705 1.21751 99.974 2.45573 101.8 4.26088C103.491 5.99595 104.681 8.16056 105.245 10.5236C105.809 12.8866 105.724 15.3592 105 17.6775C97.6924 37.8151 96.2447 59.6321 100.826 80.5685C105.408 101.505 115.829 120.692 130.866 135.878C146.044 150.963 165.157 161.414 185.993 166.02C206.829 170.627 228.536 169.201 248.6 161.907C250.988 161.061 253.566 160.917 256.032 161.491C258.499 162.065 260.752 163.334 262.528 165.15C264.304 166.965 265.53 169.252 266.062 171.742C266.594 174.233 266.411 176.825 265.533 179.214C258.722 197.511 248.081 214.12 234.333 227.917C221.544 240.747 206.362 250.908 189.658 257.815C172.954 264.723 155.059 268.241 137 268.167Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="cloud1">
        <svg xmlns="http://www.w3.org/2000/svg" width="221" height="150" viewBox="0 0 221 150" fill="none">
            <path
                d="M185.64 65.1562C187.056 61.5737 187.85 57.6562 187.85 53.5714C187.85 35.8259 173.002 21.4286 154.7 21.4286C147.897 21.4286 141.544 23.4375 136.295 26.8527C126.73 10.7812 108.877 0 88.4 0C57.8744 0 33.15 23.9732 33.15 53.5714C33.15 54.4754 33.1845 55.3795 33.2191 56.2835C13.8816 62.8795 0 80.7589 0 101.786C0 128.404 22.2727 150 49.725 150H176.8C201.214 150 221 130.815 221 107.143C221 86.4174 205.806 69.1071 185.64 65.1562Z"
                fill="white" />
        </svg>
    </div>
    <div class="cloud2">
        <svg xmlns="http://www.w3.org/2000/svg" width="161" height="115" viewBox="0 0 161 115" fill="none">
            <path
                d="M90.5625 0C66.2113 0 44.8787 16.4833 40.25 38.3333C18.1125 38.3333 0 55.5833 0 76.6667C0 97.75 18.1125 115 40.25 115H130.812C147.516 115 161 102.158 161 86.25C161 73.7917 152.548 61.525 140.875 57.5V47.9167C140.875 21.4667 118.335 0 90.5625 0Z"
                fill="white" />
        </svg>
    </div>
    <div class="star1">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star2">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star3">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star4">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star5">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star6">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star7">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star8">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star9">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star10">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star11">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="star12">
        <svg xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29" fill="none">
            <path
                d="M20.905 24.9609C20.7146 24.9616 20.5268 24.9168 20.3574 24.8301L14.2859 21.6565L8.21438 24.8301C8.01723 24.9336 7.79494 24.9798 7.5728 24.9635C7.35065 24.9471 7.13756 24.8689 6.95773 24.7376C6.77791 24.6064 6.63858 24.4274 6.55557 24.221C6.47256 24.0146 6.44921 23.7892 6.48817 23.5702L7.67866 16.8783L2.77385 12.1238C2.62082 11.9714 2.51226 11.7802 2.45983 11.5708C2.4074 11.3614 2.41307 11.1417 2.47623 10.9352C2.54523 10.724 2.67215 10.5363 2.8426 10.3934C3.01305 10.2506 3.22019 10.1582 3.44052 10.127L10.2263 9.14043L13.2144 3.04285C13.3119 2.84189 13.4641 2.67241 13.6536 2.55383C13.8431 2.43524 14.0622 2.37234 14.2859 2.37234C14.5095 2.37234 14.7286 2.43524 14.9181 2.55383C15.1076 2.67241 15.2598 2.84189 15.3573 3.04285L18.3811 9.12855L25.1669 10.1151C25.3873 10.1464 25.5944 10.2387 25.7649 10.3815C25.9353 10.5244 26.0622 10.7121 26.1312 10.9234C26.1944 11.1298 26.2001 11.3495 26.1476 11.5589C26.0952 11.7683 25.9866 11.9595 25.8336 12.112L20.9288 16.8664L22.1193 23.5583C22.1618 23.7811 22.1395 24.0115 22.0552 24.2221C21.9708 24.4327 21.8278 24.6148 21.6431 24.7469C21.4275 24.8977 21.1679 24.973 20.905 24.9609Z"
                fill="#FFDD55" />
        </svg>
    </div>
    <div class="centertext">오늘은 어떤 꿈을 꾸셨나요?</div>

    <!--드롭영역-->
    <div id="categoryBar" ondrop="drop(event)" ondragover="dragover(event)">
        <div id="categoryText" ondragenter="dragenter(event)">&nbsp;감정 카테고리를 끌어다 놓으세요</div>
    </div>
    

    <!--텍스트 입력창-->
    <div id="inputBar">
        <div id="inputText">&nbsp;<input type="text" id="dreamInput" placeholder="입력해보세요"></div>
    </div>

    <!--이모션 박스 영역-->
    <div id="emotionBox" ondrop="drop(event)" ondragover="dragover(event)">
        감정카테고리
        <div id="emotion2" draggable="true" ondragstart="dragstart(event)" ondragend="dragend(event)" nameValue="슬픔">슬픔</div>
        <div id="emotion3" draggable="true" ondragstart="dragstart(event)" ondragend="dragend(event)" nameValue="초조함">초조함</div>
        <div id="emotion4" draggable="true" ondragstart="dragstart(event)" ondragend="dragend(event)" nameValue="무서움">무서움</div>
        <div id="emotion5" draggable="true" ondragstart="dragstart(event)" ondragend="dragend(event)" nameValue="화남">화남</div>
        <div id="emotion6" draggable="true" ondragstart="dragstart(event)" ondragend="dragend(event)" nameValue="신기함">신기함</div>
        <div id="emotion1" draggable="true" ondragstart="dragstart(event)" ondragend="dragend(event)" nameValue="기쁨">기쁨</div>
    </div>

    <!--이미지 생성 버튼-->
    <div class="createImage">
        <button id="imageButton" class="createImage" onclick="javascript:askQuestion();">이미지 생성</button>
    </div>

    <div id="blurContainer">
        <center>
            <div class="logo">
                <div class="loadingio-spinner-wedges-urwotppjau">
                    <div class="ldio-6uuui3j12f5">
                        <div>
                            <div>
                                <div></div>
                            </div>
                            <div>
                                <div></div>
                            </div>
                            <div>
                                <div></div>
                            </div>
                            <div>
                                <div></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="createImageText">
                    Create image...
                </div>
            </div>	
        </center>

        <button class="x" id="closeButton">
            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
                <path
                    d="M21.6773 20.1217C21.7796 20.2238 21.8607 20.3451 21.9161 20.4786C21.9714 20.6121 22 20.7552 22 20.8997C22 21.0442 21.9716 21.1873 21.9163 21.3208C21.8611 21.4543 21.78 21.5756 21.6778 21.6778C21.5756 21.78 21.4543 21.8611 21.3208 21.9163C21.1873 21.9716 21.0442 22 20.8997 22C20.7552 22 20.6121 21.9714 20.4786 21.9161C20.3451 21.8607 20.2238 21.7796 20.1217 21.6773L10.9995 12.5551L1.8773 21.6773C1.67096 21.8834 1.39125 21.9991 1.09964 21.999C0.808022 21.9989 0.528378 21.883 0.322177 21.6768C0.115975 21.4706 9.14952e-05 21.191 5.41563e-08 20.8994C-9.13869e-05 20.6078 0.115617 20.3281 0.321689 20.1217L9.44391 10.9995L0.321689 1.8773C0.115617 1.67096 -9.13869e-05 1.39125 5.41563e-08 1.09964C9.14952e-05 0.808022 0.115975 0.528378 0.322177 0.322177C0.528378 0.115975 0.808022 9.14952e-05 1.09964 5.41563e-08C1.39125 -9.13869e-05 1.67096 0.115617 1.8773 0.321689L10.9995 9.44391L20.1217 0.321689C20.3281 0.115617 20.6078 -9.13869e-05 20.8994 5.41563e-08C21.191 9.14952e-05 21.4706 0.115975 21.6768 0.322177C21.883 0.528378 21.9989 0.808022 21.999 1.09964C21.9991 1.39125 21.8834 1.67096 21.6773 1.8773L12.5551 10.9995L21.6773 20.1217Z"
                    fill="#D9D9D9" />
            </svg>
        </button>

    </div>

    <script src="${pageContext.request.contextPath}/main/js/blur.js"></script>
    
    

    <script>
        const loading_page = document.getElementById("load");
        window.onload = function () {
            loading_page.style.display = 'none';
        }
    </script>
    
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        document.getElementById('closeButton').addEventListener('click', function () {
        	swal('이미지 생성을 취소합니다!!','메인 화면으로 돌아갑니다!!','error')
       	 .then(function(){
       		location.reload();             
       })
        });
    </script>
    
    <script>
 // 전역 변수로 선언
    var nameValue;
 
    function dragover(wpevent) {
        wpevent.preventDefault();
    }

    function dragstart(wpevent) {
        wpevent.dataTransfer.effectAllowed = 'move';
        wpevent.dataTransfer.setData("Text", wpevent.target.id);
    }

    function dragend(wpevent) {
        wpevent.dataTransfer.clearData("Text");
    }

    function dragenter(wpevent){
        const categoryText = document.querySelector("#categoryText");
        categoryText.style.display = "none"
    }


    function drop(wpevent) {
        wpevent.preventDefault();
        var item = wpevent.dataTransfer.getData("Text");

        // 추가하기
        var draggedElement = document.getElementById(item);

        // 가져온 nameValue 저장
        nameValue = draggedElement.getAttribute("nameValue");

        // 카테고리바에 대한 drop 이벤트 처리
        if (wpevent.target.id === "categoryBar") {
            if (wpevent.target.childElementCount >= 2) {
                alert("하나의 감정만 선택해주세요!");
                return;
            }

            wpevent.target.appendChild(draggedElement); // categoryBar에 자식 요소로 추가
        }

        if (wpevent.target.id === "emotionBox") {
            wpevent.target.appendChild(draggedElement);
        }

        // categoryBar에 자식 요소가 없을 때 categoryText를 표시
        if (document.getElementById("categoryBar").childElementCount === 1) {
            document.getElementById("categoryText").style.display = "block";
        }

        // nameValue 변수 활용
        console.log("Dropped nameValue:", nameValue);
        

        wpevent.stopPropagation();
    }


const apiUrl = 'https://api.openai.com/v1/chat/completions';
const karloApiUrl = 'https://api.kakaobrain.com/v2/inference/karlo/t2i';

// 대화 데이터
const conversation = {};

// 질문 입력 함수
async     function askQuestion() {
	// 버퍼링 함수 넣고,
	event.preventDefault();  // 기본 동작 막기
	// nameValue 확인
    if (!nameValue) {
    	swal('감정 카테고리를 선택해주세요!!','메인 화면으로 돌아갑니다!!','error')
      	 .then(function(){
      		location.reload();             
      })
    }
        const userQuestionInput = document.getElementById('dreamInput');
		const userInputValue = userQuestionInput.value + " / 카테고리 : " + nameValue;
        console.log(userInputValue);

       if (userInputValue) {
           await callOpenAIChatAPI(userInputValue);
       } else {
           console.error('질문을 입력하세요.');
       }
        
    }

	// API 호출 함수
	async function callOpenAIChatAPI(conversation) {
	    try {
	        const response = await fetch(apiUrl, {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json',
	                'Authorization': `Bearer <%= openaiApiKey %>`,
	            },
	            body: JSON.stringify({
	                model: 'gpt-3.5-turbo',
	                messages: [{
	                    role: 'system',
	                    content: 'You are a helpful assistant.',
	                }, {
	                    role: 'user',
	                    content: conversation + "라는 글에서 영어로 해석해서 단어만 추출해줘. 대답은 한글로 해줘.",
	                }],
	            }),
	        });
	
	        if (!response.ok) {
	        	 const errorMessage = `HTTP error! Status: ${response.status}`;
	             console.error('OpenAI API error:', errorMessage);
	             throw new Error(errorMessage);
	        }
	        
	
	        const result = await response.json();
	        const mixedString = result.choices[0].message.content;
	
	        // 정규식을 사용하여 문자열에서 영어만 추출
	        const englishOnly = mixedString.match(/[a-zA-Z]+/g).join(' ');
	        console.log(englishOnly);
	        await t2i(englishOnly, conversation);
	    } catch (error) {
	        console.error('OpenAI API error:', error);
	    }
	}
    
    // 이미지 생성하기 요청
async function t2i(prompt, userQuestion) {
    try {
    	console.log("실행 중");
        const response = await fetch(karloApiUrl, {
            method: 'POST',
            headers: {
                'Authorization': `KakaoAK <%=karloApiKey%>`,
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                'prompt': prompt,
            }),
        });

        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
        const responseData = await response.json();
        const imageUrl = responseData.images[0].image;
        console.log('Image URL:', imageUrl);
       await  submitForm(userQuestion, imageUrl);
    } catch (error) {
        console.error('Error in t2i:', error);
    }
}


async function submitForm(question, imageUrl) {
    
    	// 폼 엘리먼트 생성
var form = document.createElement('form');
form.method = 'POST';
form.action = '${pageContext.request.contextPath}/askgpt'; 

var inputQuestion = document.createElement('input');
inputQuestion.type = 'hidden'; 
inputQuestion.name = 'question'; 
inputQuestion.value = encodeURIComponent(question);
form.appendChild(inputQuestion);

let today = new Date();   

let year = today.getFullYear(); // 년도
let month = today.getMonth() + 1;  // 월
let date = today.getDate();  // 날짜
let day = today.getDay();  // 요일
date = year + '/' + month + '/' + date
switch(day) {
	case 0:
	day = "Sunday"
	break;
	case 1:
	day = "Monday"
	break;
	case 2:
	day = "Tuesday"
	break;
	case 3:
	day = "Wednesday"
	break;
	case 4:
	day = "Thursday"
	break;
	case 5:
	day = "Friday"
	break;
	case 6:
	day = "Saturday"
	break;
	default:
	break;
}

var inputQuestion = document.createElement('input');
inputQuestion.type = 'hidden';
inputQuestion.name = 'date';  
inputQuestion.value = encodeURIComponent(date); 
form.appendChild(inputQuestion);

var inputQuestion = document.createElement('input');
inputQuestion.type = 'hidden';
inputQuestion.name = 'day'; 
inputQuestion.value = encodeURIComponent(day); 
form.appendChild(inputQuestion);

var inputImageUrl = document.createElement('input');
inputImageUrl.type = 'hidden';
inputImageUrl.name = 'imageUrl';
inputImageUrl.value = encodeURIComponent(imageUrl);
form.appendChild(inputImageUrl);

document.body.appendChild(form);
form.submit();

	}
    

</script>

<script>

function goMain(event) {
    if (!event.target.classList.contains('logout')) {
    	goToMain();
    }
}

    function logout() {
    	 swal('LOGOUT','로그아웃하고 메인으로 이동합니다!!','success')
	 .then(function(){	
		 var form = document.createElement('form');
	        form.method = 'GET';
	        form.action = '${pageContext.request.contextPath}/logout';  

	        document.body.appendChild(form);
	        form.submit();          
})
    }
    
    function goToMain() {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/main';
        document.body.appendChild(form);
        form.submit();
    }
    
    function goIntroduction() {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/introduction'; 
        document.body.appendChild(form);
        form.submit();
    }
    
    function goDirection() {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/direction';  
        document.body.appendChild(form);
        form.submit();
    }
    
    function goDiary() {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/diary';
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