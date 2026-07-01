package controller;

import java.io.IOException;
import java.util.ArrayList;

import JSPCrud.Activity;
import JSPCrud.ActivityDao;
import JSPCrud.Subject;
import JSPCrud.SubjectDao;
import JSPCrud.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ActivitiesServlet")
public class ActivitiesServlet extends HttpServlet {

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

        ActivityDao activityDao = new ActivityDao();

        ArrayList<Activity> activities =
                activityDao.getActivities(user.getUserID());

        SubjectDao subjectDao = new SubjectDao();

        ArrayList<Subject> subjects =
                subjectDao.getSubjects(user.getUserID());

        request.setAttribute("activities", activities);
        request.setAttribute("subjects", subjects);

        request.getRequestDispatcher("activity.jsp")
               .forward(request, response);

    }

}