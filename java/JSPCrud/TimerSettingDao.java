package JSPCrud;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import database.DBConnection;

public class TimerSettingDao {
	Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /* =========================================
       Get Timer Setting by User ID
    ========================================= */

    public TimerSetting getTimerSetting(int userID) {

        TimerSetting setting = null;

        try {

            conn = DBConnection.getConnection();

            String sql = "SELECT * FROM timer_settings WHERE userID=?";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, userID);

            rs = ps.executeQuery();

            if (rs.next()) {

                setting = new TimerSetting();

                setting.setTimerID(rs.getInt("timerID"));
                setting.setUserID(rs.getInt("userID"));
                setting.setFocusTime(rs.getInt("focusTime"));
                setting.setShortBreak(rs.getInt("shortBreak"));
                setting.setLongBreak(rs.getInt("longBreak"));
                setting.setSessionsUntilLongBreak(
                        rs.getInt("sessionsUntilLongBreak"));
                setting.setAutoBreak(rs.getBoolean("autoBreak"));
                setting.setAutoFocus(rs.getBoolean("autoFocus"));
                setting.setCoinsPerSession(
                        rs.getInt("coinsPerSession"));

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return setting;

    }

    /* =========================================
       Create Default Timer
    ========================================= */

    public boolean createDefaultSetting(int userID) {

        boolean status = false;

        try {

            conn = DBConnection.getConnection();

            String sql =
                    "INSERT INTO timer_settings "
                  + "(userID,focusTime,shortBreak,longBreak,"
                  + "sessionsUntilLongBreak,autoBreak,"
                  + "autoFocus,coinsPerSession)"
                  + " VALUES(?,?,?,?,?,?,?,?)";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, userID);

            ps.setInt(2, 25);

            ps.setInt(3, 5);

            ps.setInt(4, 15);

            ps.setInt(5, 4);

            ps.setBoolean(6, false);

            ps.setBoolean(7, true);

            ps.setInt(8, 5);

            status = ps.executeUpdate() > 0;

        }

        catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }

    /* =========================================
       Update Timer Setting
    ========================================= */

    public boolean updateTimerSetting(TimerSetting setting) {

        boolean status = false;

        try {

            conn = DBConnection.getConnection();

            String sql =
                    "UPDATE timer_settings SET "
                  + "focusTime=?,"
                  + "shortBreak=?,"
                  + "longBreak=?,"
                  + "sessionsUntilLongBreak=?,"
                  + "autoBreak=?,"
                  + "autoFocus=?,"
                  + "coinsPerSession=? "
                  + "WHERE userID=?";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, setting.getFocusTime());

            ps.setInt(2, setting.getShortBreak());

            ps.setInt(3, setting.getLongBreak());

            ps.setInt(4,
                    setting.getSessionsUntilLongBreak());

            ps.setBoolean(5,
                    setting.isAutoBreak());

            ps.setBoolean(6,
                    setting.isAutoFocus());

            ps.setInt(7,
                    setting.getCoinsPerSession());

            ps.setInt(8,
                    setting.getUserID());

            status = ps.executeUpdate() > 0;

        }

        catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }
}
