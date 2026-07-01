<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>ScholarSync — Calendar</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .calendar-layout {
      display: grid;
      grid-template-columns: 1fr 300px;
      gap: 24px;
      align-items: start;
    }

    /* ── CALENDAR CARD ── */
    .calendar-card {
      background: var(--white);
      border-radius: var(--radius-xl);
      border: 1.5px solid var(--mint-mid);
      box-shadow: var(--shadow-sm);
      overflow: hidden;
    }

    /* Month nav */
    .cal-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 20px 28px;
      border-bottom: 1.5px solid var(--mint-mid);
      background: var(--mint);
    }
    .cal-month-label {
      font-size: 1.2rem;
      font-weight: 800;
      color: var(--green-deep);
    }
    .cal-nav-btn {
      width: 36px; height: 36px;
      border-radius: var(--radius-sm);
      background: var(--white);
      border: 1.5px solid var(--mint-mid);
      color: var(--text-soft);
      font-size: 1rem;
      display: flex; align-items: center; justify-content: center;
      cursor: pointer;
      transition: all var(--transition);
    }
    .cal-nav-btn:hover { background: var(--green); border-color: var(--green); color: var(--green-deep); }

    /* Legend */
    .cal-legend {
      display: flex;
      gap: 16px;
      padding: 12px 28px;
      border-bottom: 1.5px solid var(--mint-mid);
      flex-wrap: wrap;
    }
    .legend-item {
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: .72rem;
      font-weight: 700;
      color: var(--text-soft);
    }
    .legend-dot {
      width: 10px; height: 10px;
      border-radius: 50%;
    }

    /* Day-of-week header */
    .cal-dow {
      display: grid;
      grid-template-columns: repeat(7, 1fr);
      border-bottom: 1.5px solid var(--mint-mid);
    }
    .cal-dow-cell {
      padding: 10px 0;
      text-align: center;
      font-size: .72rem;
      font-weight: 800;
      color: var(--text-muted);
      text-transform: uppercase;
      letter-spacing: .06em;
    }
    .cal-dow-cell.weekend { color: var(--blush-dark); }

    /* Day grid */
    .cal-grid {
      display: grid;
      grid-template-columns: repeat(7, 1fr);
    }
    .cal-cell {
      border-right: 1px solid var(--mint-mid);
      border-bottom: 1px solid var(--mint-mid);
      min-height: 96px;
      padding: 8px;
      cursor: pointer;
      transition: background var(--transition);
      position: relative;
    }
    .cal-cell:nth-child(7n) { border-right: none; }
    .cal-cell:hover { background: var(--mint); }
    .cal-cell.other-month { opacity: .35; background: none; }
    .cal-cell.today { background: #EAF6EE; }
    .cal-cell.today .cal-day-num {
      background: var(--green-dark);
      color: var(--white);
    }
    .cal-cell.selected { background: var(--mint-mid); }

    .cal-day-num {
      width: 26px; height: 26px;
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      font-size: .8rem;
      font-weight: 800;
      color: var(--text);
      margin-bottom: 4px;
    }

    /* Event dots */
    .cal-dots {
      display: flex;
      flex-wrap: wrap;
      gap: 3px;
      margin-bottom: 4px;
    }
    .cal-dot {
      width: 8px; height: 8px;
      border-radius: 50%;
      flex-shrink: 0;
    }

    /* Event chips */
    .cal-event {
      display: block;
      font-size: .65rem;
      font-weight: 700;
      padding: 2px 6px;
      border-radius: 4px;
      margin-bottom: 2px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .ev-class   { background: var(--mint-mid);  color: var(--green-deep); }
    .ev-task    { background: var(--blush);      color: var(--blush-dark); }
    .ev-overdue { background: var(--error-bg);   color: var(--error); }
    .ev-exam    { background: var(--lavender);   color: #7B4EA6; }

    /* ── RIGHT PANEL ── */
    .right-panel { display: flex; flex-direction: column; gap: 18px; }

    /* Day detail popup-style card */
    .day-detail-card {
      background: var(--white);
      border-radius: var(--radius-lg);
      border: 1.5px solid var(--mint-mid);
      box-shadow: var(--shadow-sm);
      overflow: hidden;
    }
    .day-detail-header {
      padding: 14px 18px;
      background: var(--green-dark);
      color: var(--white);
    }
    .day-detail-header .day-big {
      font-family: 'DM Mono', monospace;
      font-size: 2rem;
      font-weight: 500;
      line-height: 1;
    }
    .day-detail-header .day-name {
      font-size: .8rem;
      font-weight: 700;
      opacity: .8;
      letter-spacing: .04em;
    }
    .day-events-list { padding: 14px; display: flex; flex-direction: column; gap: 8px; }
    .day-event-item {
      display: flex;
      align-items: flex-start;
      gap: 10px;
      padding: 10px 12px;
      border-radius: var(--radius-sm);
      font-size: .82rem;
      font-weight: 600;
    }
    .day-event-item.class-ev   { background: var(--mint-mid); color: var(--green-deep); }
    .day-event-item.task-ev    { background: var(--blush);    color: var(--blush-dark); }
    .day-event-item.exam-ev    { background: var(--lavender); color: #7B4EA6; }
    .day-event-item .ev-time   { font-family: 'DM Mono', monospace; font-size: .72rem; opacity: .75; margin-top: 2px; }
    .no-events {
      text-align: center;
      padding: 24px;
      color: var(--text-muted);
      font-size: .82rem;
      font-weight: 600;
    }

    /* Mini upcoming list */
    .upcoming-item {
      display: flex;
      gap: 10px;
      padding: 10px 0;
      border-bottom: 1px solid var(--mint-mid);
    }
    .upcoming-item:last-child { border-bottom: none; }
    .upcoming-date-box {
      width: 40px;
      text-align: center;
      flex-shrink: 0;
    }
    .upcoming-date-box .ud-day {
      font-family: 'DM Mono', monospace;
      font-size: 1.2rem;
      font-weight: 500;
      color: var(--green-deep);
      line-height: 1;
    }
    .upcoming-date-box .ud-mon {
      font-size: .6rem;
      font-weight: 800;
      color: var(--text-muted);
      text-transform: uppercase;
      letter-spacing: .04em;
    }
    .upcoming-info .ui-title {
      font-size: .85rem;
      font-weight: 700;
      color: var(--text);
    }
    .upcoming-info .ui-sub {
      font-size: .72rem;
      color: var(--text-muted);
      font-weight: 500;
    }

    @media (max-width: 1000px) {
      .calendar-layout { grid-template-columns: 1fr; }
    }
    @media (max-width: 600px) {
      .cal-event { display: none; }
      .cal-cell  { min-height: 60px; }
    }
  </style>
</head>
<body>
<div class="app-shell">
  <aside class="sidebar">
    <div class="sidebar-logo">
      <div class="logo-icon">🌱</div>
      <div>
        <div class="logo-text">ScholarSync</div>
        <div class="logo-sub">Study Planner</div>
      </div>
    </div>
    <nav class="sidebar-nav">
      <a href="DashboardServlet" class="nav-item"><span class="nav-icon">🏠</span><span class="nav-label">Dashboard</span></a>
      <a href="CalendarServlet" class="nav-item active"><span class="nav-icon">📅</span><span class="nav-label">Calendar</span></a>
      <a href="ActivityServlet" class="nav-item"><span class="nav-icon">✅</span><span class="nav-label">Activities</span></a>
      <a href="TimerServlet" class="nav-item"><span class="nav-icon">⏱️</span><span class="nav-label">Study Timer</span></a>
      <a href="GardenServlet" class="nav-item"><span class="nav-icon">🌿</span><span class="nav-label">Plant Garden</span></a>
      <a href="SettingsServlet" class="nav-item"><span class="nav-icon">⚙️</span><span class="nav-label">Settings</span></a>
    </nav>
    <div class="sidebar-bottom">
      <a href="LogoutServlet" class="nav-item logout"><span class="nav-icon">🚪</span><span class="nav-label">Log Out</span></a>
    </div>
  </aside>

  <div class="main-content">
    <header class="top-header">
      <div class="header-title">Calendar</div>
      <div class="header-right">
        <a href="activities.html" class="btn btn-primary btn-sm">＋ Add Activity</a>
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

<div class="calendar-layout">

    <!-- ================= MAIN CALENDAR ================= -->

    <div class="calendar-card">

        <div class="cal-header">

            <button class="cal-nav-btn"
                    onclick="changeMonth(-1)">
                ‹
            </button>

            <div class="cal-month-label"
                 id="monthLabel">
            </div>

            <button class="cal-nav-btn"
                    onclick="changeMonth(1)">
                ›
            </button>

        </div>

        <!-- Legend -->

        <div class="cal-legend">

            <div class="legend-item">

                <div class="legend-dot"
                     style="background:#ffb84d;">
                </div>

                Pending

            </div>

            <div class="legend-item">

                <div class="legend-dot"
                     style="background:#6bbf59;">
                </div>

                Completed

            </div>

        </div>

        <!-- Days -->

        <div class="cal-dow">

            <div class="cal-dow-cell">Sun</div>
            <div class="cal-dow-cell">Mon</div>
            <div class="cal-dow-cell">Tue</div>
            <div class="cal-dow-cell">Wed</div>
            <div class="cal-dow-cell">Thu</div>
            <div class="cal-dow-cell">Fri</div>
            <div class="cal-dow-cell">Sat</div>

        </div>

        <!-- Calendar -->

        <div class="cal-grid"
             id="calGrid">
        </div>

    </div>

    <!-- ================= RIGHT PANEL ================= -->

    <div class="right-panel">

        <!-- Selected Day -->

        <div class="day-detail-card">

            <div class="day-detail-header">

                <div class="day-big"
                     id="detailDay">
                    --
                </div>

                <div class="day-name"
                     id="detailDayName">

                    Select a Day

                </div>

            </div>

            <div class="day-events-list"
                 id="detailEvents">

                <div class="no-events">

                    📅 Click any date to view activities.

                </div>

            </div>

        </div>

        <!-- Upcoming Activities -->

        <div class="card">

            <div class="card-title">

                <div class="card-title-icon">

                    📌

                </div>

                Upcoming Activities

            </div>

            <c:choose>

                <c:when test="${empty activities}">

                    <p style="padding:15px;color:#777;">

                        No activities available.

                    </p>

                </c:when>

                <c:otherwise>

                    <c:forEach var="a"
                               items="${activities}">

                        <div class="upcoming-item">

                            <div class="upcoming-date-box">

                                <div class="ud-day">

                                    ${a.activityDate.toString().substring(8,10)}

                                </div>

                                <div class="ud-mon">

                                    ${a.activityDate.toString().substring(5,7)}

                                </div>

                            </div>

                            <div class="upcoming-info">

                                <div class="ui-title">

                                    ${a.title}

                                </div>

                                <div class="ui-sub">

                                    ${a.subjectCode}
                                    •
                                    ${a.activityTime}

                                </div>

                            </div>

                        </div>

                    </c:forEach>

                </c:otherwise>

            </c:choose>

        </div>

    </div>

</div>

</main>
  </div>
</div>

<!-- Day popup modal -->
<div class="modal-overlay" id="dayModal" style="display:none;" onclick="closeDayModal(event)">
  <div class="modal" style="max-width:360px;" onclick="event.stopPropagation()">
    <button class="modal-close" onclick="closeDayModal()">✕</button>
    <div class="modal-title" id="modalDayTitle">Events for June 12</div>
    <div id="modalEvents" style="display:flex; flex-direction:column; gap:8px;"></div>
    <a href="activities.html" class="btn btn-primary btn-block btn-sm" style="margin-top:16px;">＋ Add Activity to This Day</a>
  </div>
</div>

<script src="app.js"></script>

<script>

// =======================================
// Activities from MySQL
// =======================================

const EVENTS = {};

<c:forEach var="a" items="${activities}">

EVENTS["${a.activityDate}"] = EVENTS["${a.activityDate}"] || [];

EVENTS["${a.activityDate}"].push({

    type: "${a.status == 'Completed' ? 'completed' : 'pending'}",

    label: "${a.title}",

    time: "${a.activityTime}",

    subject: "${a.subjectCode}"

});

</c:forEach>

// =======================================
// Current Month
// =======================================

const TODAY = new Date();

let currentYear = TODAY.getFullYear();

let currentMonth = TODAY.getMonth();

// =======================================
// Render Calendar
// =======================================

function renderCalendar(){

    const grid=document.getElementById("calGrid");

    grid.innerHTML="";

    const firstDay=new Date(currentYear,currentMonth,1).getDay();

    const daysInMonth=new Date(currentYear,currentMonth+1,0).getDate();

    const daysPrev=new Date(currentYear,currentMonth,0).getDate();

    const monthNames=[
        "January","February","March","April",
        "May","June","July","August",
        "September","October","November","December"
    ];

    document.getElementById("monthLabel").innerHTML=

        monthNames[currentMonth]+" "+currentYear;

    let cells=[];

    for(let i=firstDay-1;i>=0;i--){

        cells.push({

            day:daysPrev-i,

            month:currentMonth-1,

            other:true

        });

    }

    for(let d=1;d<=daysInMonth;d++){

        cells.push({

            day:d,

            month:currentMonth,

            other:false

        });

    }

    while(cells.length<42){

        cells.push({

            day:cells.length-daysInMonth-firstDay+1,

            month:currentMonth+1,

            other:true

        });

    }

    cells.forEach(c=>{

        const yr=c.month<0?

                currentYear-1:

                c.month>11?

                currentYear+1:

                currentYear;

        const mo=((c.month%12)+12)%12;

        const dateStr=

        yr+"-"+

        String(mo+1).padStart(2,"0")+"-"+

        String(c.day).padStart(2,"0");

        const evs=EVENTS[dateStr]||[];

        const cell=document.createElement("div");

        cell.className="cal-cell"+

        (c.other?" other-month":"");

        if(!c.other &&
           yr==TODAY.getFullYear() &&
           mo==TODAY.getMonth() &&
           c.day==TODAY.getDate()){

            cell.classList.add("today");

        }

        cell.dataset.date=dateStr;

        cell.innerHTML=

        "<div class='cal-day-num'>"+c.day+"</div>";

        if(evs.length){

            const dots=document.createElement("div");

            dots.className="cal-dots";

            evs.forEach(e=>{

                const dot=document.createElement("div");

                dot.className="cal-dot";

                dot.style.background=

                e.type=="completed" ?

                "#6bbf59"

                :

                "#ffb84d";

                dots.appendChild(dot);

            });

            cell.appendChild(dots);

        }

        cell.onclick=function(){

            selectDay(

                dateStr,

                c.day,

                mo,

                yr,

                evs

            );

        };

        grid.appendChild(cell);

    });

}

// =======================================
// Select Day
// =======================================

function selectDay(date,day,month,year,evs){

    document.querySelectorAll(".cal-cell")

    .forEach(c=>c.classList.remove("selected"));

    document.querySelector("[data-date='"+date+"']")

    .classList.add("selected");

    const monthNames=[
        "January","February","March","April",
        "May","June","July","August",
        "September","October","November","December"
    ];

    const dayNames=[
        "Sunday","Monday","Tuesday","Wednesday",
        "Thursday","Friday","Saturday"
    ];

    const d=new Date(year,month,day);

    document.getElementById("detailDay").innerHTML=day;

    document.getElementById("detailDayName").innerHTML=

    dayNames[d.getDay()]+"<br>"+

    monthNames[month]+" "+year;

    const detail=document.getElementById("detailEvents");

    if(evs.length==0){

        detail.innerHTML=

        "<div class='no-events'>No activities.</div>";

        return;

    }

    let html="";

    evs.forEach(e=>{

        html+=

        "<div class='day-event-item'>"+

        "<strong>"+

        (e.type=="completed"?"✅":"📌")+" "+e.label+

        "</strong><br>"+

        e.subject+

        "<br>"+

        e.time+

        "</div>";

    });

    detail.innerHTML=html;

}

// =======================================
// Month Navigation
// =======================================

function changeMonth(dir){

    currentMonth+=dir;

    if(currentMonth>11){

        currentMonth=0;

        currentYear++;

    }

    if(currentMonth<0){

        currentMonth=11;

        currentYear--;

    }

    renderCalendar();

}

// =======================================

renderCalendar();

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
    