package controller;

import JSPCrud.User;
import JSPCrud.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("user");

        int userID = sessionUser.getUserID();

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String university = request.getParameter("university");
        String yearLevel = request.getParameter("yearLevel");

        User u = new User();
        u.setUserID(userID);
        u.setFullName(fullName);
        u.setEmail(email);
        u.setUniversity(university);
        u.setYearLevel(yearLevel);

        UserDao.updateProfile(u);

        response.sendRedirect("SettingsServlet");
    }
}