package controller;

import JSPCrud.User;
import JSPCrud.UserDao;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = UserDao.login(email, password);

        if(user != null){

            HttpSession session = request.getSession();

            // Save user object
            session.setAttribute("user", user);

            // Save user ID (needed by TimerServlet)
            session.setAttribute("userID", user.getUserID());

            response.sendRedirect("DashboardServlet");

        }else{

            request.setAttribute("msg", "Invalid Email or Password");

            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);

        }
    }
}