package JSPCrud;

public class NotificationSetting {

    private int notificationID;
    private int userID;

    private boolean sessionSound;
    private String soundTheme;
    private int volume;

    private boolean dueReminder;
    private String remindBefore;

    private boolean dailyReminder;
    private String reminderTime;

    public int getNotificationID() {
        return notificationID;
    }

    public void setNotificationID(int notificationID) {
        this.notificationID = notificationID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public boolean isSessionSound() {
        return sessionSound;
    }

    public void setSessionSound(boolean sessionSound) {
        this.sessionSound = sessionSound;
    }

    public String getSoundTheme() {
        return soundTheme;
    }

    public void setSoundTheme(String soundTheme) {
        this.soundTheme = soundTheme;
    }

    public int getVolume() {
        return volume;
    }

    public void setVolume(int volume) {
        this.volume = volume;
    }

    public boolean isDueReminder() {
        return dueReminder;
    }

    public void setDueReminder(boolean dueReminder) {
        this.dueReminder = dueReminder;
    }

    public String getRemindBefore() {
        return remindBefore;
    }

    public void setRemindBefore(String remindBefore) {
        this.remindBefore = remindBefore;
    }

    public boolean isDailyReminder() {
        return dailyReminder;
    }

    public void setDailyReminder(boolean dailyReminder) {
        this.dailyReminder = dailyReminder;
    }

    public String getReminderTime() {
        return reminderTime;
    }

    public void setReminderTime(String reminderTime) {
        this.reminderTime = reminderTime;
    }





}