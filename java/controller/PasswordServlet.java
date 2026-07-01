package controller;

import JSPCrud.User;
import JSPCrud.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/PasswordServlet")
public class PasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("user");

        if(sessionUser == null){
            response.sendRedirect("login.jsp");
            return;
        }

        int userID = sessionUser.getUserID();

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check current password
        //User latestUser = UserDao.getUserByID(userID);
        if(!sessionUser.getPassword().equals(currentPassword)){
            request.setAttribute("msg", "Current password is incorrect");
            request.getRequestDispatcher("SettingsServlet").forward(request,response);
            return;
        }

        // Check confirm password
        if(!newPassword.equals(confirmPassword)){
            request.setAttribute("msg", "New passwords do not match");
            request.getRequestDispatcher("SettingsServlet").forward(request,response);
            return;
        }

        UserDao.updatePassword(userID, newPassword);

        // Update session object too
        sessionUser.setPassword(newPassword);
        session.setAttribute("user", sessionUser);

        response.sendRedirect("SettingsServlet");
    }
}