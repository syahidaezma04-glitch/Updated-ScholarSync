package JSPCrud;

import java.sql.*;
import database.DBConnection;
public class UserDao {


       

    public static boolean validate(String email, String password) {

        boolean status = false;

        try {

        	Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "select * from user where email=? and password=?");

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            status = rs.next();

        } catch (Exception e) {

            System.out.println(e);

        }

        return status;
    }
    
    public static int save(User u){

        int status = 0;

        try{

        	Connection con = DBConnection.getConnection();


            PreparedStatement ps = con.prepareStatement(
            		"INSERT INTO user (fullName,email,password,coins,studyGoal) VALUES(?,?,?,?,?)");

            ps.setString(1, u.getFullName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setInt(4, u.getCoins());
            ps.setInt(5, u.getStudyGoal());
            status = ps.executeUpdate();

        }catch(Exception e){
            System.out.println(e);
        }

        return status;
    }
    
    public static boolean emailExists(String email){

        boolean exists = false;

        try{

        	Connection con = DBConnection.getConnection();


            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM user WHERE email=?");

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            exists = rs.next();

        }catch(Exception e){
            System.out.println(e);
        }

        return exists;
    }
    
    public static User getUserByEmail(String email){

        User u = null;

        try{

        	Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM user WHERE email=?");

            ps.setString(1,email);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                u = new User();

                u.setUserID(rs.getInt("userID"));
                u.setFullName(rs.getString("fullName"));
                u.setEmail(rs.getString("email"));
                u.setCoins(rs.getInt("coins"));
                u.setStudyGoal(rs.getInt("studyGoal"));

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return u;

    }
    

    
    public static int getCompletedTaskCount(int userID){

        int count = 0;

        try{

        	Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM studyplan WHERE status='Completed' AND userID=?");

            ps.setInt(1, userID);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                count = rs.getInt(1);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return count;

    }

	public static int getPendingTaskCount(int userID) {
	    int count = 0;

        try{

        	Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM studyplan WHERE status='Pending' AND userID=?");

            ps.setInt(1, userID);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                count = rs.getInt(1);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return count;
	}
  
}