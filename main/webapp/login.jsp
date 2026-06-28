<%@ page language="java" contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<title>ScholarSync Login</title>

<link rel="stylesheet" href="css/style.css">

</head>
<script>

function showLogin(){

    document.getElementById("loginForm").style.display="block";
    document.getElementById("registerForm").style.display="none";
    document.getElementById("title").innerHTML="Welcome Back 👋";

    document.querySelectorAll(".tab-btn")[0].classList.add("active");
    document.querySelectorAll(".tab-btn")[1].classList.remove("active");

}

function showRegister(){

    document.getElementById("loginForm").style.display="none";
    document.getElementById("registerForm").style.display="block";
    document.getElementById("title").innerHTML="Create Account 🌱";

    document.querySelectorAll(".tab-btn")[1].classList.add("active");
    document.querySelectorAll(".tab-btn")[0].classList.remove("active");

}

</script>
<body>

<div class="login-left">

    <h2 id="title">Welcome Back 👋</h2>

    <% if(request.getAttribute("msg") != null){ %>
        <div class="alert-box">
            <%= request.getAttribute("msg") %>
        </div>
    <% } %>

    <div class="tab-switcher">
        <button type="button" class="tab-btn active" onclick="showLogin()">Sign In</button>
        <button type="button" class="tab-btn" onclick="showRegister()">Register</button>
    </div>

    <!-- LOGIN -->
    <div id="loginForm">

        <form action="LoginServlet" method="post">

            <div class="form-group">
                <label>Email</label>
                <input class="form-input"
                       type="email"
                       name="email"
                       required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input class="form-input"
                       type="password"
                       name="password"
                       required>
            </div>

            <button class="btn btn-primary btn-block"
                    type="submit">
                Sign In
            </button>

        </form>

    </div>

    <!-- REGISTER -->
    <div id="registerForm" style="display:none;">

        <form action="RegisterServlet" method="post">

            <div class="form-group">
                <label>Full Name</label>
                <input class="form-input"
                       type="text"
                       name="fullName"
                       required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input class="form-input"
                       type="email"
                       name="email"
                       required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input class="form-input"
                       type="password"
                       name="password"
                       required>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input class="form-input"
                       type="password"
                       name="confirmPassword"
                       required>
            </div>

            <button class="btn btn-primary btn-block"
                    type="submit">
                Register
            </button>

        </form>

    </div>

</div>
</body>

</html>