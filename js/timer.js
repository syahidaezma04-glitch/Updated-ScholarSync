/* ════════════════════════════════════════════════════════════════
   ScholarSync — Study Timer logic
   Expects these globals to already be defined by timer.jsp:
     focusTime, shortBreak, longBreak,
     sessionsUntilLongBreak, autoBreak, autoFocus, coinsPerSession
   ════════════════════════════════════════════════════════════════ */

(function () {
  const RING_CIRCUMFERENCE = 722; // matches stroke-dasharray in CSS (2 * π * 115 ≈ 722)

  let mode = 'focus';            // 'focus' | 'short' | 'long'
  let totalSeconds = (typeof focusTime !== 'undefined' ? focusTime : 25) * 60;
  let remainingSeconds = totalSeconds;
  let isRunning = false;
  let intervalId = null;
  let sessionCount = (typeof window.currentSession !== 'undefined') ? window.currentSession : 1;
  let currentDuration = (typeof focusTime !== 'undefined' ? focusTime : 25);
  const elDisplay   = document.getElementById('timerDisplay');
  const elRing      = document.getElementById('timerRing');
  const elDots      = document.getElementById('sessionDots');
  const elPlayBtn   = document.getElementById('mainPlayBtn');
  const elCurSess   = document.getElementById('currentSession');

  // ── helpers ──────────────────────────────────────────────────────────
  function pad(n) { return String(n).padStart(2, '0'); }

  function durationForMode(m) {
    if (m === 'short') return (typeof shortBreak !== 'undefined' ? shortBreak : 5) * 60;
    if (m === 'long')  return (typeof longBreak  !== 'undefined' ? longBreak  : 15) * 60;
    return (typeof focusTime !== 'undefined' ? focusTime : 25) * 60;
  }

  function updateDisplay() {
    const m = Math.floor(remainingSeconds / 60);
    const s = remainingSeconds % 60;
    if (elDisplay) elDisplay.textContent = pad(m) + ':' + pad(s);

    const progressFraction = 1 - (remainingSeconds / totalSeconds);
    const offset = RING_CIRCUMFERENCE * progressFraction;
    if (elRing) elRing.style.strokeDashoffset = offset;
  }

  function renderSessionDots() {
    if (!elDots) return;
    const total = (typeof sessionsUntilLongBreak !== 'undefined') ? sessionsUntilLongBreak : 4;
    elDots.innerHTML = '';
    for (let i = 1; i <= total; i++) {
      const dot = document.createElement('div');
      dot.className = 'session-dot';
      if (i < sessionCount) dot.classList.add('done');
      if (i === sessionCount) dot.classList.add('active');
      elDots.appendChild(dot);
    }
  }

  function setActiveTab(m) {
    document.querySelectorAll('.mode-tab').forEach(t => t.classList.remove('active'));
    const map = { focus: 'tabFocus', short: 'tabShort', long: 'tabLong' };
    const tab = document.getElementById(map[m]);
    if (tab) tab.classList.add('active');
  }

  // ── public-ish controls (referenced via onclick in JSP) ────────────────
  window.setMode = function (m) {
    mode = m;
    pauseTimer();
    totalSeconds = durationForMode(m);
    remainingSeconds = totalSeconds;
    setActiveTab(m);
    updateDisplay();
  };

  window.toggleStartPause = function () {
    isRunning ? pauseTimer() : startTimer();
  };

  window.startTimer = function () {
    if (isRunning) return;
    isRunning = true;
    if (elPlayBtn) elPlayBtn.textContent = '⏸';
    intervalId = setInterval(() => {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        updateDisplay();
      } else {
        clearInterval(intervalId);
        isRunning = false;
        if (elPlayBtn) elPlayBtn.textContent = '▶';
        handleSessionComplete();
      }
    }, 1000);
  };

  window.pauseTimer = function () {
    isRunning = false;
    clearInterval(intervalId);
    if (elPlayBtn) elPlayBtn.textContent = '▶';
  };

  window.resetTimer = function () {
    pauseTimer();
    remainingSeconds = totalSeconds;
    updateDisplay();
  };

  window.skipSession = function () {
    pauseTimer();
    handleSessionComplete();
  };

  window.setCustomDuration = function (minutes) {

      document.querySelectorAll('.duration-pill')
          .forEach(p => p.classList.remove('active'));

      if(event && event.target){
          event.target.classList.add('active');
      }

      currentDuration = minutes;

      if(mode === 'focus'){

          totalSeconds = minutes * 60;
          remainingSeconds = totalSeconds;

          updateDisplay();

      }

  };

  function handleSessionComplete() {

      if (mode === 'focus') {

          // ===========================
          // Reward Coins
          // ===========================

          let reward = 5;

          if(currentDuration == 15){

              reward = 3;

          }else if(currentDuration == 45){

              reward = 8;

          }else if(currentDuration == 60){

              reward = 10;

          }

          rewardCoins(reward);

          // ===========================
          // Next Session
          // ===========================

          sessionCount++;

          if(elCurSess){
              elCurSess.textContent = sessionCount;
          }

          renderSessionDots();

          const total =
              (typeof sessionsUntilLongBreak !== 'undefined')
              ? sessionsUntilLongBreak
              : 4;

          const nextMode =
              (sessionCount > total)
              ? 'long'
              : 'short';

          if(sessionCount > total){
              sessionCount = 1;
          }

          if(typeof autoBreak !== 'undefined' && autoBreak){

              window.setMode(nextMode);
              window.startTimer();

          }else{

              window.setMode(nextMode);

          }

      }else{

          // Break finished

          if(typeof autoFocus !== 'undefined' && autoFocus){

              window.setMode('focus');
              window.startTimer();

          }else{

              window.setMode('focus');

          }

      }

  }
  // ── keyboard shortcut: Space = start/pause ──────────────────────────────
  document.addEventListener('keydown', function (e) {
    if (e.code === 'Space' && !['INPUT', 'TEXTAREA'].includes(document.activeElement.tagName)) {
      e.preventDefault();
      window.toggleStartPause();
    }
  });

  // ── init ─────────────────────────────────────────────────────────────
  document.addEventListener('DOMContentLoaded', function () {
    if (elRing) elRing.style.strokeDasharray = RING_CIRCUMFERENCE;
    renderSessionDots();
    updateDisplay();
  });
})();