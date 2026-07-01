package controller;

import java.io.IOException;

import JSPCrud.PlantDao;
import JSPCrud.User;
import JSPCrud.UserDao;
import JSPCrud.UserPlantDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/GardenServlet")
public class GardenServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("user");

        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }

        PlantDao plantDao = new PlantDao();

        System.out.println("Plants in database = "
                + plantDao.getAllPlants().size());

        request.setAttribute("plants",
                plantDao.getAllPlants());
        
        UserPlantDao userPlantDao = new UserPlantDao();

        request.setAttribute("plants", plantDao.getAllPlants());
        request.setAttribute("myPlants",
                userPlantDao.getUserPlants(user.getUserID()));

        request.setAttribute("user", user);

        request.getRequestDispatcher("garden.jsp")
               .forward(request,response);
    }
}