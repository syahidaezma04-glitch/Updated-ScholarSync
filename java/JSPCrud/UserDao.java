package JSPCrud;

import java.sql.*;
import database.DBConnection;
public class UserDao {


       

	public static User login(String email, String password){

	    User user = null;

	    try{

	        Connection con = DBConnection.getConnection();

	        PreparedStatement ps = con.prepareStatement(
	            "SELECT * FROM user WHERE email=? AND password=?");

	        ps.setString(1, email);
	        ps.setString(2, password);

	        ResultSet rs = ps.executeQuery();

	        if(rs.next()){

	            user = new User();

	            user.setUserID(rs.getInt("userID"));
	            user.setFullName(rs.getString("fullName"));
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	            user.setCoins(rs.getInt("coins"));
	            user.setStudyGoal(rs.getInt("studyGoal"));
	            user.setUniversity(rs.getString("university"));
	            user.setYearLevel(rs.getString("yearLevel"));

	        }

	    }catch(Exception e){

	        e.printStackTrace();

	    }

	    return user;

	}
    
    public static int save(User u){

        int userID = 0;

        try{

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO user(fullName,email,password,coins,studyGoal,university,yearLevel) VALUES(?,?,?,?,?,?,?)",
                Statement.RETURN_GENERATED_KEYS
            );

            ps.setString(1, u.getFullName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setInt(4, u.getCoins());
            ps.setInt(5, u.getStudyGoal());
            ps.setString(6, u.getUniversity());
            ps.setString(7, u.getYearLevel());

            int status = ps.executeUpdate();

            if(status > 0){

                ResultSet rs = ps.getGeneratedKeys();

                if(rs.next()){

                    userID = rs.getInt(1);

                }

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return userID;

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
                u.setPassword(rs.getString("password"));
                u.setCoins(rs.getInt("coins"));
                u.setStudyGoal(rs.getInt("studyGoal"));
                u.setUniversity(rs.getString("university"));
                u.setYearLevel(rs.getString("yearLevel"));
              

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return u;

    }
    

    

	public static int updateProfile(User u){

	    int status = 0;

	    try{

	        Connection con = DBConnection.getConnection();

	        PreparedStatement ps = con.prepareStatement(
	            "UPDATE user SET fullName=?, email=?, university=?, yearLevel=?, studyGoal=? WHERE userID=?");

	        ps.setString(1, u.getFullName());
	        ps.setString(2, u.getEmail());
	        ps.setString(3, u.getUniversity());
	        ps.setString(4, u.getYearLevel());
	        ps.setInt(5, u.getStudyGoal());
	        ps.setInt(6, u.getUserID());

	        status = ps.executeUpdate();

	    }catch(Exception e){

	        e.printStackTrace();

	    }

	    return status;
	}
	
	public static int updatePassword(int userID, String password){

	    int status = 0;

	    try{

	        Connection con = DBConnection.getConnection();

	        PreparedStatement ps = con.prepareStatement(
	            "UPDATE user SET password=? WHERE userID=?");

	        ps.setString(1, password);
	        ps.setInt(2, userID);

	        status = ps.executeUpdate();

	    }catch(Exception e){

	        e.printStackTrace();

	    }

	    return status;
	}
	
	public static User getUserByID(int userID){

	    User u = null;

	    try{

	        Connection con = DBConnection.getConnection();

	        PreparedStatement ps = con.prepareStatement(
	            "SELECT * FROM user WHERE userID=?");

	        ps.setInt(1, userID);

	        ResultSet rs = ps.executeQuery();

	        if(rs.next()){

	            u = new User();

	            u.setUserID(rs.getInt("userID"));
	            u.setFullName(rs.getString("fullName"));
	            u.setEmail(rs.getString("email"));
	            u.setPassword(rs.getString("password"));
	            u.setCoins(rs.getInt("coins"));
	            u.setStudyGoal(rs.getInt("studyGoal"));
	            u.setUniversity(rs.getString("university"));
	            u.setYearLevel(rs.getString("yearLevel"));

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
		
		public static boolean addCoins(int userID, int coins){

		    boolean status = false;

		    try{

		        Connection conn = DBConnection.getConnection();

		        String sql =
		            "UPDATE user SET coins = coins + ? WHERE userID=?";

		        PreparedStatement ps = conn.prepareStatement(sql);

		        ps.setInt(1, coins);
		        ps.setInt(2, userID);

		        status = ps.executeUpdate() > 0;

		    }catch(Exception e){

		        e.printStackTrace();

		    }

		    return status;
		}
		
		public static boolean deductCoins(int userID, int coins){

		    try(Connection con = DBConnection.getConnection()){

		        String sql =
		        "UPDATE user SET coins = coins - ? WHERE userID=? AND coins>=?";

		        PreparedStatement ps =
		                con.prepareStatement(sql);

		        ps.setInt(1, coins);
		        ps.setInt(2, userID);
		        ps.setInt(3, coins);

		        return ps.executeUpdate() > 0;

		    }catch(Exception e){

		        e.printStackTrace();

		    }

		    return false;
		}
	  
}