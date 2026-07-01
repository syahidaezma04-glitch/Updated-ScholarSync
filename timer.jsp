<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>ScholarSync - Study Timer</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
  <style>
    .timer-layout {
      display: grid;
      grid-template-columns: 1fr 340px;
      gap: 24px;
      align-items: start;
    }

    /* ── TIMER MAIN ── */
    .timer-main-card {
      background: linear-gradient(145deg, var(--green-deep) 0%, #2A5C3A 100%);
      border-radius: var(--radius-xl);
      padding: 44px 40px;
      color: var(--white);
      text-align: center;
      box-shadow: var(--shadow-lg);
      position: relative;
      overflow: hidden;
    }
    .timer-main-card::before {
      content: '';
      position: absolute;
      top: -60px; right: -60px;
      width: 240px; height: 240px;
      background: rgba(255,255,255,.05);
      border-radius: 50%;
    }
    .timer-main-card::after {
      content: '';
      position: absolute;
      bottom: -40px; left: -40px;
      width: 180px; height: 180px;
      background: rgba(255,255,255,.04);
      border-radius: 50%;
    }

    .session-mode-tabs {
      display: flex;
      gap: 6px;
      justify-content: center;
      margin-bottom: 36px;
      position: relative;
      z-index: 1;
    }
    .mode-tab {
      padding: 8px 20px;
      border-radius: 99px;
      background: rgba(255,255,255,.12);
      color: rgba(255,255,255,.7);
      font-weight: 700;
      font-size: .82rem;
      border: none;
      cursor: pointer;
      transition: all var(--transition);
    }
    .mode-tab.active {
      background: var(--white);
      color: var(--green-deep);
    }
    .mode-tab:hover:not(.active) { background: rgba(255,255,255,.22); color: var(--white); }

    /* Circular timer */
    .timer-circle-wrap {
      position: relative;
      width: 260px;
      height: 260px;
      margin: 0 auto 32px;
      z-index: 1;
    }
    .timer-svg {
      width: 260px; height: 260px;
      transform: rotate(-90deg);
    }
    .timer-track {
      fill: none;
      stroke: rgba(255,255,255,.12);
      stroke-width: 10;
    }
    .timer-progress {
      fill: none;
      stroke: var(--yellow-mid);
      stroke-width: 10;
      stroke-linecap: round;
      stroke-dasharray: 722;
      stroke-dashoffset: 0;
      transition: stroke-dashoffset 1s linear;
    }
    .timer-inner {
      position: absolute;
      inset: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 4px;
    }
    .timer-digits {
      font-family: 'DM Mono', monospace;
      font-size: 3.6rem;
      font-weight: 500;
      letter-spacing: .04em;
      line-height: 1;
    }
    .timer-session-label {
      font-size: .72rem;
      font-weight: 700;
      opacity: .7;
      text-transform: uppercase;
      letter-spacing: .08em;
    }

    /* Session dots */
    .session-dots {
      display: flex;
      gap: 10px;
      justify-content: center;
      margin-bottom: 32px;
      z-index: 1;
      position: relative;
    }
    .session-dot {
      width: 12px; height: 12px;
      border-radius: 50%;
      background: rgba(255,255,255,.25);
      transition: background var(--transition);
    }
    .session-dot.done { background: var(--yellow-mid); }
    .session-dot.active { background: var(--white); box-shadow: 0 0 0 3px rgba(255,255,255,.2); }

    /* Controls */
    .timer-controls {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 14px;
      z-index: 1;
      position: relative;
    }
    .ctrl-btn {
      width: 48px; height: 48px;
      border-radius: 50%;
      background: rgba(255,255,255,.15);
      color: var(--white);
      font-size: 1.1rem;
      display: flex; align-items: center; justify-content: center;
      border: none;
      cursor: pointer;
      transition: all var(--transition);
    }
    .ctrl-btn:hover { background: rgba(255,255,255,.28); transform: scale(1.05); }
    .ctrl-btn.main-btn {
      width: 68px; height: 68px;
      font-size: 1.6rem;
      background: var(--white);
      color: var(--green-deep);
      box-shadow: 0 4px 20px rgba(0,0,0,.2);
    }
    .ctrl-btn.main-btn:hover { transform: scale(1.08); box-shadow: 0 6px 28px rgba(0,0,0,.25); }

    /* Custom duration row */
    .custom-duration {
      display: flex;
      align-items: center;
      gap: 10px;
      justify-content: center;
      margin-top: 24px;
      z-index: 1;
      position: relative;
    }
    .duration-pill {
      padding: 6px 16px;
      border-radius: 99px;
      background: rgba(255,255,255,.12);
      color: rgba(255,255,255,.8);
      font-size: .8rem;
      font-weight: 700;
      cursor: pointer;
      border: none;
      transition: all var(--transition);
    }
    .duration-pill.active,
    .duration-pill:hover { background: rgba(255,255,255,.28); color: var(--white); }

    /* Spacebar hint */
    .spacebar-hint {
      margin-top: 14px;
      font-size: .7rem;
      opacity: .5;
      font-weight: 600;
      letter-spacing: .04em;
      z-index: 1;
      position: relative;
    }
    .kbd {
      background: rgba(255,255,255,.15);
      border-radius: 4px;
      padding: 1px 6px;
      font-family: 'DM Mono', monospace;
      font-size: .7rem;
    }

    /* ── RIGHT SIDE ── */
    .right-col { display: flex; flex-direction: column; gap: 18px; }

    /* Session stats */
    .session-stats {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 12px;
    }
    .stat-mini {
      background: var(--white);
      border-radius: var(--radius-md);
      border: 1.5px solid var(--mint-mid);
      padding: 14px 16px;
      text-align: center;
    }
    .stat-mini .sm-value {
      font-family: 'DM Mono', monospace;
      font-size: 1.6rem;
      font-weight: 500;
      color: var(--green-deep);
    }
    .stat-mini .sm-label {
      font-size: .68rem;
      font-weight: 700;
      color: var(--text-muted);
      text-transform: uppercase;
      letter-spacing: .04em;
    }

    /* Task selector */
    .task-selector .task-option {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 10px 12px;
      border-radius: var(--radius-md);
      cursor: pointer;
      transition: background var(--transition);
      font-size: .88rem;
      font-weight: 600;
    }
    .task-option:hover { background: var(--mint); }
    .task-option.selected { background: var(--mint-mid); color: var(--green-deep); }
    .task-option input[type="radio"] { accent-color: var(--green-dark); width: 16px; height: 16px; }

    /* Session log */
    .session-log { display: flex; flex-direction: column; gap: 8px; max-height: 200px; overflow-y: auto; }
    .log-entry {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 8px 12px;
      background: var(--mint);
      border-radius: var(--radius-sm);
      font-size: .78rem;
      font-weight: 600;
    }
    .log-dot {
      width: 8px; height: 8px;
      border-radius: 50%;
      flex-shrink: 0;
    }
    .log-dot.focus { background: var(--green-dark); }
    .log-dot.break { background: var(--blush-dark); }
    .log-time { color: var(--text-muted); margin-left: auto; font-family: 'DM Mono', monospace; font-size: .72rem; }

    .no-rows { text-align: center; padding: 16px; color: var(--text-muted); font-size: .8rem; font-weight: 600; }

    @media (max-width: 1000px) {
      .timer-layout { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>

<%-- Settings handed to JS – falls back to sane defaults if "setting" attribute is absent --%>
<script>
  const focusTime              = ${empty setting ? 25    : setting.focusTime};
  const shortBreak             = ${empty setting ? 5     : setting.shortBreak};
  const longBreak              = ${empty setting ? 15    : setting.longBreak};
  const sessionsUntilLongBreak = ${empty setting ? 4     : setting.sessionsUntilLongBreak};
  const autoBreak              = ${empty setting ? false : setting.autoBreak};
  const autoFocus              = ${empty setting ? true  : setting.autoFocus};
  const coinsPerSession        = ${empty setting ? 5     : setting.coinsPerSession};
</script>

<div class="app-shell">

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
      <a href="${pageContext.request.contextPath}/DashboardServlet"  class="nav-item"><span class="nav-icon">🏠</span><span class="nav-label">Dashboard</span></a>
      <a href="${pageContext.request.contextPath}/CalendarServlet"   class="nav-item"><span class="nav-icon">📅</span><span class="nav-label">Calendar</span></a>
      <a href="${pageContext.request.contextPath}/ActivityServlet" class="nav-item"><span class="nav-icon">✅</span><span class="nav-label">Activities</span></a>
      <a href="${pageContext.request.contextPath}/TimerServlet"      class="nav-item active"><span class="nav-icon">⏱️</span><span class="nav-label">Study Timer</span></a>
      <a href="${pageContext.request.contextPath}/GardenServlet"     class="nav-item"><span class="nav-icon">🌿</span><span class="nav-label">Plant Garden</span></a>
      <a href="${pageContext.request.contextPath}/SettingsServlet"      class="nav-item"><span class="nav-icon">⚙️</span><span class="nav-label">Settings</span></a>
    </nav>
    <div class="sidebar-bottom">
      <a href="${pageContext.request.contextPath}/LogoutServlet" class="nav-item logout">
        <span class="nav-icon">🚪</span><span class="nav-label">Logout</span>
      </a>
    </div>
  </aside>

  <%-- ═══════════════ MAIN ═══════════════════ --%>
  <div class="main-content">
    <header class="top-header">
      <div class="header-title">Study Timer</div>
      <div class="header-right">
        <button class="header-icon-btn" title="Help">❓</button>
        <div class="header-datetime">
          <div class="header-time" id="headerTime">--:--:--</div>
          <div class="header-date" id="headerDate">--</div>
        </div>
        <button class="day-night-toggle" onclick="toggleDark()">
          <span id="modeIcon">🌙</span><span id="modeLabel">Night</span>
        </button>
      </div>
    </header>

    <main class="page-body">
      <c:if test="${not empty message}">
        <p style="color:green;font-weight:700;"><c:out value="${message}"/></p>
      </c:if>
      <c:if test="${not empty error}">
        <p style="color:red;font-weight:700;"><c:out value="${error}"/></p>
      </c:if>

      <div class="timer-layout">

        <%-- ═══ TIMER MAIN CARD ═══ --%>
        <div class="timer-main-card">

          <%-- Mode tabs --%>
          <div class="session-mode-tabs">
            <button class="mode-tab active" id="tabFocus" onclick="setMode('focus')">Focus</button>
            <button class="mode-tab" id="tabShort" onclick="setMode('short')">Short Break</button>
            <button class="mode-tab" id="tabLong"  onclick="setMode('long')">Long Break</button>
          </div>

          <%-- Circular progress timer --%>
          <div class="timer-circle-wrap">
            <svg class="timer-svg" viewBox="0 0 260 260">
              <circle class="timer-track"    cx="130" cy="130" r="115" />
              <circle class="timer-progress" id="timerRing" cx="130" cy="130" r="115" />
            </svg>
            <div class="timer-inner">
              <div class="timer-digits" id="timerDisplay">
                <c:out value="${empty setting ? '25' : setting.focusTime}"/>:00
              </div>
              <div class="timer-session-label">
                Session <span id="currentSession"><c:out value="${empty currentSession ? 1 : currentSession}"/></span>
                of <c:out value="${empty setting ? 4 : setting.sessionsUntilLongBreak}"/>
              </div>
            </div>
          </div>

          <%-- Session dots --%>
          <div class="session-dots" id="sessionDots">
            <%-- populated by timer.js based on sessionsUntilLongBreak --%>
          </div>

          <%-- Controls --%>
          <div class="timer-controls">
            <button class="ctrl-btn" onclick="resetTimer()" title="Reset">↺</button>
            <button class="ctrl-btn main-btn" id="mainPlayBtn" onclick="toggleStartPause()" title="Start/Pause">▶</button>
            <button class="ctrl-btn" onclick="skipSession()" title="Skip">⏭</button>
          </div>

          <%-- Custom duration pills --%>
          <div class="custom-duration">
            <button class="duration-pill" onclick="setCustomDuration(15)">15m</button>
            <button class="duration-pill active" onclick="setCustomDuration(25)">25m</button>
            <button class="duration-pill" onclick="setCustomDuration(45)">45m</button>
            <button class="duration-pill" onclick="setCustomDuration(60)">60m</button>
          </div>

          <div class="spacebar-hint">Press <span class="kbd">Space</span> to start / pause</div>
        </div><%-- end .timer-main-card --%>

        <%-- ═══ RIGHT COLUMN ═══ --%>
        <div class="right-col">

          <%-- Today's stats --%>
          <div class="card">
            <div class="card-title"><div class="card-title-icon">📊</div>Today's Statistics</div>
            <div class="session-stats">
 <div class="stat-mini">
    <div class="sm-value" id="todayCoins">
        ${user.coins}
    </div>
    <div class="sm-label">
        Coins
    </div>
</div>
              <div class="stat-mini">
                <div class="sm-value" id="todayMinutes"><c:out value="${empty todayMinutes ? 0 : todayMinutes}"/></div>
                <div class="sm-label">Focus Min</div>
              </div>
              <div class="stat-mini">
                <div class="sm-value" id="todayBreaks"><c:out value="${empty todayBreaks ? 0 : todayBreaks}"/></div>
                <div class="sm-label">Breaks</div>
              </div>
              <div class="stat-mini">
                <div class="sm-value" id="todayCoins"><c:out value="${empty todayCoins ? 0 : todayCoins}"/></div>
                <div class="sm-label">Coins</div>
              </div>
            </div>
          </div>

          <%-- Study plan selector --%>
          <div class="card task-selector">
            <div class="card-title"><div class="card-title-icon">📋</div>Study Plans</div>
            <c:choose>
              <c:when test="${empty studyPlans}">
                <div class="no-rows">No study plans available.</div>
              </c:when>
              <c:otherwise>
                <c:forEach var="plan" items="${studyPlans}">
                  <label class="task-option">
                    <input type="radio" name="studyPlan" value="${plan.studyPlanID}">
                    <c:out value="${plan.title}"/>
                  </label>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </div>

          <%-- Session history --%>
          <div class="card">
            <div class="card-title"><div class="card-title-icon">🕓</div>Session History</div>
            <div class="session-log">
              <c:choose>
                <c:when test="${empty sessionLogs}">
                  <div class="no-rows">No session history.</div>
                </c:when>
                <c:otherwise>
                  <c:forEach var="log" items="${sessionLogs}">
                    <div class="log-entry">
                      <div class="log-dot ${log.type eq 'focus' ? 'focus' : 'break'}"></div>
                      <span><c:out value="${log.description}"/></span>
                      <span class="log-time"><c:out value="${log.duration}"/></span>
                    </div>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </div>

        </div><%-- end .right-col --%>

      </div><%-- end .timer-layout --%>
    </main>
  </div><%-- end .main-content --%>
</div><%-- end .app-shell --%>

<script src="${pageContext.request.contextPath}/js/timer.js"></script>
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
<script>

function rewardCoins(reward){

    fetch("RewardCoinServlet",{

        method:"POST",

        headers:{
            "Content-Type":"application/x-www-form-urlencoded"
        },

        body:"reward="+reward

    })

    .then(response=>response.text())

    .then(coins=>{

        document.getElementById("todayCoins").innerHTML = coins;

        alert("🎉 Focus Session Completed!\n+" + reward + " Coins");

    });

}

</script>
</body>
</html>
