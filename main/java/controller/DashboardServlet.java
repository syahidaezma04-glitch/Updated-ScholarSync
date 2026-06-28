package controller;

import java.io.IOException;

import JSPCrud.User;
import JSPCrud.UserDao;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){

            response.sendRedirect("login.jsp");
            return;

        }

        String email = (String)session.getAttribute("email");

        User user = UserDao.getUserByEmail(email);
        

        int pending = UserDao.getPendingTaskCount(user.getUserID());

        int completed = UserDao.getCompletedTaskCount(user.getUserID());

        request.setAttribute("user", user);
        request.setAttribute("pending", pending);
        request.setAttribute("completed", completed);

        request.getRequestDispatcher("dashboard.jsp").forward(request,response);


    }

}