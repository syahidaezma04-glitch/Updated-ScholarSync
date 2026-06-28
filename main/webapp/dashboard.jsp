<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>ScholarSync | Dashboard</title>

<link rel="stylesheet" href="css/style.css">

</head>

<body>

<div class="app-shell">

    <!-- ================= SIDEBAR ================= -->

    <aside class="sidebar">

        <div class="sidebar-logo">

            <div class="logo-icon">🌱</div>

            <div>

                <div class="logo-text">
                    ScholarSync
                </div>

                <div class="logo-sub">
                    Study Planner
                </div>

            </div>

        </div>

        <nav class="sidebar-nav">

            <a href="DashboardServlet" class="nav-item active">

                <span class="nav-icon">🏠</span>

                <span class="nav-label">
                    Dashboard
                </span>

            </a>

            <a href="CalendarServlet" class="nav-item">

                <span class="nav-icon">📅</span>

                <span class="nav-label">
                    Calendar
                </span>

            </a>

            <a href="ActivitiesServlet" class="nav-item">

                <span class="nav-icon">✅</span>

                <span class="nav-label">
                    Activities
                </span>

            </a>

            <a href="TimerServlet" class="nav-item">

                <span class="nav-icon">⏱️</span>

                <span class="nav-label">
                    Study Timer
                </span>

            </a>

            <a href="GardenServlet" class="nav-item">

                <span class="nav-icon">🌿</span>

                <span class="nav-label">
                    Plant Garden
                </span>

            </a>

            <a href="settings.jsp" class="nav-item">

                <span class="nav-icon">⚙️</span>

                <span class="nav-label">
                    Settings
                </span>

            </a>

        </nav>

        <div class="sidebar-bottom">

            <a href="LogoutServlet" class="nav-item logout">

                <span class="nav-icon">🚪</span>

                <span class="nav-label">
                    Logout
                </span>

            </a>

        </div>

    </aside>

    <!-- ================= MAIN ================= -->

    <div class="main-content">

        <header class="top-header">

            <div>

                <div class="header-title">

                    Dashboard

                </div>

                <div style="margin-top:6px;color:#666;">

                    Welcome,

                    <strong>

                        ${user.fullName}

                    </strong>

                    👋

                </div>

            </div>

            <div class="header-right">

                <button class="header-icon-btn">

                    🔄

                </button>

                <button class="header-icon-btn">

                    ❓

                </button>

                <div class="header-datetime">

                    <div class="header-time"
                         id="headerTime">

                        --:--:--

                    </div>

                    <div class="header-date"
                         id="headerDate">

                        --

                    </div>

                </div>

                <button class="day-night-toggle"
                        onclick="toggleDark()">

                    <span id="modeIcon">

                        🌙

                    </span>

                    <span id="modeLabel">

                        Night

                    </span>

                </button>

            </div>

        </header>

        <main class="page-body">
        
 <!-- ================= DASHBOARD CARDS ================= -->

<div class="dashboard-grid">

    <!-- Coins -->
    <div class="stat-card">

        <div class="stat-icon">
            🪙
        </div>

        <div class="stat-value">
            ${user.coins}
        </div>

        <div class="stat-label">
            Coins
        </div>

    </div>

    <!-- Study Goal -->
    <div class="stat-card yellow">

        <div class="stat-icon">
            🎯
        </div>

        <div class="stat-value">
            ${user.studyGoal}
        </div>

        <div class="stat-label">
            Study Goal (Hours)
        </div>

    </div>

    <!-- Email -->
    <div class="stat-card pink">

        <div class="stat-icon">
            📧
        </div>

        <div class="stat-value"
             style="font-size:18px;">

            ${user.email}

        </div>

        <div class="stat-label">
            Email Address
        </div>

    </div>

    <!-- User ID -->
    <div class="stat-card lavender">

        <div class="stat-icon">
            👤
        </div>

        <div class="stat-value">

            #${user.userID}

        </div>

        <div class="stat-label">
            User ID
        </div>

    </div>

</div>
<!-- ================= SECOND ROW ================= -->

<div class="bottom-row" style="margin-bottom:24px;">

    <!-- Pomodoro Widget -->
    <div class="pomodoro-widget">

        <div class="widget-label">
            🍅 Active Focus Session
        </div>

        <div class="timer-display" id="dashTimer">
            25:00
        </div>

        <div class="session-label">
            Session 1 of 4 · Focus Block
        </div>

        <div class="pomodoro-controls">

            <button class="pomo-btn"
                    onclick="toggleDashTimer(this)">
                ▶ Start
            </button>

            <button class="pomo-btn pause"
                    onclick="clearDashTimer()">
                ✕ Clear
            </button>

        </div>

    </div>

    <!-- User Summary -->
    <div class="streak-box">

        <div class="streak-flame">
            🌱
        </div>

        <div class="streak-number">
            ${user.coins}
        </div>

        <div class="streak-label">
            Your Coins
        </div>

        <p>
            Keep studying to earn more rewards!
        </p>

    </div>

</div>

<!-- ================= TASK SECTION ================= -->

<div class="bottom-row">

    <!-- Pending Tasks -->

    <div class="card">

        <div class="card-title">

            <div class="card-title-icon">
                📋
            </div>

            Pending Tasks

            <span class="badge badge-yellow"
                  style="margin-left:auto;">

                ${pending} Pending

            </span>

        </div>

        <div class="task-list">

            <div class="task-item">

                <div class="task-info">

                    <div class="task-title-text">

                        Total Pending Study Plans

                    </div>

                    <div class="task-meta">

                        You currently have
                        <strong>${pending}</strong>
                        pending study plans.

                    </div>

                </div>

            </div>

        </div>

    </div>

    <!-- Completed Tasks -->

    <div class="card">

        <div class="card-title">

            <div class="card-title-icon">
                ✅
            </div>

            Completed Tasks

            <span class="badge badge-green"
                  style="margin-left:auto;">

                ${completed} Completed

            </span>

        </div>

        <div class="task-list">

            <div class="task-item">

                <div class="task-info">

                    <div class="task-title-text">

                        Total Completed Study Plans

                    </div>

                    <div class="task-meta">

                        Great job! You completed
                        <strong>${completed}</strong>
                        study plans.

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</main>

</div>

</div>

<script>

function updateClock(){

    const now = new Date();

    document.getElementById("headerTime").innerHTML =
        now.toLocaleTimeString();

    document.getElementById("headerDate").innerHTML =
        now.toDateString();

}

setInterval(updateClock,1000);

updateClock();

let dashSeconds = 25 * 60;

let dashRunning = false;

let dashInterval;

function toggleDashTimer(btn){

    if(!dashRunning){

        dashRunning = true;

        btn.innerHTML = "⏸ Pause";

        dashInterval = setInterval(function(){

            if(dashSeconds>0){

                dashSeconds--;

                let m = Math.floor(dashSeconds/60);

                let s = dashSeconds%60;

                document.getElementById("dashTimer").innerHTML =
                    String(m).padStart(2,'0') + ":" +
                    String(s).padStart(2,'0');

            }

        },1000);

    }else{

        clearInterval(dashInterval);

        dashRunning=false;

        btn.innerHTML="▶ Resume";

    }

}

function clearDashTimer(){

    clearInterval(dashInterval);

    dashRunning=false;

    dashSeconds=25*60;

    document.getElementById("dashTimer").innerHTML="25:00";

}

</script>

</body>

</html>