<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>ScholarSync — Activities</title>
     <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .activities-layout {
      display: grid;
      grid-template-columns: 1fr 400px;
      gap: 24px;
      align-items: start;
    }

    /* ── LEFT PANE ── */
    .filter-tabs {
      display: flex;
      gap: 6px;
      margin-bottom: 20px;
      background: var(--mint);
      padding: 5px;
      border-radius: var(--radius-md);
      border: 1.5px solid var(--mint-mid);
    }
    .filter-tab {
      flex: 1;
      padding: 9px 10px;
      border-radius: 10px;
      background: transparent;
      font-weight: 700;
      font-size: .82rem;
      color: var(--text-muted);
      border: none;
      cursor: pointer;
      transition: all var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
    }
    .filter-tab.active {
      background: var(--white);
      color: var(--green-deep);
      box-shadow: var(--shadow-sm);
    }
    .filter-tab .tab-count {
      width: 20px; height: 20px;
      border-radius: 50%;
      background: var(--mint-mid);
      font-size: .68rem;
      font-weight: 800;
      display: flex; align-items: center; justify-content: center;
    }
    .filter-tab.active .tab-count { background: var(--green-dark); color: var(--white); }
    .filter-tab.overdue-tab.active { color: var(--error); }
    .filter-tab.overdue-tab.active .tab-count { background: var(--error); }

    /* Search bar */
    .search-bar {
      position: relative;
      margin-bottom: 16px;
    }
    .search-bar .search-icon {
      position: absolute;
      left: 12px; top: 50%;
      transform: translateY(-50%);
      color: var(--text-muted);
      font-size: .9rem;
    }
    .search-bar input {
      padding-left: 36px;
    }

    /* Activity cards list */
    .activity-list {
      display: flex;
      flex-direction: column;
      gap: 12px;
    }
    .activity-card {
      background: var(--white);
      border-radius: var(--radius-lg);
      border: 1.5px solid var(--mint-mid);
      padding: 16px 20px;
      display: flex;
      align-items: flex-start;
      gap: 14px;
      box-shadow: var(--shadow-sm);
      transition: all var(--transition);
      cursor: pointer;
    }
    .activity-card:hover {
      border-color: var(--green);
      box-shadow: var(--shadow-md);
      transform: translateY(-1px);
    }
    .activity-card.overdue {
      border-color: #f5c6c6;
      background: var(--error-bg);
    }
    .activity-card.completed {
      opacity: .65;
    }
    .activity-card.completed .act-title {
      text-decoration: line-through;
      color: var(--text-muted);
    }

    .act-check {
      width: 22px; height: 22px;
      border-radius: 50%;
      border: 2px solid var(--green);
      display: flex; align-items: center; justify-content: center;
      flex-shrink: 0;
      margin-top: 2px;
      cursor: pointer;
      transition: all var(--transition);
      font-size: .7rem;
    }
    .act-check.done {
      background: var(--green-dark);
      border-color: var(--green-dark);
      color: var(--white);
    }
    .act-check.overdue-check { border-color: var(--error); }

    .act-body { flex: 1; }
    .act-title {
      font-size: .95rem;
      font-weight: 700;
      color: var(--text);
      margin-bottom: 4px;
    }
    .act-details {
      font-size: .78rem;
      color: var(--text-soft);
      font-weight: 500;
      margin-bottom: 8px;
    }
    .act-meta {
      display: flex;
      align-items: center;
      gap: 8px;
      flex-wrap: wrap;
    }
    .act-tag {
      display: flex;
      align-items: center;
      gap: 4px;
      font-size: .72rem;
      font-weight: 700;
      color: var(--text-soft);
    }

    .act-actions {
      display: flex;
      gap: 6px;
      flex-shrink: 0;
      flex-direction: column;
    }
    .act-btn {
      width: 30px; height: 30px;
      border-radius: var(--radius-sm);
      border: 1.5px solid var(--mint-mid);
      background: var(--mint);
      color: var(--text-muted);
      font-size: .85rem;
      display: flex; align-items: center; justify-content: center;
      cursor: pointer;
      transition: all var(--transition);
    }
    .act-btn:hover { background: var(--green); color: var(--green-deep); border-color: var(--green); }
    .act-btn.del:hover { background: var(--error-bg); color: var(--error); border-color: #f5c6c6; }

    /* ── RIGHT PANE — ADD FORM ── */
    .form-card {
      position: sticky;
      top: calc(var(--header-h) + 20px);
    }
    .form-card .card-title { margin-bottom: 20px; }

    .day-checkboxes {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
    }
    .day-chip {
      padding: 6px 12px;
      border-radius: 99px;
      border: 1.5px solid var(--mint-mid);
      background: var(--mint);
      font-size: .78rem;
      font-weight: 700;
      color: var(--text-soft);
      cursor: pointer;
      transition: all var(--transition);
      user-select: none;
    }
    .day-chip.selected {
      background: var(--green-dark);
      border-color: var(--green-dark);
      color: var(--white);
    }
    .day-chip:hover:not(.selected) {
      border-color: var(--green);
      color: var(--green-deep);
    }

    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 12px;
    }

    /* Empty state */
    .empty-state {
      text-align: center;
      padding: 48px 24px;
      color: var(--text-muted);
    }
    .empty-state .empty-icon { font-size: 3rem; margin-bottom: 12px; }
    .empty-state p { font-size: .88rem; font-weight: 600; }

    @media (max-width: 1000px) {
      .activities-layout { grid-template-columns: 1fr; }
      .form-card { position: static; }
    }
  </style>
</head>
<body>
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
      <a href="${pageContext.request.contextPath}/ActivityServlet" class="nav-item active"><span class="nav-icon">✅</span><span class="nav-label">Activities</span></a>
      <a href="${pageContext.request.contextPath}/TimerServlet"      class="nav-item"><span class="nav-icon">⏱️</span><span class="nav-label">Study Timer</span></a>
      <a href="${pageContext.request.contextPath}/GardenServlet"     class="nav-item"><span class="nav-icon">🌿</span><span class="nav-label">Plant Garden</span></a>
      <a href="${pageContext.request.contextPath}/SettingsServlet"      class="nav-item"><span class="nav-icon">⚙️</span><span class="nav-label">Settings</span></a>
    </nav>
    <div class="sidebar-bottom">
      <a href="${pageContext.request.contextPath}/LogoutServlet" class="nav-item logout">
        <span class="nav-icon">🚪</span><span class="nav-label">Logout</span>
      </a>
    </div>
  </aside>

  <div class="main-content">
    <header class="top-header">
      <div class="header-title">Activities</div>
      <div class="header-right">
        <button class="btn btn-primary btn-sm" onclick="focusForm()" title="Ctrl+N">
          ＋ Add Activity
        </button>
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
      <!-- Top error alert (hidden by default) -->
      <div class="alert-box alert-error" id="globalAlert" style="display:none;">
        <span>⚠️</span><span id="globalAlertMsg">Please fill in all required fields.</span>
      </div>

      <div class="activities-layout">
        <div>

          <!-- FILTER TABS -->
          <div class="filter-tabs">
            <button class="filter-tab active" onclick="setTab('current', this)">
              📋 Current
            </button>
            <button class="filter-tab" onclick="setTab('past', this)">
              ✅ Completed
            </button>
            <button class="filter-tab overdue-tab" onclick="setTab('overdue', this)">
              ⚠️ Overdue
            </button>
          </div>

          <!-- SEARCH -->
          <div class="search-bar">
            <span class="search-icon">🔍</span>
            <input
                class="form-input"
                type="text"
                placeholder="Search..."
                oninput="filterActivities(this.value)">
          </div>

          <!-- ================= CURRENT ================= -->
          <div class="activity-list" id="listCurrent">
            <c:forEach var="a" items="${activities}">
              <c:if test="${a.status == 'Current'}">
                <div class="activity-card" data-title="${a.title}">
                  <div class="act-check" onclick="toggleCheck(this)"></div>
                  <div class="act-body">
                    <div class="act-title">${a.title}</div>
                    <div class="act-details">${a.details}</div>
                    <div class="act-meta">
                      <span class="act-tag">
                        📚 ${a.subjectCode} - ${a.subjectName}
                      </span>
                      <span class="act-tag">
                        📅
                        <fmt:formatDate value="${a.activityDate}" pattern="MMM dd, yyyy"/>
                      </span>
                      <span class="act-tag">
                        🕐
                        <fmt:formatDate value="${a.activityTime}" pattern="hh:mm a"/>
                      </span>
                      <span class="act-tag">
                        🔁 ${a.activityDays}
                      </span>
                    </div>
                  </div>
                  <div class="act-actions">
                    <a class="act-btn" href="ActivityServlet?action=edit&id=${a.activityID}">✏️</a>
                    <a class="act-btn del"
                       href="ActivityServlet?action=delete&id=${a.activityID}"
                       onclick="return confirm('Delete this activity?')">🗑️</a>
                  </div>
                </div>
              </c:if>
            </c:forEach>
          </div>

          <!-- ================= COMPLETED ================= -->
          <div class="activity-list" id="listPast" style="display:none;">
            <c:forEach var="a" items="${activities}">
              <c:if test="${a.status == 'Completed'}">
                <div class="activity-card completed">
                  <div class="act-check done">✓</div>
                  <div class="act-body">
                    <div class="act-title">${a.title}</div>
                    <div class="act-details">${a.details}</div>
                    <div class="act-meta">
                      <span class="act-tag">
                        📚 ${a.subjectCode} - ${a.subjectName}
                      </span>
                      <span class="act-tag">
                        📅
                        <fmt:formatDate value="${a.activityDate}" pattern="MMM dd, yyyy"/>
                      </span>
                      <span class="badge badge-green">Completed</span>
                    </div>
                  </div>
                  <div class="act-actions">
                    <a class="act-btn del"
                       href="ActivityServlet?action=delete&id=${a.activityID}"
                       onclick="return confirm('Delete this activity?')">🗑️</a>
                  </div>
                </div>
              </c:if>
            </c:forEach>
          </div>

          <!-- ================= OVERDUE ================= -->
          <div class="activity-list" id="listOverdue" style="display:none;">
            <c:forEach var="a" items="${activities}">
              <c:if test="${a.status == 'Overdue'}">
                <div class="activity-card overdue">
                  <div class="act-check overdue-check"></div>
                  <div class="act-body">
                    <div class="act-title">${a.title}</div>
                    <div class="act-details">${a.details}</div>
                    <div class="act-meta">
                      <span class="act-tag">
                        📚 ${a.subjectCode} - ${a.subjectName}
                      </span>
                      <span class="act-tag">
                        📅
                        <fmt:formatDate value="${a.activityDate}" pattern="MMM dd, yyyy"/>
                      </span>
                      <span class="badge badge-red">Overdue</span>
                    </div>
                  </div>
                  <div class="act-actions">
                    <a class="act-btn" href="ActivityServlet?action=edit&id=${a.activityID}">✏️</a>
                    <a class="act-btn del"
                       href="ActivityServlet?action=delete&id=${a.activityID}"
                       onclick="return confirm('Delete this activity?')">🗑️</a>
                  </div>
                </div>
              </c:if>
            </c:forEach>
          </div>

        </div>

        <!-- RIGHT PANE — ADD FORM -->
        <div class="card form-card">
          <form action="ActivityServlet" method="post" id="activityForm">
            <input type="hidden" name="action" value="add">

            <div class="card-title" id="formTitle">
              <div class="card-title-icon">＋</div>
              <span>Add Activity</span>
            </div>

            <div class="form-group">
              <label class="form-label">Title</label>
              <input class="form-input" type="text" id="actTitle" name="title" required>
              <span class="form-error" id="errTitle" style="display:none;">Title is required.</span>
            </div>

            <div class="form-group">
              <label class="form-label">Details</label>
              <textarea class="form-textarea" id="actDetails" name="details"></textarea>
            </div>

            <div class="form-group">
              <label class="form-label">Subject</label>
              <select class="form-select" id="actSubject" name="subjectID" required>
                <option value="">Select Subject</option>
<c:forEach var="s" items="${subjects}">
    <option value="${s.subjectID}">
        ${s.subjectCode} - ${s.subjectName}
    </option>
</c:forEach>
              </select>
              <span class="form-error" id="errSubject" style="display:none;">Subject is required.</span>
            </div>

            <div class="form-group">
              <label class="form-label">Date</label>
              <input class="form-input" type="date" id="actDate" name="activityDate" required>
            </div>

            <div class="form-group">
              <label class="form-label">Time</label>
              <input class="form-input" type="time" id="actTime" name="activityTime" required>
              <span class="form-error" id="errTime" style="display:none;">Time is required.</span>
            </div>

            <div class="form-group">
              <label class="form-label">Day(s)</label>
              <input class="form-input" type="text" id="actDays" name="activityDays" placeholder="Monday, Wednesday">
            </div>

            <button type="submit" class="btn btn-primary">
              💾 Save Activity
            </button>
          </form>
        </div>
      </div>
    </main>
  </div>
</div>

<!-- Toast -->
<div class="toast" id="saveToast" style="display:none;">✅ Activity saved successfully!</div>

<script src="app.js"></script>
<script>
  function setTab(tab, btn) {
    document.querySelectorAll('.filter-tab').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    document.getElementById('listCurrent').style.display = tab === 'current' ? 'flex' : 'none';
    document.getElementById('listPast').style.display    = tab === 'past'    ? 'flex' : 'none';
    document.getElementById('listOverdue').style.display = tab === 'overdue' ? 'flex' : 'none';
    if (tab === 'current') document.getElementById('listCurrent').style.flexDirection = 'column';
    if (tab === 'past')    document.getElementById('listPast').style.flexDirection    = 'column';
    if (tab === 'overdue') document.getElementById('listOverdue').style.flexDirection = 'column';
  }

  function toggleDay(el) { el.classList.toggle('selected'); }

  function toggleCheck(el) {
    el.classList.toggle('done');
    el.textContent = el.classList.contains('done') ? '✓' : '';
    el.closest('.activity-card').classList.toggle('completed', el.classList.contains('done'));
  }

  function deleteActivity(btn) {
    const card = btn.closest('.activity-card');
    card.style.opacity = '0';
    card.style.transform = 'translateX(20px)';
    card.style.transition = 'all .3s ease';
    setTimeout(() => card.remove(), 300);
  }

  function editActivity(btn) {
    const card = btn.closest('.activity-card');
    const title = card.querySelector('.act-title').textContent;
    document.getElementById('actTitle').value = title;
    document.getElementById('formTitle').textContent = 'Edit Activity';
    document.getElementById('activityForm').scrollIntoView({ behavior: 'smooth' });
  }

  function focusForm() {
    document.getElementById('actTitle').focus();
  }

  function filterActivities(q) {
    document.querySelectorAll('.activity-card').forEach(card => {
      const title = card.dataset.title || card.querySelector('.act-title').textContent;
      card.style.display = title.toLowerCase().includes(q.toLowerCase()) ? '' : 'none';
    });
  }

  function clearForm() {
    ['actTitle','actDetails','actTime'].forEach(id => document.getElementById(id).value = '');
    document.getElementById('actSubject').value = '';
    document.querySelectorAll('.day-chip').forEach(c => c.classList.remove('selected'));
    document.getElementById('formTitle').textContent = 'Add Activity';
    ['errTitle','errSubject','errTime'].forEach(id => document.getElementById(id).style.display = 'none');
    ['actTitle','actSubject','actTime'].forEach(id => document.getElementById(id).classList.remove('error'));
  }

  // Keyboard shortcut Ctrl+N
  document.addEventListener('keydown', e => {
    if (e.ctrlKey && e.key === 'n') { e.preventDefault(); focusForm(); }
    if (e.key === 'Escape') document.getElementById('globalAlert').style.display = 'none';
  });
</script>
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
