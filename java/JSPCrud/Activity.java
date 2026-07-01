package JSPCrud;

import java.sql.Date;
import java.sql.Time;

public class Activity {

    private int activityID;
    private String title;
    private String details;
    private int subjectID;
    private Date activityDate;
    private Time activityTime;
    private String activityDays;
    private String status;
    private int userID;

    private String subjectCode;
    private String subjectName;

    public int getActivityID() {
        return activityID;
    }

    public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public Date getActivityDate() {
        return activityDate;
    }

    public void setActivityDate(Date activityDate) {
        this.activityDate = activityDate;
    }


    public java.sql.Time getActivityTime() {
        return activityTime;
    }

    public void setActivityTime(java.sql.Time activityTime) {
        this.activityTime = activityTime;
    }

    public String getActivityDays() {
        return activityDays;
    }

    public void setActivityDays(String activityDays) {
        this.activityDays = activityDays;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
}