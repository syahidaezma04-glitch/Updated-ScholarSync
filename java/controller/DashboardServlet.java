package controller;

import java.io.IOException;
import java.util.ArrayList;

import JSPCrud.Activity;
import JSPCrud.ActivityDao;
import JSPCrud.SubjectDao;
import JSPCrud.TimerSetting;
import JSPCrud.TimerSettingDao;
import JSPCrud.User;
import JSPCrud.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Reload latest user information
        user = UserDao.getUserByID(user.getUserID());

        // Task statistics
        int pending = UserDao.getPendingTaskCount(user.getUserID());
        int completed = UserDao.getCompletedTaskCount(user.getUserID());

        // Subject count
        SubjectDao subjectDao = new SubjectDao();
        int subjectCount =
                subjectDao.getSubjectCount(user.getUserID());

        // Activities
        ActivityDao activityDao = new ActivityDao();

        ArrayList<Activity> recentActivities =
                activityDao.getRecentActivities(user.getUserID());

        ArrayList<Activity> todayActivities =
                activityDao.getTodayActivities(user.getUserID());

        // Timer
        TimerSettingDao timerDao = new TimerSettingDao();

        TimerSetting setting =
                timerDao.getTimerSetting(user.getUserID());

        // Send to JSP
        request.setAttribute("user", user);
        request.setAttribute("pending", pending);
        request.setAttribute("completed", completed);
        request.setAttribute("subjectCount", subjectCount);
        request.setAttribute("recentActivities", recentActivities);
        request.setAttribute("todayActivities", todayActivities);
        request.setAttribute("setting", setting);

        request.getRequestDispatcher("dashboard.jsp")
               .forward(request, response);
    }
}