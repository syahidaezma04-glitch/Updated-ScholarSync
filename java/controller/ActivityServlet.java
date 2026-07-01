package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

import JSPCrud.Activity;
import JSPCrud.ActivityDao;
import JSPCrud.SubjectDao;
import JSPCrud.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ActivityServlet")
public class ActivityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ActivityDao activityDao = new ActivityDao();
    private SubjectDao subjectDao = new SubjectDao();

    // ==========================================
    // DISPLAY ACTIVITY PAGE
    // ==========================================
    @Override
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

        request.setAttribute("activities",
                activityDao.getActivities(user.getUserID()));

        request.setAttribute("subjects",
                subjectDao.getSubjects(user.getUserID()));

        request.getRequestDispatcher("/activity.jsp")
               .forward(request, response);
    }

    // ==========================================
    // ADD / UPDATE ACTIVITY
    // ==========================================
    @Override
    protected void doPost(HttpServletRequest request,
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

        String action = request.getParameter("action");

        Activity activity = new Activity();

        activity.setTitle(request.getParameter("title"));
        activity.setDetails(request.getParameter("details"));

        activity.setSubjectID(
                Integer.parseInt(request.getParameter("subjectID")));

        activity.setActivityDate(
                Date.valueOf(request.getParameter("activityDate")));

        activity.setActivityTime(
                Time.valueOf(request.getParameter("activityTime") + ":00"));

        activity.setActivityDays(
                request.getParameter("activityDays"));

        activity.setUserID(user.getUserID());

        if ("update".equals(action)) {

            activity.setActivityID(
                    Integer.parseInt(
                            request.getParameter("activityID")));

            String status = request.getParameter("status");

            if (status == null || status.isEmpty()) {
                status = "Current";
            }

            activity.setStatus(status);

            activityDao.updateActivity(activity);

        } else {

            activity.setStatus("Current");

            activityDao.addActivity(activity);
        }

        response.sendRedirect(request.getContextPath() + "/ActivityServlet");
    }
}