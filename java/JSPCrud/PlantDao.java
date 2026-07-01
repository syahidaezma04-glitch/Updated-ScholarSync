package JSPCrud;

import java.sql.*;
import java.util.ArrayList;

import database.DBConnection;

public class PlantDao {

    // Get all plants from the shop
    public ArrayList<Plant> getAllPlants() {

        ArrayList<Plant> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM plant";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Plant plant = new Plant();

                plant.setPlantID(rs.getInt("plantID"));
                plant.setPlantName(rs.getString("plantName"));
                plant.setPrice(rs.getInt("price"));
                plant.setImage(rs.getString("image"));

                list.add(plant);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }

    // Get one plant by ID
    public Plant getPlantByID(int id) {

        Plant plant = null;

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM plant WHERE plantID=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                plant = new Plant();

                plant.setPlantID(rs.getInt("plantID"));
                plant.setPlantName(rs.getString("plantName"));
                plant.setPrice(rs.getInt("price"));
                plant.setImage(rs.getString("image"));

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return plant;
    }

}