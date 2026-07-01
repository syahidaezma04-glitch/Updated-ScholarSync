package controller;

import java.io.IOException;
import java.util.ArrayList;

import JSPCrud.Activity;
import JSPCrud.ActivityDao;
import JSPCrud.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CalendarServlet")
public class CalendarServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }

        ActivityDao dao = new ActivityDao();

        ArrayList<Activity> activities =
                dao.getCalendarActivities(user.getUserID());

        request.setAttribute("user", user);
        request.setAttribute("activities", activities);

        request.getRequestDispatcher("calendar.jsp")
               .forward(request, response);
    }
}