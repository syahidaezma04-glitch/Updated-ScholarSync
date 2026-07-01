<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>ScholarSync — Plant Garden</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
   <style>
    .garden-layout {
      display: grid;
      grid-template-columns: 1fr 340px;
      gap: 24px;
      align-items: start;
    }

    /* ── COIN BAR ── */
    .coin-bar {
      background: linear-gradient(135deg, var(--yellow) 0%, #FFF5B0 100%);
      border: 1.5px solid var(--yellow-mid);
      border-radius: var(--radius-lg);
      padding: 16px 24px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 24px;
      box-shadow: var(--shadow-sm);
    }
    .coin-left {
      display: flex;
      align-items: center;
      gap: 14px;
    }
    .coin-icon-big {
      font-size: 2.2rem;
      filter: drop-shadow(0 2px 4px rgba(0,0,0,.1));
    }
    .coin-info .coin-label {
      font-size: .72rem;
      font-weight: 800;
      color: var(--yellow-dark);
      text-transform: uppercase;
      letter-spacing: .06em;
    }
    .coin-info .coin-value {
      font-family: 'DM Mono', monospace;
      font-size: 2rem;
      font-weight: 500;
      color: var(--yellow-dark);
      line-height: 1.1;
    }
    .coin-earn-hint {
      font-size: .78rem;
      color: var(--yellow-dark);
      font-weight: 600;
      opacity: .75;
      text-align: right;
    }

    /* ── GARDEN CANVAS ── */
    .garden-canvas-card {
      background: linear-gradient(160deg, #E8F5EC 0%, #D4EDDE 40%, #C5E6CC 100%);
      border-radius: var(--radius-xl);
      border: 2px solid var(--green);
      padding: 28px;
      position: relative;
      overflow: hidden;
      min-height: 420px;
      box-shadow: var(--shadow-md);
    }
    .garden-canvas-card::before {
      content: '';
      position: absolute;
      bottom: 0; left: 0; right: 0;
      height: 80px;
      background: linear-gradient(to top, #A8D5BA, transparent);
      border-radius: 0 0 var(--radius-xl) var(--radius-xl);
    }

    .garden-title-row {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 24px;
      position: relative;
      z-index: 2;
    }
    .garden-title-row h2 {
      font-size: 1.1rem;
      font-weight: 800;
      color: var(--green-deep);
    }

    /* Plant grid */
    .plant-grid {
      display: grid;
      grid-template-columns: repeat(5, 1fr);
      gap: 16px;
      position: relative;
      z-index: 2;
      min-height: 280px;
      align-items: end;
    }
    .plant-slot {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 4px;
      padding: 12px 8px;
      border-radius: var(--radius-md);
      background: rgba(255,255,255,.4);
      border: 1.5px dashed rgba(107,158,120,.3);
      min-height: 100px;
      justify-content: flex-end;
      transition: all var(--transition);
      position: relative;
      cursor: default;
    }
    .plant-slot.empty {
      cursor: pointer;
      opacity: .5;
    }
    .plant-slot.empty:hover {
      opacity: 1;
      background: rgba(255,255,255,.6);
      border-color: var(--green-dark);
    }
    .plant-slot.occupied {
      border-style: solid;
      border-color: rgba(107,158,120,.25);
      background: rgba(255,255,255,.5);
      opacity: 1;
    }
    .plant-emoji {
      font-size: 2.8rem;
      line-height: 1;
      filter: drop-shadow(0 2px 6px rgba(0,0,0,.1));
      transition: transform var(--transition);
    }
    .plant-slot:hover .plant-emoji { transform: scale(1.1) translateY(-2px); }
    .plant-name {
      font-size: .65rem;
      font-weight: 700;
      color: var(--green-deep);
      text-align: center;
      opacity: .8;
    }
    .plant-slot.empty .plant-emoji { font-size: 1.5rem; opacity: .4; }
    .plant-slot .plant-badge {
      position: absolute;
      top: 6px; right: 6px;
      font-size: .6rem;
      background: var(--green-dark);
      color: var(--white);
      border-radius: 99px;
      padding: 1px 6px;
      font-weight: 800;
    }

    /* ── RIGHT COLUMN ── */
    .right-col { display: flex; flex-direction: column; gap: 18px; }

    /* Shop */
    .shop-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 10px;
    }
    .shop-item {
      background: var(--mint);
      border: 1.5px solid var(--mint-mid);
      border-radius: var(--radius-md);
      padding: 14px 10px;
      text-align: center;
      cursor: pointer;
      transition: all var(--transition);
      position: relative;
    }
    .shop-item:hover {
      border-color: var(--green-dark);
      background: var(--white);
      box-shadow: var(--shadow-sm);
      transform: translateY(-2px);
    }
    .shop-item.cant-afford {
      opacity: .5;
      cursor: not-allowed;
    }
    .shop-item.cant-afford:hover { transform: none; box-shadow: none; }
    .shop-emoji { font-size: 2rem; margin-bottom: 4px; }
    .shop-name {
      font-size: .75rem;
      font-weight: 700;
      color: var(--text);
      margin-bottom: 6px;
    }
    .shop-price {
      display: inline-flex;
      align-items: center;
      gap: 4px;
      background: var(--yellow);
      border-radius: 99px;
      padding: 3px 10px;
      font-size: .72rem;
      font-weight: 800;
      color: var(--yellow-dark);
    }
    .shop-item.selected-to-buy {
      border-color: var(--green-dark);
      background: var(--mint-mid);
      box-shadow: 0 0 0 2px var(--green);
    }

    /* Collection stats */
    .collection-row {
      display: flex;
      gap: 10px;
    }
    .coll-stat {
      flex: 1;
      background: var(--white);
      border-radius: var(--radius-md);
      border: 1.5px solid var(--mint-mid);
      padding: 12px;
      text-align: center;
    }
    .coll-stat .cs-val {
      font-family: 'DM Mono', monospace;
      font-size: 1.4rem;
      font-weight: 500;
      color: var(--green-deep);
    }
    .coll-stat .cs-label {
      font-size: .65rem;
      font-weight: 700;
      color: var(--text-muted);
      text-transform: uppercase;
      letter-spacing: .04em;
    }

    /* Buy confirm area */
    .buy-confirm {
      background: var(--mint-mid);
      border-radius: var(--radius-md);
      padding: 12px 14px;
      display: none;
      align-items: center;
      gap: 10px;
      font-size: .82rem;
      font-weight: 600;
    }
    .buy-confirm.visible { display: flex; }

    @media (max-width: 1000px) {
      .garden-layout { grid-template-columns: 1fr; }
      .plant-grid { grid-template-columns: repeat(4, 1fr); }
    }
    @media (max-width: 600px) {
      .plant-grid { grid-template-columns: repeat(3, 1fr); }
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
      <a href="${pageContext.request.contextPath}/DashboardServlet" class="nav-item">
        <span class="nav-icon">🏠</span><span class="nav-label">Dashboard</span>
      </a>
      <a href="${pageContext.request.contextPath}/CalendarServlet" class="nav-item">
        <span class="nav-icon">📅</span><span class="nav-label">Calendar</span>
      </a>
      <a href="${pageContext.request.contextPath}/ActivityServlet" class="nav-item">
        <span class="nav-icon">✅</span><span class="nav-label">Activities</span>
      </a>
      <a href="${pageContext.request.contextPath}/TimerServlet" class="nav-item">
        <span class="nav-icon">⏱️</span><span class="nav-label">Study Timer</span>
      </a>
      <a href="${pageContext.request.contextPath}/GardenServlet" class="nav-item active">
        <span class="nav-icon">🌿</span><span class="nav-label">Plant Garden</span>
      </a>
      <a href="${pageContext.request.contextPath}/SettingsServlet" class="nav-item">
        <span class="nav-icon">⚙️</span><span class="nav-label">Settings</span>
      </a>
    </nav>
    <div class="sidebar-bottom">
      <a href="${pageContext.request.contextPath}/LogoutServlet" class="nav-item logout">
        <span class="nav-icon">🚪</span><span class="nav-label">Logout</span>
      </a>
    </div>
  </aside>

  <div class="main-content">

    <header class="top-header">
      <div class="header-title">Plant Garden</div>
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

      <!-- ================= COINS ================= -->
      <div class="coin-bar">
        <div class="coin-left">
          <div class="coin-icon-big">🪙</div>
          <div class="coin-info">
            <div class="coin-label">Coins Available</div>
            <div class="coin-value">${user.coins}</div>
          </div>
        </div>
        <div class="coin-earn-hint">
          🍅 Complete one Focus Session to earn <b>+5 Coins</b>
        </div>
      </div>

      <div class="garden-layout">

        <!-- ================= LEFT : MY GARDEN ================= -->
        <div>
          <div class="garden-canvas-card">
            <div class="garden-title-row">
              <h2>🌱 My Garden</h2>
              <span class="badge badge-green">${myPlants.size()} Collected</span>
            </div>

            <div class="plant-grid">
              <c:choose>
                <c:when test="${empty myPlants}">
                  <div style="grid-column:1/-1;text-align:center;padding:40px;">
                    🌱 You haven't collected any plants yet.
                  </div>
                </c:when>
                <c:otherwise>
                  <c:forEach var="plant" items="${myPlants}">
                    <div class="plant-slot occupied">
                      <div class="plant-emoji">${plant.image}</div>
                      <div class="plant-name">${plant.plantName}</div>
                    </div>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>

        <!-- ================= RIGHT COLUMN ================= -->
        <div class="right-col">

          <!-- Collection Summary -->
          <div class="card">
            <div class="card-title">
              <div class="card-title-icon">🏆</div>
              Collection Summary
            </div>
            <div class="collection-row">
              <div class="coll-stat">
                <div class="cs-val">${myPlants.size()}</div>
                <div class="cs-label">Owned</div>
              </div>
              <div class="coll-stat">
                <div class="cs-val">${plants.size()}</div>
                <div class="cs-label">In Shop</div>
              </div>
              <div class="coll-stat">
                <div class="cs-val">${user.coins}</div>
                <div class="cs-label">🪙 Coins</div>
              </div>
            </div>
          </div>

          <!-- ================= SHOP ================= -->
          <div class="card">
            <div class="card-title">
              <div class="card-title-icon">🛍️</div>
              Plant Shop
            </div>

            <c:choose>
              <c:when test="${empty plants}">
                <p style="padding:20px;color:red;">❌ No plants found in database.</p>
              </c:when>
              <c:otherwise>
                <div class="shop-grid">
                  <c:forEach var="plant" items="${plants}">
                    <div class="shop-item">
                      <form action="${pageContext.request.contextPath}/CollectPlantServlet" method="post">
                        <input type="hidden" name="plantID" value="${plant.plantID}">
                        <div class="shop-emoji">${plant.image}</div>
                        <div class="shop-name">${plant.plantName}</div>
                        <div class="shop-price">🪙 ${plant.price}</div>
                        <button type="submit" class="btn btn-primary btn-sm">Buy</button>
                      </form>
                    </div>
                  </c:forEach>
                </div>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- ================= COLLECTION HISTORY ================= -->
          <div class="card">
            <div class="card-title">
              <div class="card-title-icon">🌿</div>
              Collection History
            </div>

            <div class="task-list">
              <c:choose>
                <c:when test="${empty myPlants}">
                  <div class="task-item">No plants collected yet.</div>
                </c:when>
                <c:otherwise>
                  <c:forEach var="plant" items="${myPlants}">
                    <div class="task-item">
                      <div class="task-info">
                        <div class="task-title-text">
                          ${plant.image} ${plant.plantName}
                        </div>
                        <div class="task-meta">
                          Collected on ${plant.collectedDate}
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <a href="${pageContext.request.contextPath}/TimerServlet" class="btn btn-primary btn-block">
            ⏱️ Study to Earn More Coins
          </a>

        </div>
      </div>

    </main>
  </div>
</div>

<!-- Buy success toast -->
<div class="toast" id="buyToast" style="display:none;">🌱 Plant added to your garden!</div>
<!-- Hint toast -->
<div class="toast" id="hintToast" style="display:none; background:var(--green-deep);">
  🛍️ Pick a plant from the shop to place here!
</div>
<!-- Can't afford toast -->
<div class="toast" id="poorToast" style="display:none; background:var(--blush-dark);">
  🪙 Not enough coins! Keep studying to earn more.
</div>

<script src="app.js"></script>
<script>
  let coins = 35;
  let selectedItem = null;

  function updateCoinDisplay() {
    document.getElementById('coinCount').textContent = coins;
    document.querySelectorAll('.shop-item').forEach(item => {
      const cost = parseInt(item.querySelector('.shop-price').textContent.replace('🪙 ', ''));
      item.classList.toggle('cant-afford', coins < cost);
    });
  }

  function selectShopItem(el, emoji, name, cost) {
    if (el.classList.contains('cant-afford')) {
      showToast('poorToast');
      return;
    }
    document.querySelectorAll('.shop-item').forEach(i => i.classList.remove('selected-to-buy'));
    el.classList.add('selected-to-buy');
    selectedItem = { emoji, name, cost };
    document.getElementById('buyPreviewEmoji').textContent = emoji;
    document.getElementById('buyPreviewName').textContent  = name;
    document.getElementById('buyPreviewCost').textContent  = `Costs ${cost} 🪙`;
    document.getElementById('buyConfirm').classList.add('visible');
  }

  function confirmBuy() {
    if (!selectedItem) return;
    if (coins < selectedItem.cost) { showToast('poorToast'); return; }
    coins -= selectedItem.cost;
    updateCoinDisplay();

    const emptySlot = document.querySelector('.plant-slot.empty');
    if (emptySlot) {
      emptySlot.className = 'plant-slot occupied';
      emptySlot.innerHTML = `
        <span class="plant-badge">Lv1</span>
        <div class="plant-emoji">${selectedItem.emoji}</div>
        <div class="plant-name">${selectedItem.name}</div>`;
    }

    cancelBuy();
    showToast('buyToast');
  }

  function cancelBuy() {
    document.querySelectorAll('.shop-item').forEach(i => i.classList.remove('selected-to-buy'));
    document.getElementById('buyConfirm').classList.remove('visible');
    selectedItem = null;
  }

  function showShopHint() {
    showToast('hintToast');
  }

  function showToast(id) {
    const t = document.getElementById(id);
    t.style.display = 'flex';
    t.classList.remove('hide');
    setTimeout(() => {
      t.classList.add('hide');
      setTimeout(() => { t.style.display = 'none'; t.classList.remove('hide'); }, 300);
    }, 2500);
  }

  updateCoinDisplay();
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
