package JSPCrud;

import java.sql.*;
import java.util.ArrayList;
import database.DBConnection;

public class SubjectDao {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    // ==========================
    // Get all subjects
    // ==========================

    public ArrayList<Subject> getSubjects(int userID){

        ArrayList<Subject> list = new ArrayList<>();

        try{

            conn = DBConnection.getConnection();

            ps = conn.prepareStatement(
                "SELECT * FROM subject WHERE userID=? ORDER BY subjectCode");

            ps.setInt(1, userID);

            rs = ps.executeQuery();

            while(rs.next()){

                Subject s = new Subject();

                s.setSubjectID(rs.getInt("subjectID"));
                s.setSubjectCode(rs.getString("subjectCode"));
                s.setSubjectName(rs.getString("subjectName"));
                s.setCreditHour(rs.getInt("creditHour"));
                s.setLecturerName(rs.getString("lecturerName"));
                s.setUserID(rs.getInt("userID"));

                list.add(s);
            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return list;
    }

    // ==========================
    // Add Subject
    // ==========================

    public boolean addSubject(Subject s){

        try{

            conn = DBConnection.getConnection();

            ps = conn.prepareStatement(
                "INSERT INTO subject(subjectCode,subjectName,creditHour,lecturerName,userID) VALUES(?,?,?,?,?)");

            ps.setString(1,s.getSubjectCode());
            ps.setString(2,s.getSubjectName());
            ps.setInt(3,s.getCreditHour());
            ps.setString(4,s.getLecturerName());
            ps.setInt(5,s.getUserID());

            return ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return false;
    }

    // ==========================
    // Delete Subject
    // ==========================

    public boolean deleteSubject(int subjectID){

        try{

            conn = DBConnection.getConnection();

            ps = conn.prepareStatement(
                "DELETE FROM subject WHERE subjectID=?");

            ps.setInt(1,subjectID);

            return ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return false;
    }
    public static Subject getSubjectByID(int subjectID){

        Subject s = null;

        try{
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM subject WHERE subjectID=?"
            );

            ps.setInt(1, subjectID);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                s = new Subject();

                s.setSubjectID(rs.getInt("subjectID"));
                s.setSubjectCode(rs.getString("subjectCode"));
                s.setSubjectName(rs.getString("subjectName"));
                s.setCreditHour(rs.getInt("creditHour"));
                s.setLecturerName(rs.getString("lecturerName"));
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return s;
    }
    public static int updateSubject(Subject s){

        int status = 0;

        try{
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE subject SET subjectCode=?, subjectName=?, creditHour=?, lecturerName=? WHERE subjectID=?"
            );

            ps.setString(1, s.getSubjectCode());
            ps.setString(2, s.getSubjectName());
            ps.setInt(3, s.getCreditHour());
            ps.setString(4, s.getLecturerName());
            ps.setInt(5, s.getSubjectID());

            status = ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }
    public int getSubjectCount(int userID){

        int count = 0;

        try{

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM subject WHERE userID=?"
            );

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