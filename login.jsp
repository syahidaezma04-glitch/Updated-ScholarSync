<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ScholarSync — Login</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        body {
            display: flex;
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(
                135deg,
                var(--mint) 0%,
                #E8F5EC 50%,
                var(--blush) 100%
            );
        }

        .login-split {
            display: flex;
            width: 100%;
            min-height: 100vh;
        }

        .login-left {
            flex: 1;
            background: var(--green-dark);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 48px;
            position: relative;
            overflow: hidden;
        }

        .login-left::before {
            content: "";
            position: absolute;
            top: -80px;
            right: -80px;
            width: 320px;
            height: 320px;
            background: rgba(255, 255, 255, 0.07);
            border-radius: 50%;
        }

        .login-left::after {
            content: "";
            position: absolute;
            bottom: -60px;
            left: -60px;
            width: 240px;
            height: 240px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 50%;
        }

        .login-brand {
            text-align: center;
            z-index: 1;
        }

        .login-brand-icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }

        .login-brand h1 {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--white);
            margin: 0 0 10px;
        }

        .login-brand p {
            color: rgba(255, 255, 255, 0.75);
            font-size: 1rem;
            font-weight: 500;
            max-width: 260px;
            line-height: 1.7;
            margin: 0 auto;
        }

        .login-features {
            margin-top: 40px;
            display: flex;
            flex-direction: column;
            gap: 12px;
            z-index: 1;
        }

        .login-feature-item {
            display: flex;
            align-items: center;
            gap: 12px;
            color: rgba(255, 255, 255, 0.85);
            font-size: 0.9rem;
            font-weight: 600;
        }

        .feat-icon {
            width: 32px;
            height: 32px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }

        .login-right {
            width: 460px;
            box-sizing: border-box;
            background: var(--white);
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 56px 48px;
            box-shadow: var(--shadow-lg);
        }

        .login-right h2 {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--green-deep);
            margin: 0 0 6px;
        }

        .login-sub {
            font-size: 0.88rem;
            color: var(--text-muted);
            font-weight: 500;
            margin: 0 0 32px;
        }

        .tab-switcher {
            display: flex;
            background: var(--mint);
            border-radius: var(--radius-md);
            padding: 4px;
            margin-bottom: 28px;
            gap: 4px;
        }

        .tab-btn {
            flex: 1;
            padding: 8px;
            border: none;
            border-radius: 10px;
            background: transparent;
            font-weight: 700;
            font-size: 0.88rem;
            color: var(--text-muted);
            transition: all var(--transition);
            cursor: pointer;
        }

        .tab-btn.active {
            background: var(--white);
            color: var(--green-deep);
            box-shadow: var(--shadow-sm);
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-label {
            display: block;
            margin-bottom: 7px;
            font-size: 0.86rem;
            font-weight: 700;
            color: var(--green-deep);
        }

        .form-input {
            width: 100%;
            box-sizing: border-box;
        }

        .forgot-password {
            text-align: right;
            margin: -5px 0 20px;
        }

        .forgot-password a {
            font-size: 0.82rem;
            font-weight: 700;
            color: var(--green-dark);
            text-decoration: none;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }

        .alert-box {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 14px;
            margin-bottom: 20px;
            border-radius: 10px;
            background: #FDECEC;
            border: 1px solid #F5B7B1;
            color: #A93226;
            font-size: 0.85rem;
            font-weight: 600;
        }

        #registerForm {
            display: none;
        }

        @media (max-width: 760px) {
            .login-left {
                display: none;
            }

            .login-right {
                width: 100%;
                min-height: 100vh;
                padding: 40px 28px;
            }
        }
    </style>
</head>

<body>

<div class="login-split">

    <div class="login-left">

        <div class="login-brand">
            <div class="login-brand-icon">🌱</div>

            <h1>ScholarSync</h1>

            <p>
                Your smart study companion —
                plan, focus, and grow every day.
            </p>
        </div>

        <div class="login-features">

            <div class="login-feature-item">
                <div class="feat-icon">📅</div>
                <span>Smart academic calendar</span>
            </div>

            <div class="login-feature-item">
                <div class="feat-icon">⏱️</div>
                <span>Pomodoro focus timer</span>
            </div>

            <div class="login-feature-item">
                <div class="feat-icon">🌿</div>
                <span>Grow your virtual garden</span>
            </div>

            <div class="login-feature-item">
                <div class="feat-icon">📊</div>
                <span>Track your progress streaks</span>
            </div>

        </div>
    </div>

    <div class="login-right">

        <h2 id="formTitle">Welcome back 👋</h2>

        <p class="login-sub" id="formSubtitle">
            Sign in to continue your learning journey.
        </p>

        <%
            String message = (String) request.getAttribute("msg");

            if (message != null && !message.trim().isEmpty()) {
        %>

        <div class="alert-box">
            <span>⚠️</span>
            <span><%= message %></span>
        </div>

        <%
            }
        %>

        <div class="tab-switcher">

            <button type="button"
                    id="loginTab"
                    class="tab-btn active"
                    onclick="showLogin()">
                Sign In
            </button>

            <button type="button"
                    id="registerTab"
                    class="tab-btn"
                    onclick="showRegister()">
                Register
            </button>

        </div>

        <div id="loginForm">

            <form action="${pageContext.request.contextPath}/LoginServlet"
                  method="post">

                <div class="form-group">

                    <label class="form-label"
                           for="loginEmail">
                        Email Address
                    </label>

                    <input class="form-input"
                           type="email"
                           id="loginEmail"
                           name="email"
                           placeholder="you@university.edu"
                           autocomplete="email"
                           required>

                </div>

                <div class="form-group">

                    <label class="form-label"
                           for="loginPassword">
                        Password
                    </label>

                    <input class="form-input"
                           type="password"
                           id="loginPassword"
                           name="password"
                           placeholder="Enter your password"
                           autocomplete="current-password"
                           required>

                </div>

                <button class="btn btn-primary btn-block btn-lg"
                        type="submit">
                    Sign In →
                </button>

            </form>
        </div>

        <div id="registerForm">

            <form action="${pageContext.request.contextPath}/RegisterServlet"
                  method="post"
                  onsubmit="return validateRegistration()">

                <div class="form-group">

                    <label class="form-label"
                           for="registerName">
                        Full Name
                    </label>

                    <input class="form-input"
                           type="text"
                           id="registerName"
                           name="fullName"
                           placeholder="Your full name"
                           autocomplete="name"
                           required>

                </div>

                <div class="form-group">

                    <label class="form-label"
                           for="registerEmail">
                        Email Address
                    </label>

                    <input class="form-input"
                           type="email"
                           id="registerEmail"
                           name="email"
                           placeholder="you@university.edu"
                           autocomplete="email"
                           required>

                </div>

                <div class="form-group">

                    <label class="form-label"
                           for="registerPassword">
                        Password
                    </label>

                    <input class="form-input"
                           type="password"
                           id="registerPassword"
                           name="password"
                           placeholder="Create a strong password"
                           autocomplete="new-password"
                           required>

                </div>

                <div class="form-group">

                    <label class="form-label"
                           for="confirmPassword">
                        Confirm Password
                    </label>

                    <input class="form-input"
                           type="password"
                           id="confirmPassword"
                           name="confirmPassword"
                           placeholder="Repeat your password"
                           autocomplete="new-password"
                           required>

                </div>

                <div class="alert-box"
                     id="passwordError"
                     style="display: none;">

                    <span>⚠️</span>
                    <span>Passwords do not match.</span>

                </div>

                <button class="btn btn-primary btn-block btn-lg"
                        type="submit">
                    Create Account →
                </button>

            </form>
        </div>

    </div>
</div>

<script>
    const loginForm = document.getElementById("loginForm");
    const registerForm = document.getElementById("registerForm");

    const loginTab = document.getElementById("loginTab");
    const registerTab = document.getElementById("registerTab");

    const formTitle = document.getElementById("formTitle");
    const formSubtitle = document.getElementById("formSubtitle");

    function showLogin() {
        loginForm.style.display = "block";
        registerForm.style.display = "none";

        formTitle.textContent = "Welcome back 👋";
        formSubtitle.textContent =
            "Sign in to continue your learning journey.";

        loginTab.classList.add("active");
        registerTab.classList.remove("active");
    }

    function showRegister() {
        loginForm.style.display = "none";
        registerForm.style.display = "block";

        formTitle.textContent = "Join ScholarSync 🌱";
        formSubtitle.textContent =
            "Create your account and start growing.";

        registerTab.classList.add("active");
        loginTab.classList.remove("active");
    }

    function validateRegistration() {
        const password =
            document.getElementById("registerPassword").value;

        const confirmPassword =
            document.getElementById("confirmPassword").value;

        const passwordError =
            document.getElementById("passwordError");

        if (password !== confirmPassword) {
            passwordError.style.display = "flex";
            return false;
        }

        passwordError.style.display = "none";
        return true;
    }
</script>

</body>
</html>
