package controller;

import java.io.IOException;

import JSPCrud.NotificationSetting;
import JSPCrud.NotificationSettingDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    NotificationSettingDao dao = new NotificationSettingDao();

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("userID") == null){
            response.sendRedirect("login.jsp");
            return;
        }

        int userID = (Integer) session.getAttribute("userID");

        NotificationSetting n = new NotificationSetting();

        n.setUserID(userID);

        n.setSessionSound(
                request.getParameter("sessionSound") != null);

        n.setSoundTheme(
                request.getParameter("soundTheme"));

        n.setVolume(
                Integer.parseInt(request.getParameter("volume")));

        n.setDueReminder(
                request.getParameter("dueReminder") != null);

        n.setRemindBefore(
                request.getParameter("remindBefore"));

        n.setDailyReminder(
                request.getParameter("dailyReminder") != null);

        n.setReminderTime(
                request.getParameter("reminderTime"));

        dao.updateNotification(n);

        response.sendRedirect("SettingsServlet");
    }
}