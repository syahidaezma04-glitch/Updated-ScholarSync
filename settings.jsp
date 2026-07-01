<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>ScholarSync — Settings</title>
     <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .settings-layout {
      display: grid;
      grid-template-columns: 220px 1fr;
      gap: 24px;
      align-items: start;
    }

    /* ── SETTINGS NAV ── */
    .settings-nav {
      background: var(--white);
      border-radius: var(--radius-lg);
      border: 1.5px solid var(--mint-mid);
      overflow: hidden;
      position: sticky;
      top: calc(var(--header-h) + 20px);
      box-shadow: var(--shadow-sm);
    }
    .settings-nav-header {
      padding: 14px 18px;
      font-size: .72rem;
      font-weight: 800;
      color: var(--text-muted);
      text-transform: uppercase;
      letter-spacing: .08em;
      border-bottom: 1.5px solid var(--mint-mid);
      background: var(--mint);
    }
    .settings-nav-item {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 12px 18px;
      font-size: .88rem;
      font-weight: 600;
      color: var(--text-soft);
      cursor: pointer;
      transition: all var(--transition);
      border-bottom: 1px solid var(--mint-mid);
    }
    .settings-nav-item:last-child { border-bottom: none; }
    .settings-nav-item:hover { background: var(--mint); color: var(--green-deep); }
    .settings-nav-item.active {
      background: var(--mint-mid);
      color: var(--green-deep);
      border-left: 3px solid var(--green-dark);
      padding-left: 15px;
    }
    .settings-nav-item .s-icon { font-size: 1rem; }

    /* ── SETTINGS PANELS ── */
    .settings-panel { display: none; flex-direction: column; gap: 20px; }
    .settings-panel.active { display: flex; }

    .settings-section {
      background: var(--white);
      border-radius: var(--radius-lg);
      border: 1.5px solid var(--mint-mid);
      overflow: hidden;
      box-shadow: var(--shadow-sm);
    }
    .section-header {
      padding: 16px 24px;
      background: var(--mint);
      border-bottom: 1.5px solid var(--mint-mid);
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .section-header h3 {
      font-size: .95rem;
      font-weight: 800;
      color: var(--green-deep);
    }
    .section-header p {
      font-size: .75rem;
      color: var(--text-muted);
      font-weight: 500;
      margin-top: 1px;
    }
    .section-body { padding: 20px 24px; display: flex; flex-direction: column; gap: 16px; }

    /* Setting row */
    .setting-row {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
      padding: 12px 0;
      border-bottom: 1px solid var(--mint-mid);
    }
    .setting-row:last-child { border-bottom: none; padding-bottom: 0; }
    .setting-info { flex: 1; }
    .setting-label {
      font-size: .9rem;
      font-weight: 700;
      color: var(--text);
    }
    .setting-desc {
      font-size: .75rem;
      color: var(--text-muted);
      font-weight: 500;
      margin-top: 2px;
    }
    .setting-control { flex-shrink: 0; }

    /* Toggle switch */
    .toggle-switch {
      position: relative;
      width: 46px;
      height: 26px;
      display: inline-block;
    }
    .toggle-switch input { opacity: 0; width: 0; height: 0; }
    .toggle-slider {
      position: absolute;
      inset: 0;
      background: var(--mint-mid);
      border-radius: 99px;
      cursor: pointer;
      transition: background var(--transition);
    }
    .toggle-slider::before {
      content: '';
      position: absolute;
      width: 20px; height: 20px;
      left: 3px; top: 3px;
      background: var(--white);
      border-radius: 50%;
      transition: transform var(--transition);
      box-shadow: 0 1px 4px rgba(0,0,0,.15);
    }
    .toggle-switch input:checked + .toggle-slider { background: var(--green-dark); }
    .toggle-switch input:checked + .toggle-slider::before { transform: translateX(20px); }

    /* Select control */
    .setting-select {
      padding: 7px 12px;
      border: 1.5px solid var(--mint-mid);
      border-radius: var(--radius-sm);
      background: var(--mint);
      font-family: 'Nunito', sans-serif;
      font-size: .85rem;
      font-weight: 600;
      color: var(--text);
      cursor: pointer;
      outline: none;
      min-width: 140px;
    }
    .setting-select:focus { border-color: var(--green-dark); background: var(--white); }

    /* Range slider */
    .range-wrap { display: flex; align-items: center; gap: 10px; min-width: 180px; }
    .range-wrap input[type=range] {
      flex: 1;
      accent-color: var(--green-dark);
      height: 4px;
    }
    .range-val {
      font-family: 'DM Mono', monospace;
      font-size: .82rem;
      font-weight: 500;
      color: var(--green-deep);
      min-width: 32px;
      text-align: right;
    }

    /* Color swatches */
    .color-swatches { display: flex; gap: 8px; }
    .swatch {
      width: 28px; height: 28px;
      border-radius: 50%;
      cursor: pointer;
      border: 3px solid transparent;
      transition: border-color var(--transition), transform var(--transition);
    }
    .swatch:hover, .swatch.active {
      border-color: var(--green-deep);
      transform: scale(1.15);
    }

    /* Profile card */
    .profile-card {
      display: flex;
      align-items: center;
      gap: 18px;
      padding: 20px 24px;
      border-bottom: 1.5px solid var(--mint-mid);
    }
    .avatar-circle {
      width: 64px; height: 64px;
      border-radius: 50%;
      background: linear-gradient(135deg, var(--green-dark), var(--green-deep));
      display: flex; align-items: center; justify-content: center;
      font-size: 1.6rem;
      color: var(--white);
      font-weight: 800;
      flex-shrink: 0;
      position: relative;
    }
    .avatar-edit {
      position: absolute;
      bottom: 0; right: 0;
      width: 22px; height: 22px;
      background: var(--white);
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      font-size: .7rem;
      box-shadow: var(--shadow-sm);
      cursor: pointer;
      border: 1.5px solid var(--mint-mid);
    }
    .profile-info h3 { font-size: 1rem; font-weight: 800; color: var(--text); }
    .profile-info p  { font-size: .8rem; color: var(--text-muted); font-weight: 500; }

    /* Danger zone */
    .danger-zone {
      border-color: #f5c6c6 !important;
    }
    .danger-zone .section-header { background: var(--error-bg); border-color: #f5c6c6; }
    .danger-zone .section-header h3 { color: var(--error); }
    .btn-danger {
      background: var(--error-bg);
      color: var(--error);
      border: 1.5px solid #f5c6c6;
    }
    .btn-danger:hover { background: var(--error); color: var(--white); }

    /* Save bar */
    .save-bar {
      position: fixed;
      bottom: 0; left: var(--sidebar-w); right: 0;
      background: var(--white);
      border-top: 1.5px solid var(--mint-mid);
      padding: 14px 28px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      z-index: 50;
      box-shadow: 0 -4px 20px rgba(45,58,46,.08);
    }
    .save-bar p { font-size: .82rem; color: var(--text-muted); font-weight: 600; }

    @media (max-width: 900px) {
      .settings-layout { grid-template-columns: 1fr; }
      .settings-nav { position: static; }
      .save-bar { left: var(--sidebar-icon); }
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
      <a href="${pageContext.request.contextPath}/DashboardServlet"  class="nav-item"><span class="nav-icon">🏠</span><span class="nav-label">Dashboard</span></a>
      <a href="${pageContext.request.contextPath}/CalendarServlet"   class="nav-item"><span class="nav-icon">📅</span><span class="nav-label">Calendar</span></a>
      <a href="${pageContext.request.contextPath}/ActivityServlet" class="nav-item"><span class="nav-icon">✅</span><span class="nav-label">Activities</span></a>
      <a href="${pageContext.request.contextPath}/TimerServlet"      class="nav-item"><span class="nav-icon">⏱️</span><span class="nav-label">Study Timer</span></a>
      <a href="${pageContext.request.contextPath}/GardenServlet"     class="nav-item"><span class="nav-icon">🌿</span><span class="nav-label">Plant Garden</span></a>
      <a href="${pageContext.request.contextPath}/SettingsServlet"      class="nav-item active"><span class="nav-icon">⚙️</span><span class="nav-label">Settings</span></a>
    </nav>
    <div class="sidebar-bottom">
      <a href="${pageContext.request.contextPath}/LogoutServlet" class="nav-item logout">
        <span class="nav-icon">🚪</span><span class="nav-label">Logout</span>
      </a>
    </div>
  </aside>  <%-- ═══════════════ SIDEBAR ═══════════════ --%>
  <
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
      <div class="settings-layout">

        <!-- LEFT NAV -->
        <div class="settings-nav">
          <div class="settings-nav-header">Settings</div>
          <div class="settings-nav-item" onclick="showPanel('profile', this)">
            <span class="s-icon">👤</span> Profile
          </div>
          <div class="settings-nav-item" onclick="showPanel('appearance', this)">
            <span class="s-icon">🎨</span> Appearance
          </div>
          <div class="settings-nav-item" onclick="showPanel('timer', this)">
            <span class="s-icon">⏱️</span> Timer
          </div>
          <div class="settings-nav-item" onclick="showPanel('notifications', this)">
            <span class="s-icon">🔔</span> Notifications
          </div>
          <div class="settings-nav-item" onclick="showPanel('subjects', this)">
            <span class="s-icon">📚</span> Subjects
          </div>
          <div class="settings-nav-item" onclick="showPanel('data', this)">
            <span class="s-icon">🗂️</span> Data & Privacy
          </div>
        </div>

        <!-- RIGHT PANELS -->
        <div>

          <!-- ============ PROFILE PANEL ============ -->
          <div class="settings-panel active" id="panelProfile">

            <form action="ProfileServlet" method="post">
              <div class="settings-section">
                <div class="section-header">
                  <div>
                    <h3>👤 Profile</h3>
                    <p>Manage your personal information</p>
                  </div>
                </div>
                <div class="profile-card">
                  <div class="avatar-circle">
                    JS
                    <div class="avatar-edit">✏️</div>
                  </div>
                  <div class="profile-info">
                    <h3>${user.fullName}</h3>
                    <p>${user.email}</p>
                  </div>
                </div>
                <div class="section-body">
                  <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <input class="form-input" type="text" name="fullName" value="${user.fullName}" />
                  </div>
                  <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <input class="form-input"
                           type="email"
                           name="email"
                           value="${user.email}" />
                  </div>
                  <div class="form-group">
                    <label class="form-label">University / Institution</label>
                    <input class="form-input"
                           type="text"
                           name="university"
                           value="${user.university}" />
                  </div>
                  <div class="form-group">
                    <label class="form-label">Year Level</label>
                    <select class="form-select" name="yearLevel">
                      <option value="1st Year" ${user.yearLevel=="1st Year" ? "selected" : ""}>1st Year</option>
                      <option value="2nd Year" ${user.yearLevel=="2nd Year" ? "selected" : ""}>2nd Year</option>
                      <option value="3rd Year" ${user.yearLevel=="3rd Year" ? "selected" : ""}>3rd Year</option>
                      <option value="4th Year" ${user.yearLevel=="4th Year" ? "selected" : ""}>4th Year</option>
                    </select>
                  </div>
                  <div style="margin-top:20px;">
                    <button type="submit" class="btn btn-primary">
                      Save Profile
                    </button>
                  </div>
                </div>
              </div>
            </form>

            <div class="settings-section">
              <div class="section-header">
                <div>
                  <h3>🔒 Change Password</h3>
                  <p>Update your account password</p>
                </div>
              </div>

              <div class="section-body">

                <% if(request.getAttribute("msg") != null){ %>
                  <p style="color:red; margin-bottom:15px;">
                    <%= request.getAttribute("msg") %>
                  </p>
                <% } %>

                <form action="PasswordServlet" method="post">

                  <div class="form-group">
                    <label class="form-label">Current Password</label>
                    <input class="form-input"
                           type="password"
                           name="currentPassword"
                           placeholder="Enter current password"
                           required />
                  </div>

                  <div class="form-group">
                    <label class="form-label">New Password</label>
                    <input class="form-input"
                           type="password"
                           name="newPassword"
                           placeholder="Enter new password"
                           required />
                  </div>

                  <div class="form-group">
                    <label class="form-label">Confirm New Password</label>
                    <input class="form-input"
                           type="password"
                           name="confirmPassword"
                           placeholder="Repeat new password"
                           required />
                  </div>

                  <div style="margin-top:20px;">
                    <button type="submit" class="btn btn-primary">
                      Change Password
                    </button>
                  </div>

                </form>

              </div>
            </div>

          </div>
          <!-- ============ END PROFILE PANEL ============ -->


          <!-- ============ APPEARANCE PANEL ============ -->
          <!-- TODO: no backing bean yet for appearance — wire to an
               `appearance` request/session attribute once it exists in DB.
               Suggested fields: appearance.darkMode (boolean),
               appearance.accentColor (String hex), appearance.fontSize
               (String), appearance.sidebarStyle (String), appearance.animations (boolean) -->
          <div class="settings-panel" id="panelAppearance">
            <div class="settings-section">
              <div class="section-header">
                <div><h3>🎨 Appearance</h3><p>Personalise how ScholarSync looks</p></div>
              </div>
              <div class="section-body">
                <div class="setting-row">
                  <div class="setting-info">
                    <div class="setting-label">Dark Mode</div>
                    <div class="setting-desc">Switch to a darker interface for low-light studying</div>
                  </div>
                  <div class="setting-control">
                    <label class="toggle-switch">
                      <input type="checkbox" onchange="toggleDark()" id="darkToggle" />
                      <span class="toggle-slider"></span>
                    </label>
                  </div>
                </div>
                <div class="setting-row">
                  <div class="setting-info">
                    <div class="setting-label">Accent Colour</div>
                    <div class="setting-desc">Choose the highlight colour used throughout the app</div>
                  </div>
                  <div class="setting-control">
                    <div class="color-swatches">
                      <div class="swatch active" style="background:#6B9E78;" title="Sage Green" onclick="setSwatch(this)"></div>
                      <div class="swatch" style="background:#E07090;" title="Blush Pink" onclick="setSwatch(this)"></div>
                      <div class="swatch" style="background:#5B8CCC;" title="Sky Blue" onclick="setSwatch(this)"></div>
                      <div class="swatch" style="background:#C8A800;" title="Golden" onclick="setSwatch(this)"></div>
                      <div class="swatch" style="background:#9B59B6;" title="Lavender" onclick="setSwatch(this)"></div>
                    </div>
                  </div>
                </div>
                <div class="setting-row">
                  <div class="setting-info">
                    <div class="setting-label">Font Size</div>
                    <div class="setting-desc">Adjust the base text size</div>
                  </div>
                  <div class="setting-control">
                    <select class="setting-select">
                      <option>Small (14px)</option>
                      <option selected>Default (16px)</option>
                      <option>Large (18px)</option>
                    </select>
                  </div>
                </div>
                <div class="setting-row">
                  <div class="setting-info">
                    <div class="setting-label">Sidebar Style</div>
                    <div class="setting-desc">Show text labels or icons only</div>
                  </div>
                  <div class="setting-control">
                    <select class="setting-select">
                      <option selected>Full (icons + text)</option>
                      <option>Icons only</option>
                    </select>
                  </div>
                </div>
                <div class="setting-row">
                  <div class="setting-info">
                    <div class="setting-label">Animations</div>
                    <div class="setting-desc">Enable smooth transitions and micro-interactions</div>
                  </div>
                  <div class="setting-control">
                    <label class="toggle-switch">
                      <input type="checkbox" checked />
                      <span class="toggle-slider"></span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- ============ END APPEARANCE PANEL ============ -->


          <!-- ============ TIMER PANEL ============ -->
          <div class="settings-panel" id="panelTimer">
            <form action="TimerServlet" method="post">

              <div class="settings-section">
                <div class="section-header">
                  <div><h3>⏱️ Pomodoro Timer</h3><p>Customise your focus and break durations</p></div>
                </div>
                <div class="section-body">
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Focus Session Length</div>
                      <div class="setting-desc">Duration of each focus block</div>
                    </div>
                    <div class="setting-control">
                      <div class="range-wrap">
                        <input
                          type="range"
                          name="focusTime"
                          min="15"
                          max="60"
                          value="${setting.focusTime}"
                          oninput="this.nextElementSibling.textContent=this.value+'m'">

                        <span class="range-val">
                          ${setting.focusTime}m
                        </span>
                      </div>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Short Break Length</div>
                      <div class="setting-desc">Break after each focus session</div>
                    </div>
                    <div class="setting-control">
                      <div class="range-wrap">
                        <input
                          type="range"
                          name="shortBreak"
                          min="3"
                          max="15"
                          value="${setting.shortBreak}"
                          oninput="this.nextElementSibling.textContent=this.value+'m'">

                        <span class="range-val">
                          ${setting.shortBreak}m
                        </span>
                      </div>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Long Break Length</div>
                      <div class="setting-desc">Break after every 4 sessions</div>
                    </div>
                    <div class="setting-control">
                      <div class="range-wrap">
                        <input
                          type="range"
                          name="longBreak"
                          min="10"
                          max="30"
                          value="${setting.longBreak}"
                          oninput="this.nextElementSibling.textContent=this.value+'m'">

                        <span class="range-val">
                          ${setting.longBreak}m
                        </span>
                      </div>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Sessions Until Long Break</div>
                      <div class="setting-desc">Number of focus blocks before a long break</div>
                    </div>
                    <div class="setting-control">
                      <select name="sessionsUntilLongBreak" class="setting-select">
                        <option value="2" ${timer.sessionsUntilLongBreak==2?'selected':''}>2 Sessions</option>
                        <option value="3" ${timer.sessionsUntilLongBreak==3?'selected':''}>3 Sessions</option>
                        <option value="4" ${timer.sessionsUntilLongBreak==4?'selected':''}>4 Sessions</option>
                      </select>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Auto-start Breaks</div>
                      <div class="setting-desc">Automatically begin the break timer when a session ends</div>
                    </div>
                    <div class="setting-control">
                      <label class="toggle-switch">
                        <input type="checkbox" />
                        <span class="toggle-slider"></span>
                      </label>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Auto-start Next Session</div>
                      <div class="setting-desc">Automatically resume focus after a break</div>
                    </div>
                    <div class="setting-control">
                      <label class="toggle-switch">
                        <input
                          type="checkbox"
                          name="autoBreak"
                          value="true"
                          ${timer.autoBreak ? 'checked' : ''}>
                        <span class="toggle-slider"></span>
                      </label>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Coins Per Session</div>
                      <div class="setting-desc">Coins earned after completing a focus block</div>
                    </div>
                    <div class="setting-control">
                      <select class="setting-select" name="coinsPerSession">
                        <option value="3" ${setting.coinsPerSession==3?'selected':''}>+3 🪙</option>
                        <option value="5" ${setting.coinsPerSession==5?'selected':''}>+5 🪙</option>
                        <option value="10" ${setting.coinsPerSession==10?'selected':''}>+10 🪙</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>

              <div style="margin-top:16px;">
                <button type="submit" class="btn btn-primary">
                  Save Timer
                </button>
              </div>

            </form>
          </div>
          <!-- ============ END TIMER PANEL ============ -->


          <!-- ============ NOTIFICATIONS PANEL ============ -->
          
          <div class="settings-panel" id="panelNotifications">
            <form action="NotificationServlet" method="post">
              <div class="settings-section">
                <div class="section-header">
                  <div><h3>🔔 Notifications</h3><p>Control when ScholarSync alerts you</p></div>
                </div>
                <div class="section-body">
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Session Complete Sound</div>
                      <div class="setting-desc">Play a sound when a Pomodoro session ends</div>
                    </div>
                    <div class="setting-control">
                      <label class="toggle-switch">
                        <input type="checkbox" name="sessionCompleteSound" value="true"
                               ${notification.sessionCompleteSound ? 'checked' : ''} />
                        <span class="toggle-slider"></span>
                      </label>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Sound Theme</div>
                      <div class="setting-desc">Choose the alert sound style</div>
                    </div>
                    <div class="setting-control">
                      <select class="setting-select" name="soundTheme">
                        <option value="Forest Birds" ${notification.soundTheme=="Forest Birds" ? "selected" : ""}>Forest Birds 🐦</option>
                        <option value="Gentle Bell" ${notification.soundTheme=="Gentle Bell" ? "selected" : ""}>Gentle Bell 🔔</option>
                        <option value="Digital Ping" ${notification.soundTheme=="Digital Ping" ? "selected" : ""}>Digital Ping</option>
                        <option value="None" ${notification.soundTheme=="None" ? "selected" : ""}>None</option>
                      </select>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Volume</div>
                      <div class="setting-desc">Alert sound volume</div>
                    </div>
                    <div class="setting-control">
                      <div class="range-wrap">
                        <input type="range" name="volume" min="0" max="100" value="${notification.volume}"
                          oninput="this.nextElementSibling.textContent=this.value+'%'" />
                        <span class="range-val">${notification.volume}%</span>
                      </div>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Task Due Reminders</div>
                      <div class="setting-desc">Get notified before tasks are due</div>
                    </div>
                    <div class="setting-control">
                      <label class="toggle-switch">
                        <input type="checkbox" name="taskDueReminders" value="true"
                               ${notification.taskDueReminders ? 'checked' : ''} />
                        <span class="toggle-slider"></span>
                      </label>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Remind Me</div>
                      <div class="setting-desc">How early to send task reminders</div>
                    </div>
                    <div class="setting-control">
                      <select class="setting-select" name="remindMeBefore">
                        <option value="30" ${notification.remindMeBefore==30 ? "selected" : ""}>30 minutes before</option>
                        <option value="60" ${notification.remindMeBefore==60 ? "selected" : ""}>1 hour before</option>
                        <option value="120" ${notification.remindMeBefore==120 ? "selected" : ""}>2 hours before</option>
                        <option value="1440" ${notification.remindMeBefore==1440 ? "selected" : ""}>1 day before</option>
                      </select>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Daily Study Reminder</div>
                      <div class="setting-desc">A daily nudge to start your study sessions</div>
                    </div>
                    <div class="setting-control">
                      <label class="toggle-switch">
                        <input type="checkbox" name="dailyReminder" value="true"
                               ${notification.dailyReminder ? 'checked' : ''} />
                        <span class="toggle-slider"></span>
                      </label>
                    </div>
                  </div>
                  <div class="setting-row">
                    <div class="setting-info">
                      <div class="setting-label">Reminder Time</div>
                      <div class="setting-desc">When the daily reminder fires</div>
                    </div>
                    <div class="setting-control">
                      <input class="form-input" type="time" name="reminderTime" value="${notification.reminderTime}"
                        style="width:120px; padding:7px 10px; font-size:.85rem;" />
                    </div>
                  </div>
                </div>
              </div>

              <div style="margin-top:16px;">
                <button type="submit" class="btn btn-primary">
                  Save Notifications
                </button>
              </div>
            </form>
          </div>
          <!-- ============ END NOTIFICATIONS PANEL ============ -->


          <!-- ============ SUBJECTS PANEL ============ -->
<!-- ================= SUBJECTS ================= -->
<div class="settings-panel" id="panelSubjects">

    <div class="settings-section">

        <div class="section-header">
            <div>
                <h3>📚 Subjects</h3>
                <p>Manage your subject list</p>
            </div>
        </div>

        <div class="section-body">

            <!-- Existing Subjects -->
            <c:forEach var="s" items="${subjects}">

                <form action="SubjectServlet" method="post" style="margin-bottom:20px;">

                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="subjectID" value="${s.subjectID}">

                    <div class="setting-row" style="display:block;">

                        <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">

                            <input class="form-input"
                                   type="text"
                                   name="subjectCode"
                                   value="${s.subjectCode}"
                                   required>

                            <input class="form-input"
                                   type="text"
                                   name="subjectName"
                                   value="${s.subjectName}"
                                   required>

                            <select class="setting-select"
                                    name="creditHour">

                                <option value="1" ${s.creditHour==1?'selected':''}>1 Credit Hour</option>
                                <option value="2" ${s.creditHour==2?'selected':''}>2 Credit Hours</option>
                                <option value="3" ${s.creditHour==3?'selected':''}>3 Credit Hours</option>
                                <option value="4" ${s.creditHour==4?'selected':''}>4 Credit Hours</option>
                                <option value="5" ${s.creditHour==5?'selected':''}>5 Credit Hours</option>

                            </select>

                            <input class="form-input"
                                   type="text"
                                   name="lecturerName"
                                   value="${s.lecturerName}"
                                   required>

                        </div>

                        <div style="margin-top:15px;display:flex;gap:10px;">

                            <button type="submit"
                                    class="btn btn-primary btn-sm">
                                💾 Save
                            </button>

                            <a href="DeleteSubjectServlet?id=${s.subjectID}"
                               class="btn btn-secondary btn-sm">
                                🗑 Delete
                            </a>

                        </div>

                    </div>

                </form>

            </c:forEach>

            <hr style="margin:30px 0;">

            <!-- Add Subject -->
            <h4>Add New Subject</h4>

            <form action="SubjectServlet" method="post">

                <input type="hidden" name="action" value="add">

                <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">

                    <input class="form-input"
                           type="text"
                           name="subjectCode"
                           placeholder="Subject Code"
                           required>

                    <input class="form-input"
                           type="text"
                           name="subjectName"
                           placeholder="Subject Name"
                           required>

                    <select class="setting-select"
                            name="creditHour"
                            required>

                        <option value="">Credit Hour</option>
                        <option value="1">1 Credit Hour</option>
                        <option value="2">2 Credit Hours</option>
                        <option value="3">3 Credit Hours</option>
                        <option value="4">4 Credit Hours</option>
                        <option value="5">5 Credit Hours</option>

                    </select>

                    <input class="form-input"
                           type="text"
                           name="lecturerName"
                           placeholder="Lecturer Name"
                           required>

                </div>

                <div style="margin-top:20px;">

                    <button type="submit"
                            class="btn btn-primary">
                        ➕ Add Subject
                    </button>

                </div>

            </form>

        </div>

    </div>

</div>
          <!-- ============ END SUBJECTS PANEL ============ -->


          <!-- ============ DATA PANEL ============ -->
          <div class="settings-panel" id="panelData">
            <div class="settings-section">
              <div class="section-header">
                <div><h3>🗂️ Data & Privacy</h3><p>Manage your stored data</p></div>
              </div>
              <div class="section-body">
                <div class="setting-row">
                  <div class="setting-info">
                    <div class="setting-label">Export My Data</div>
                    <div class="setting-desc">Download all your tasks, sessions, and progress as a JSON file</div>
                  </div>
                  <div class="setting-control">
                    <button class="btn btn-secondary btn-sm">⬇ Export</button>
                  </div>
                </div>
                <div class="setting-row">
                  <div class="setting-info">
                    <div class="setting-label">Clear Study History</div>
                    <div class="setting-desc">Remove all Pomodoro session logs and streak data</div>
                  </div>
                  <div class="setting-control">
                    <button class="btn btn-secondary btn-sm">🗑️ Clear History</button>
                  </div>
                </div>
                <div class="setting-row">
                  <div class="setting-info">
                    <div class="setting-label">Reset Garden</div>
                    <div class="setting-desc">Remove all plants and reset your coin balance to 0</div>
                  </div>
                  <div class="setting-control">
                    <button class="btn btn-secondary btn-sm">🌿 Reset Garden</button>
                  </div>
                </div>
              </div>
            </div>

            <div class="settings-section danger-zone">
              <div class="section-header">
                <div>
                  <h3>⚠️ Danger Zone</h3>
                  <p>Irreversible actions — proceed with care</p>
                </div>
              </div>
              <div class="section-body">
                <div class="setting-row">
                  <div class="setting-info">
                    <div class="setting-label">Delete All Tasks</div>
                    <div class="setting-desc">Permanently delete every activity and task you've created</div>
                  </div>
                  <div class="setting-control">
                    <button class="btn btn-danger btn-sm">🗑️ Delete Tasks</button>
                  </div>
                </div>
                <div class="setting-row">
                  <div class="setting-info">
                    <div class="setting-label">Delete Account</div>
                    <div class="setting-desc">Permanently remove your account and all associated data</div>
                  </div>
                  <div class="setting-control">
                    <button class="btn btn-danger btn-sm">Delete Account</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- ============ END DATA PANEL ============ -->

        </div>
      </div>
    </main>
  </div>

  <!-- Save bar -->
  <div class="save-bar">
    <p>Changes are not saved until you click Save.</p>
    <div style="display:flex; gap:10px;">
      <button class="btn btn-secondary btn-sm" onclick="discardChanges()">Discard</button>
      <button class="btn btn-primary btn-sm" onclick="saveSettings()">💾 Save Changes</button>
    </div>
  </div>
</div>

<!-- Toast -->
<div class="toast" id="saveToast" style="display:none;">✅ Settings saved!</div>

<script src="app.js"></script>
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
  function showPanel(id, navItem) {
    document.querySelectorAll('.settings-panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.settings-nav-item').forEach(n => n.classList.remove('active'));
    document.getElementById('panel' + id.charAt(0).toUpperCase() + id.slice(1)).classList.add('active');
    navItem.classList.add('active');
  }

  function setSwatch(el) {
    document.querySelectorAll('.swatch').forEach(s => s.classList.remove('active'));
    el.classList.add('active');
  }

  let subjectIndex = document.querySelectorAll('#subjectList .setting-row').length;

  function addSubject() {
    const list = document.getElementById('subjectList');
    const row = document.createElement('div');
    row.className = 'setting-row';
    row.innerHTML = `
      <div class="setting-info">
        <input class="form-input" type="text" name="subjects[${subjectIndex}].name" placeholder="Subject name" style="max-width:200px;" />
      </div>
      <div class="setting-control" style="display:flex; gap:8px;">
        <input type="color" name="subjects[${subjectIndex}].colorHex" value="#A8D5BA" style="width:36px; height:36px; border:none; border-radius:8px; cursor:pointer;" />
        <button type="button" class="btn btn-secondary btn-sm" onclick="this.closest('.setting-row').remove()">🗑️</button>
      </div>`;
    list.appendChild(row);
    row.querySelector('input[type=text]').focus();
    subjectIndex++;
  }

  function saveSettings() {
    const t = document.getElementById('saveToast');
    t.style.display = 'flex';
    setTimeout(() => { t.classList.add('hide'); setTimeout(() => { t.style.display='none'; t.classList.remove('hide'); }, 300); }, 3000);
  }

  function discardChanges() {
    window.location.reload();
  }

  // Escape closes modals
  document.addEventListener('keydown', e => {
    if (e.key === 'Escape') document.getElementById('saveToast').style.display = 'none';
  });
</script>
</body>
</html>
