package JSPCrud;

public class User {
    private int userID;
    private String fullName;
    private String email;
    private String password;
    private int coins;
    private int studyGoal;

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public int getCoins() {
        return coins;
    }

    public void setCoins(int coins) {
        this.coins = coins;
    }

    public int getStudyGoal() {
        return studyGoal;
    }

    public void setStudyGoal(int studyGoal) {
        this.studyGoal = studyGoal;
    }
}