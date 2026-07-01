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

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .dashboard-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 18px;
      margin-bottom: 24px;
    }
    .pomodoro-widget {
      background: linear-gradient(135deg, var(--green-dark) 0%, var(--green-deep) 100%);
      border-radius: var(--radius-lg);
      padding: 24px;
      color: var(--white);
      display: flex;
      flex-direction: column;
      gap: 10px;
      position: relative;
      overflow: hidden;
      border: none;
      box-shadow: var(--shadow-md);
    }
    .pomodoro-widget::before {
      content: '';
      position: absolute;
      top: -30px; right: -30px;
      width: 120px; height: 120px;
      background: rgba(255,255,255,.08);
      border-radius: 50%;
    }
    .pomodoro-widget .widget-label {
      font-size: .72rem;
      font-weight: 800;
      text-transform: uppercase;
      letter-spacing: .08em;
      opacity: .75;
    }
    .pomodoro-widget .timer-display {
      font-family: 'DM Mono', monospace;
      font-size: 2.8rem;
      font-weight: 500;
      line-height: 1;
      letter-spacing: .02em;
    }
    .pomodoro-widget .session-label {
      font-size: .78rem;
      opacity: .8;
      font-weight: 600;
    }
    .pomodoro-controls {
      display: flex;
      gap: 8px;
      margin-top: 4px;
    }
    .pomo-btn {
      padding: 7px 16px;
      border-radius: 99px;
      background: rgba(255,255,255,.2);
      color: var(--white);
      font-weight: 700;
      font-size: .8rem;
      border: none;
      cursor: pointer;
      transition: background var(--transition);
    }
    .pomo-btn:hover { background: rgba(255,255,255,.35); }
    .pomo-btn.pause { background: rgba(255,214,224,.25); }

    .bottom-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 18px;
    }
    .task-list { display: flex; flex-direction: column; gap: 10px; }
    .task-item {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 16px;
      background: var(--mint);
      border-radius: var(--radius-md);
      border: 1.5px solid var(--mint-mid);
      transition: all var(--transition);
    }
    .task-item:hover { background: var(--white); box-shadow: var(--shadow-sm); }
    .task-check {
      width: 20px; height: 20px;
      border-radius: 50%;
      border: 2px solid var(--green);
      flex-shrink: 0;
      cursor: pointer;
      display: flex; align-items: center; justify-content: center;
      transition: all var(--transition);
    }
    .task-check.done {
      background: var(--green-dark);
      border-color: var(--green-dark);
      color: var(--white);
      font-size: .65rem;
    }
    .task-info { flex: 1; }
    .task-title-text {
      font-size: .88rem;
      font-weight: 700;
      color: var(--text);
    }
    .task-meta {
      font-size: .72rem;
      color: var(--text-muted);
      font-weight: 500;
    }
    .streak-box {
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      gap: 6px;
      background: linear-gradient(135deg, var(--yellow) 0%, #FFF3A0 100%);
      border-radius: var(--radius-lg);
      padding: 24px;
      border: 1.5px solid var(--yellow-mid);
      text-align: center;
    }
    .streak-number {
      font-family: 'DM Mono', monospace;
      font-size: 3.5rem;
      font-weight: 500;
      color: var(--yellow-dark);
      line-height: 1;
    }
    .streak-flame { font-size: 2rem; }
    .streak-label {
      font-size: .78rem;
      font-weight: 800;
      color: var(--yellow-dark);
      text-transform: uppercase;
      letter-spacing: .06em;
    }

    @media (max-width: 1100px) {
      .dashboard-grid { grid-template-columns: repeat(2, 1fr); }
    }
    @media (max-width: 700px) {
      .dashboard-grid { grid-template-columns: 1fr; }
      .bottom-row { grid-template-columns: 1fr; }
    }
  </style>
</head>

<body>

<div class="app-shell">

    <!-- ================= SIDEBAR ================= -->

  <%-- ═══════════════ SIDEBAR ═══════════════ --%>
  <aside class="sidebar">
    <div class="sidebar-logo">
      <div class="logo-icon">🌱</div>
      <div>
        <div class="logo-text">ScholarSync</div>
        <div class="logo-sub">Study Planner</div>
      </div>
    </div>
    <nav class="sidebar-nav">
      <a href="${pageContext.request.contextPath}/DashboardServlet"  class="nav-item active"><span class="nav-icon">🏠</span><span class="nav-label">Dashboard</span></a>
      <a href="${pageContext.request.contextPath}/CalendarServlet"   class="nav-item"><span class="nav-icon">📅</span><span class="nav-label">Calendar</span></a>
      <a href="${pageContext.request.contextPath}/ActivityServlet" class="nav-item"><span class="nav-icon">✅</span><span class="nav-label">Activities</span></a>
      <a href="${pageContext.request.contextPath}/TimerServlet"      class="nav-item "><span class="nav-icon">⏱️</span><span class="nav-label">Study Timer</span></a>
      <a href="${pageContext.request.contextPath}/GardenServlet"     class="nav-item"><span class="nav-icon">🌿</span><span class="nav-label">Plant Garden</span></a>
      <a href="${pageContext.request.contextPath}/SettingsServlet"      class="nav-item"><span class="nav-icon">⚙️</span><span class="nav-label">Settings</span></a>
    </nav>
    <div class="sidebar-bottom">
      <a href="${pageContext.request.contextPath}/LogoutServlet" class="nav-item logout">
        <span class="nav-icon">🚪</span><span class="nav-label">Logout</span>
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
<!-- ================= DASHBOARD CARDS ================= -->

<div class="dashboard-grid">

    <!-- Coins -->
    <div class="stat-card">
        <div class="stat-icon">🪙</div>
        <div class="stat-value">${user.coins}</div>
        <div class="stat-label">Coins</div>
    </div>

    <!-- Study Goal -->
    <div class="stat-card yellow">
        <div class="stat-icon">🎯</div>
        <div class="stat-value">${user.studyGoal}</div>
        <div class="stat-label">Study Goal (Hours)</div>
    </div>

    <!-- Subjects -->
    <div class="stat-card green">
        <div class="stat-icon">📚</div>
        <div class="stat-value">${subjectCount}</div>
        <div class="stat-label">Subjects</div>
    </div>

    <!-- Pending Tasks -->
    <div class="stat-card pink">
        <div class="stat-icon">📋</div>
        <div class="stat-value">${pending}</div>
        <div class="stat-label">Pending Tasks</div>
    </div>

</div>


<!-- ================= SECOND ROW ================= -->

<div class="bottom-row" style="margin-top:25px;">

    <!-- Pomodoro -->

    <div class="pomodoro-widget">

        <div class="widget-label">
            🍅 Today's Focus
        </div>

        <div class="timer-display" id="dashTimer">
            ${setting.focusTime}:00
        </div>

        <div class="session-label">
            Ready to Focus
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

    <!-- Coins Summary -->

    <div class="streak-box">

        <div class="streak-flame">
            🌱
        </div>

        <div class="streak-number">
            ${user.coins}
        </div>

        <div class="streak-label">
            Total Coins
        </div>

        <p>
            Keep studying to earn more rewards!
        </p>

    </div>

</div>


<!-- ================= TODAY'S ACTIVITIES ================= -->

<div class="card" style="margin-top:25px;">

    <div class="card-title">

        <div class="card-title-icon">
            📅
        </div>

        Today's Activities

    </div>

    <div class="task-list">

        <c:choose>

            <c:when test="${not empty recentActivities}">

                <c:forEach var="a" items="${recentActivities}">

                    <div class="task-item">

                        <div class="task-info">

                            <div class="task-title-text">
                                ${a.title}
                            </div>

                            <div class="task-meta">

                                <strong>${a.subjectCode}</strong>

                                &nbsp;|&nbsp;

                                ${a.activityDate}

                                &nbsp;|&nbsp;

                                ${a.activityTime}

                            </div>

                        </div>

                        <span class="badge ${a.status=='Completed'?'badge-green':'badge-yellow'}">

                            ${a.status}

                        </span>

                    </div>

                </c:forEach>

            </c:when>

            <c:otherwise>

                <div class="task-item">

                    <div class="task-info">

                        <div class="task-title-text">

                            No activities today.

                        </div>

                    </div>

                </div>

            </c:otherwise>

        </c:choose>

    </div>

</div>


<!-- ================= TASK SUMMARY ================= -->

<div class="bottom-row" style="margin-top:25px;">

    <!-- Pending -->

    <div class="card">

        <div class="card-title">

            <div class="card-title-icon">
                📋
            </div>

            Pending Tasks

            <span class="badge badge-yellow"
                  style="margin-left:auto;">
                ${pending}
            </span>

        </div>

        <div class="task-list">

            <div class="task-item">

                <div class="task-info">

                    <div class="task-title-text">

                        Pending Study Plans

                    </div>

                    <div class="task-meta">

                        You currently have

                        <strong>${pending}</strong>

                        pending activities.

                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- Completed -->

    <div class="card">

        <div class="card-title">

            <div class="card-title-icon">
                ✅
            </div>

            Completed Tasks

            <span class="badge badge-green"
                  style="margin-left:auto;">
                ${completed}
            </span>

        </div>

        <div class="task-list">

            <div class="task-item">

                <div class="task-info">

                    <div class="task-title-text">

                        Completed Study Plans

                    </div>

                    <div class="task-meta">

                        Awesome! You've completed

                        <strong>${completed}</strong>

                        study activities.

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
  // Live header clock
  (function tick() {
    const now = new Date(), pad = n => String(n).padStart(2,'0');
    document.getElementById('headerTime').textContent =
      pad(now.getHours()) + ':' + pad(now.getMinutes()) + ':' + pad(now.getSeconds());
    document.getElementById('headerDate').textContent =
      now.toLocaleDateString('en-MY', { weekday:'short', day:'numeric', month:'short', year:'numeric' });
    setTimeout(tick, 1000);
  })();
</script>

</body>

</html>