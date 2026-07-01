package JSPCrud;

import java.sql.Timestamp;

public class UserPlant {

    private int userPlantID;
    private int userID;
    private int plantID;

    private String plantName;
    private String image;

    private Timestamp collectedDate;

    public int getUserPlantID() {
        return userPlantID;
    }

    public void setUserPlantID(int userPlantID) {
        this.userPlantID = userPlantID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getPlantID() {
        return plantID;
    }

    public void setPlantID(int plantID) {
        this.plantID = plantID;
    }

    public String getPlantName() {
        return plantName;
    }

    public void setPlantName(String plantName) {
        this.plantName = plantName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Timestamp getCollectedDate() {
        return collectedDate;
    }

    public void setCollectedDate(Timestamp collectedDate) {
        this.collectedDate = collectedDate;
    }

}