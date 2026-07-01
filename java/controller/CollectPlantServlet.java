package controller;

import java.io.IOException;

import JSPCrud.Plant;
import JSPCrud.PlantDao;
import JSPCrud.User;
import JSPCrud.UserDao;
import JSPCrud.UserPlantDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CollectPlantServlet")
public class CollectPlantServlet extends HttpServlet{

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException{

        HttpSession session = request.getSession(false);

        if(session == null){

            response.sendRedirect("login.jsp");
            return;

        }

        User user = (User)session.getAttribute("user");

        if(user == null){

            response.sendRedirect("login.jsp");
            return;

        }

        String plant = request.getParameter("plantID");

        System.out.println("plantID received = [" + plant + "]");

        if (plant == null || plant.trim().isEmpty()) {

            response.getWriter().println("plantID is empty!");
            return;

        }

        int plantID = Integer.parseInt(plant);

        PlantDao plantDao = new PlantDao();

        Plant selectedPlant = plantDao.getPlantByID(plantID);

        if(selectedPlant == null){

            response.sendRedirect("GardenServlet");
            return;

        }

        if(user.getCoins() < selectedPlant.getPrice()){

            session.setAttribute("error",
                    "Not enough coins!");

            response.sendRedirect("GardenServlet");
            return;

        }

        boolean success =
                UserDao.deductCoins(user.getUserID(),
                        selectedPlant.getPrice());

        if(success){

            UserPlantDao dao = new UserPlantDao();

            dao.collectPlant(user.getUserID(), plantID);

            user = UserDao.getUserByID(user.getUserID());

            session.setAttribute("user", user);

            session.setAttribute("message",
                    "🌱 " + selectedPlant.getPlantName() +
                    " collected successfully!");

        }

        response.sendRedirect("GardenServlet");

    }

}