<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/signIn/css/signIn.css">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
    </style>
   <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>

<body class="background">
    <div class="background">
		<div class="backButton">
            <a href="../login/login.html">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="40" height="40" fill="none" stroke="black" stroke-width="2">
                    <path d="M19 12H5M12 19l-7-7 7-7"/>
                </svg>
            </a>
        </div>
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
            <div class="nameHead">
                <div class="idIcon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="44" height="46" viewBox="0 0 44 46" fill="none">
                        <path
                            d="M22 21.0835C23.4504 21.0835 24.8682 20.6338 26.0742 19.7914C27.2801 18.949 28.2201 17.7516 28.7751 16.3507C29.3301 14.9498 29.4754 13.4083 29.1924 11.9211C28.9095 10.4339 28.211 9.06784 27.1854 7.99564C26.1599 6.92344 24.8532 6.19326 23.4307 5.89744C22.0081 5.60162 20.5336 5.75344 19.1936 6.33372C17.8537 6.91399 16.7083 7.89664 15.9025 9.15742C15.0967 10.4182 14.6667 11.9005 14.6667 13.4168C14.6667 15.4501 15.4393 17.4002 16.8145 18.8379C18.1898 20.2757 20.0551 21.0835 22 21.0835Z"
                            fill="#D9D9D9" />
                        <path
                            d="M33 40.2501C33.4862 40.2501 33.9525 40.0481 34.2964 39.6887C34.6402 39.3293 34.8333 38.8417 34.8333 38.3334C34.8333 34.7751 33.4812 31.3625 31.0745 28.8464C28.6678 26.3303 25.4036 24.9167 22 24.9167C18.5964 24.9167 15.3322 26.3303 12.9255 28.8464C10.5187 31.3625 9.16666 34.7751 9.16666 38.3334C9.16666 38.8417 9.35981 39.3293 9.70363 39.6887C10.0474 40.0481 10.5138 40.2501 11 40.2501H33Z"
                            fill="#D9D9D9" />
                    </svg>
                </div>
            </div>
            <input type="text" id="nameInput" placeholder="이름" class="nameBody">


            <div class="birthHead">
                <div class="birthIcon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="36" height="40" viewBox="0 0 36 40" fill="none">
                        <path
                            d="M28 22H18V32H28V22ZM26 0V4H10V0H6V4H4C1.79 4 0.02 5.79 0.02 8L0 36C0 38.21 1.79 40 4 40H32C34.21 40 36 38.21 36 36V8C36 5.79 34.21 4 32 4H30V0H26ZM32 36H4V14H32V36Z"
                            fill="#D9D9D9" />
                    </svg>
                </div>
            </div>
            <input type="date" id="birthInput" class="birthBody">
            <div class="idHead">
                <div class="idIcon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="44" height="46" viewBox="0 0 44 46" fill="none">
                        <path
                            d="M22 21.0835C23.4504 21.0835 24.8682 20.6338 26.0742 19.7914C27.2801 18.949 28.2201 17.7516 28.7751 16.3507C29.3301 14.9498 29.4754 13.4083 29.1924 11.9211C28.9095 10.4339 28.211 9.06784 27.1854 7.99564C26.1599 6.92344 24.8532 6.19326 23.4307 5.89744C22.0081 5.60162 20.5336 5.75344 19.1936 6.33372C17.8537 6.91399 16.7083 7.89664 15.9025 9.15742C15.0967 10.4182 14.6667 11.9005 14.6667 13.4168C14.6667 15.4501 15.4393 17.4002 16.8145 18.8379C18.1898 20.2757 20.0551 21.0835 22 21.0835Z"
                            fill="#D9D9D9" />
                        <path
                            d="M33 40.2501C33.4862 40.2501 33.9525 40.0481 34.2964 39.6887C34.6402 39.3293 34.8333 38.8417 34.8333 38.3334C34.8333 34.7751 33.4812 31.3625 31.0745 28.8464C28.6678 26.3303 25.4036 24.9167 22 24.9167C18.5964 24.9167 15.3322 26.3303 12.9255 28.8464C10.5187 31.3625 9.16666 34.7751 9.16666 38.3334C9.16666 38.8417 9.35981 39.3293 9.70363 39.6887C10.0474 40.0481 10.5138 40.2501 11 40.2501H33Z"
                            fill="#D9D9D9" />
                    </svg>
                </div>
            </div>
            <input type="text" id="idInput" placeholder="이메일" class="idBody">
            <div class="passwdHead">
                <div class="passwordIcon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="26" height="34" viewBox="0 0 26 34" fill="none">
                        <path
                            d="M22.6087 12.9634H21.888V8.98127C21.888 4.02883 17.9011 0 13.0001 0C8.09957 0 4.11253 4.02883 4.11253 8.98127V12.9634H3.39133C1.51844 12.9634 0 14.4976 0 16.3904V27.0305C0 30.8796 3.08767 34 6.89672 34H19.1033C22.9123 34 26 30.8796 26 27.0305V16.3904C26 14.4976 24.4817 12.9634 22.6087 12.9634ZM14.2628 23.5526V27.8812C14.2628 28.5858 13.6974 29.1572 13.0001 29.1572C12.3028 29.1572 11.7374 28.5858 11.7374 27.8812V23.5526C10.7754 23.0787 10.1111 22.084 10.1111 20.9299C10.1111 19.3176 11.4046 18.0103 13.0001 18.0103C14.5957 18.0103 15.8893 19.3174 15.8893 20.9299C15.8893 22.084 15.2246 23.0789 14.2628 23.5526ZM18.6738 12.9634H7.32706V8.98127C7.32706 5.81995 9.87202 3.24802 13.0002 3.24802C16.1288 3.24802 18.6738 5.81995 18.6738 8.98127V12.9634Z"
                            fill="#D9D9D9" />
                    </svg>
                </div>
            </div>
            <input type="password" id="passwordInput" placeholder="패스워드" class="passwdBody">
            <button class="gotoLogin"  onclick ="window.location.href='../login/login.html'">GO TO LOGIN</button>
            <button class="signInBox"  onclick="javascript:submitForm();">SIGN IN</button>
        </div>
    </div>
    <script>
		swal('SIGN IN  ERROR!!','모든 항목을 체크해주세요!!','error')
	 .then(function(){
	location.href="${pageContext.request.contextPath}//signIn/signIn.html";             
})
	</script>
</body>

</html>