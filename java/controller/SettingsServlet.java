package controller;

import JSPCrud.User;
import JSPCrud.UserDao;

import JSPCrud.TimerSetting;
import JSPCrud.TimerSettingDao;

import JSPCrud.NotificationSetting;
import JSPCrud.NotificationSettingDao;

import JSPCrud.Subject;
import JSPCrud.SubjectDao;
import java.util.ArrayList;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/SettingsServlet")
public class SettingsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){
            response.sendRedirect("login.jsp");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        if(sessionUser == null){
            response.sendRedirect("login.jsp");
            return;
        }

        // ======================
        // USER
        // ======================

        User fullUser =
                UserDao.getUserByID(sessionUser.getUserID());

        request.setAttribute("user", fullUser);

        // ======================
        // TIMER SETTINGS
        // ======================

        TimerSettingDao timerDao =
                new TimerSettingDao();

        TimerSetting setting =
                timerDao.getTimerSetting(fullUser.getUserID());

        if(setting == null){

            timerDao.createDefaultSetting(fullUser.getUserID());

            setting =
                    timerDao.getTimerSetting(fullUser.getUserID());
        }

        request.setAttribute("setting", setting);

        // ======================
        // NOTIFICATION SETTINGS
        // ======================

        NotificationSettingDao notificationDao =
                new NotificationSettingDao();

        NotificationSetting notification =
                notificationDao.getNotification(fullUser.getUserID());

        if(notification == null){

            notificationDao.createDefaultNotification(fullUser.getUserID());

            notification =
                    notificationDao.getNotification(fullUser.getUserID());
        }

        request.setAttribute("notification", notification);
        
        SubjectDao subjectDao = new SubjectDao();

        ArrayList<Subject> subjects =
                subjectDao.getSubjects(fullUser.getUserID());

        request.setAttribute("subjects", subjects);

        // ======================
        // OPEN SETTINGS PAGE
        // ======================

        request.getRequestDispatcher("settings.jsp")
               .forward(request, response);
    }
    
    
}