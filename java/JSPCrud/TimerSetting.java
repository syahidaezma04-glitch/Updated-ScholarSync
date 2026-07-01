package JSPCrud;

public class TimerSetting {
	 private int timerID;
	    private int userID;
	    private int focusTime;
	    private int shortBreak;
	    private int longBreak;
	    private int sessionsUntilLongBreak;
	    private boolean autoBreak;
	    private boolean autoFocus;
	    private int coinsPerSession;

	    public TimerSetting() {}

	    public int getTimerID() {
	        return timerID;
	    }

	    public void setTimerID(int timerID) {
	        this.timerID = timerID;
	    }

	    public int getUserID() {
	        return userID;
	    }

	    public void setUserID(int userID) {
	        this.userID = userID;
	    }

	    public int getFocusTime() {
	        return focusTime;
	    }

	    public void setFocusTime(int focusTime) {
	        this.focusTime = focusTime;
	    }

	    public int getShortBreak() {
	        return shortBreak;
	    }

	    public void setShortBreak(int shortBreak) {
	        this.shortBreak = shortBreak;
	    }

	    public int getLongBreak() {
	        return longBreak;
	    }

	    public void setLongBreak(int longBreak) {
	        this.longBreak = longBreak;
	    }

	    public int getSessionsUntilLongBreak() {
	        return sessionsUntilLongBreak;
	    }

	    public void setSessionsUntilLongBreak(int sessionsUntilLongBreak) {
	        this.sessionsUntilLongBreak = sessionsUntilLongBreak;
	    }

	    public boolean isAutoBreak() {
	        return autoBreak;
	    }

	    public void setAutoBreak(boolean autoBreak) {
	        this.autoBreak = autoBreak;
	    }

	    public boolean isAutoFocus() {
	        return autoFocus;
	    }

	    public void setAutoFocus(boolean autoFocus) {
	        this.autoFocus = autoFocus;
	    }

	    public int getCoinsPerSession() {
	        return coinsPerSession;
	    }

	    public void setCoinsPerSession(int coinsPerSession) {
	        this.coinsPerSession = coinsPerSession;
	    }
}
