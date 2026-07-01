package JSPCrud;

import java.sql.*;
import java.util.ArrayList;

import database.DBConnection;

public class UserPlantDao {

    // Collect a plant
    public boolean collectPlant(int userID, int plantID) {

        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO userplant(userID, plantID) VALUES(?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userID);
            ps.setInt(2, plantID);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Get user's collected plants
    public ArrayList<UserPlant> getUserPlants(int userID) {

        ArrayList<UserPlant> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                "SELECT up.*, p.plantName, p.image " +
                "FROM userplant up " +
                "INNER JOIN plant p ON up.plantID = p.plantID " +
                "WHERE up.userID = ? " +
                "ORDER BY up.collectedDate DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userID);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                UserPlant up = new UserPlant();

                up.setUserPlantID(rs.getInt("userPlantID"));
                up.setUserID(rs.getInt("userID"));
                up.setPlantID(rs.getInt("plantID"));

                up.setPlantName(rs.getString("plantName"));
                up.setImage(rs.getString("image"));

                up.setCollectedDate(rs.getTimestamp("collectedDate"));

                list.add(up);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}