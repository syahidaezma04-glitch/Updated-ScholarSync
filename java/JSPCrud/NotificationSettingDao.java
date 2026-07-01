package JSPCrud;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import database.DBConnection;

public class NotificationSettingDao {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // =========================================
    // Get Notification Setting
    // =========================================

    public NotificationSetting getNotification(int userID){

        NotificationSetting notification = null;

        try{

            conn = DBConnection.getConnection();

            String sql =
                "SELECT * FROM notification_settings WHERE userID=?";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, userID);

            rs = ps.executeQuery();

            if(rs.next()){

                notification = new NotificationSetting();

                notification.setNotificationID(
                        rs.getInt("notificationID"));

                notification.setUserID(
                        rs.getInt("userID"));

                notification.setSessionSound(
                        rs.getBoolean("sessionSound"));

                notification.setSoundTheme(
                        rs.getString("soundTheme"));

                notification.setVolume(
                        rs.getInt("volume"));

                notification.setDueReminder(
                        rs.getBoolean("dueReminder"));

                // "1 hour before"
                notification.setRemindBefore(
                        rs.getString("remindBefore"));

                notification.setDailyReminder(
                        rs.getBoolean("dailyReminder"));

                // "08:00"
                notification.setReminderTime(
                        rs.getString("reminderTime"));

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return notification;

    }


    // =========================================
    // Create Default Notification
    // =========================================

    public boolean createDefaultNotification(int userID){

        boolean status = false;

        try{

            conn = DBConnection.getConnection();

            String sql =
                "INSERT INTO notification_settings "
              + "(userID,sessionSound,soundTheme,"
              + "volume,dueReminder,remindBefore,"
              + "dailyReminder,reminderTime)"
              + " VALUES(?,?,?,?,?,?,?,?)";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, userID);
            ps.setBoolean(2, true);
            ps.setString(3, "Forest Birds");
            ps.setInt(4, 70);
            ps.setBoolean(5, true);
            ps.setString(6, "1 hour before");
            ps.setBoolean(7, true);
            ps.setString(8, "08:00");

            status = ps.executeUpdate() > 0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }


    // =========================================
    // Update Notification
    // =========================================

    public boolean updateNotification(NotificationSetting notification){

        boolean status = false;

        try{

            conn = DBConnection.getConnection();

            String sql =
                "UPDATE notification_settings SET "
              + "sessionSound=?,"
              + "soundTheme=?,"
              + "volume=?,"
              + "dueReminder=?,"
              + "remindBefore=?,"
              + "dailyReminder=?,"
              + "reminderTime=? "
              + "WHERE userID=?";

            ps = conn.prepareStatement(sql);

            ps.setBoolean(1,
                    notification.isSessionSound());

            ps.setString(2,
                    notification.getSoundTheme());

            ps.setInt(3,
                    notification.getVolume());

            ps.setBoolean(4,
                    notification.isDueReminder());

            ps.setString(5,
                    notification.getRemindBefore());

            ps.setBoolean(6,
                    notification.isDailyReminder());

            ps.setString(7,
                    notification.getReminderTime());

            ps.setInt(8,
                    notification.getUserID());

            status = ps.executeUpdate() > 0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }

}