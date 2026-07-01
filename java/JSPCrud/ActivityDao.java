package JSPCrud;

import java.sql.*;
import java.util.ArrayList;

import database.DBConnection;

public class ActivityDao {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    // =====================================
    // Get all activities
    // =====================================

    public ArrayList<Activity> getActivities(int userID){

        ArrayList<Activity> list = new ArrayList<>();
        

        try{

            conn = DBConnection.getConnection();

            String sql =
                "SELECT a.*, s.subjectCode, s.subjectName " +
                "FROM activity a " +
                "LEFT JOIN subject s ON a.subjectID = s.subjectID " +
                "WHERE a.userID=? " +
                "ORDER BY a.activityID DESC";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);

            rs = ps.executeQuery();

            while(rs.next()){

                Activity a = new Activity();

                a.setActivityID(rs.getInt("activityID"));
                a.setTitle(rs.getString("title"));
                a.setDetails(rs.getString("details"));
                a.setSubjectID(rs.getInt("subjectID"));
                a.setActivityDate(rs.getDate("activityDate"));
                a.setActivityTime(rs.getTime("activityTime"));
                a.setActivityDays(rs.getString("activityDays"));
                a.setStatus(rs.getString("status"));
                a.setUserID(rs.getInt("userID"));

                // Subject information
                a.setSubjectCode(rs.getString("subjectCode"));
                a.setSubjectName(rs.getString("subjectName"));

                list.add(a);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return list;
    }

    // =====================================
    // Get activity by ID
    // =====================================

    public Activity getActivityByID(int activityID){

        Activity a = null;

        try{

            conn = DBConnection.getConnection();

            String sql =
                "SELECT a.*, s.subjectCode, s.subjectName " +
                "FROM activity a " +
                "LEFT JOIN subject s ON a.subjectID = s.subjectID " +
                "WHERE a.activityID=?";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, activityID);

            rs = ps.executeQuery();

            if(rs.next()){

                a = new Activity();

                a.setActivityID(rs.getInt("activityID"));
                a.setTitle(rs.getString("title"));
                a.setDetails(rs.getString("details"));
                a.setSubjectID(rs.getInt("subjectID"));
                a.setActivityDate(rs.getDate("activityDate"));
                a.setActivityTime(rs.getTime("activityTime"));
                a.setActivityDays(rs.getString("activityDays"));
                a.setStatus(rs.getString("status"));
                a.setUserID(rs.getInt("userID"));

                // Subject information
                a.setSubjectCode(rs.getString("subjectCode"));
                a.setSubjectName(rs.getString("subjectName"));

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return a;
    }

    // =====================================
    // Add Activity
    // =====================================

    public boolean addActivity(Activity a){

        boolean status = false;

        try{

            conn = DBConnection.getConnection();

            String sql =
            		"INSERT INTO activity(title,details,subjectID,activityDate,activityTime,activityDays,status,userID) VALUES(?,?,?,?,?,?,?,?)";

            ps = conn.prepareStatement(sql);

            ps.setString(1, a.getTitle());
            ps.setString(2, a.getDetails());
            ps.setInt(3, a.getSubjectID());
            ps.setDate(4, a.getActivityDate());
            ps.setTime(5, a.getActivityTime());
            ps.setString(6, a.getActivityDays());
            ps.setString(7, a.getStatus());
            ps.setInt(8, a.getUserID());
            status = ps.executeUpdate() > 0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;
    }

    // =====================================
    // Update Activity
    // =====================================

    public boolean updateActivity(Activity a){

        boolean status = false;

        try{

            conn = DBConnection.getConnection();

            String sql =
                "UPDATE activity SET " +
                "title=?, " +
                "details=?, " +
                "subjectID=?, " +
                "activityDate=?, " +
                "activityTime=?, " +
                "activityDays=?, " +
                "status=? " +
                "WHERE activityID=?";

            ps = conn.prepareStatement(sql);

            ps.setString(1, a.getTitle());
            ps.setString(2, a.getDetails());
            ps.setInt(3, a.getSubjectID());
            ps.setDate(4, a.getActivityDate());
            ps.setTime(5, a.getActivityTime());
            ps.setString(6, a.getActivityDays());
            ps.setString(7, a.getStatus());
            ps.setInt(8, a.getActivityID());

            status = ps.executeUpdate() > 0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;
    }

    // =====================================
    // Delete Activity
    // =====================================

    public boolean deleteActivity(int activityID){

        boolean status = false;

        try{

            conn = DBConnection.getConnection();

            String sql =
                "DELETE FROM activity WHERE activityID=?";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, activityID);

            status = ps.executeUpdate() > 0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;
    }
    
   
    public ArrayList<Activity> getRecentActivities(int userID){

        ArrayList<Activity> list = new ArrayList<>();

        try{

            conn = DBConnection.getConnection();

            String sql =
                "SELECT a.*, s.subjectCode " +
                "FROM activity a " +
                "LEFT JOIN subject s ON a.subjectID=s.subjectID " +
                "WHERE a.userID=? " +
                "ORDER BY activityDate ASC, activityTime ASC " +
                "LIMIT 5";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, userID);

            rs = ps.executeQuery();

            while(rs.next()){

                Activity a = new Activity();

                a.setActivityID(rs.getInt("activityID"));
                a.setTitle(rs.getString("title"));
                a.setStatus(rs.getString("status"));
                a.setActivityDate(rs.getDate("activityDate"));
                a.setActivityTime(rs.getTime("activityTime"));
                a.setSubjectCode(rs.getString("subjectCode"));

                list.add(a);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return list;

    }
    public ArrayList<Activity> getTodayActivities(int userID){

        ArrayList<Activity> list = new ArrayList<>();

        try{

            conn = DBConnection.getConnection();

            String sql =
                "SELECT a.*, s.subjectCode " +
                "FROM activity a " +
                "LEFT JOIN subject s ON a.subjectID=s.subjectID " +
                "WHERE a.userID=? " +
                "AND activityDate = CURDATE() " +
                "ORDER BY activityTime ASC";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, userID);

            rs = ps.executeQuery();

            while(rs.next()){

                Activity a = new Activity();

                a.setActivityID(rs.getInt("activityID"));
                a.setTitle(rs.getString("title"));
                a.setStatus(rs.getString("status"));
                a.setActivityDate(rs.getDate("activityDate"));
                a.setActivityTime(rs.getTime("activityTime"));
                a.setSubjectCode(rs.getString("subjectCode"));

                list.add(a);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return list;
    }
 // =====================================
 // Get activities for calendar
 // =====================================

 public ArrayList<Activity> getCalendarActivities(int userID){

     ArrayList<Activity> list = new ArrayList<>();

     try{

         conn = DBConnection.getConnection();

         String sql =
             "SELECT a.*, s.subjectCode " +
             "FROM activity a " +
             "LEFT JOIN subject s ON a.subjectID=s.subjectID " +
             "WHERE a.userID=? " +
             "ORDER BY activityDate, activityTime";

         ps = conn.prepareStatement(sql);

         ps.setInt(1, userID);

         rs = ps.executeQuery();

         while(rs.next()){

             Activity a = new Activity();

             a.setActivityID(rs.getInt("activityID"));
             a.setTitle(rs.getString("title"));
             a.setDetails(rs.getString("details"));
             a.setSubjectID(rs.getInt("subjectID"));
             a.setActivityDate(rs.getDate("activityDate"));
             a.setActivityTime(rs.getTime("activityTime"));
             a.setStatus(rs.getString("status"));
             a.setSubjectCode(rs.getString("subjectCode"));

             list.add(a);
         }

     }catch(Exception e){
         e.printStackTrace();
     }

     return list;
 }
 

}