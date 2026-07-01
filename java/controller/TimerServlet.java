package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import JSPCrud.TimerSetting;
import JSPCrud.TimerSettingDao;

/**
 * Servlet implementation class TimerServlet
 */
@WebServlet("/TimerServlet")
	public class TimerServlet extends HttpServlet {

	    private static final long serialVersionUID = 1L;

	    private TimerSettingDao dao;

	    @Override
	    public void init() throws ServletException {
	        dao = new TimerSettingDao();
	    }

	    // ===========================
	    // Display Timer Page
	    // ===========================

	    @Override
	    protected void doGet(HttpServletRequest request,
	                         HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false);

	        if (session == null || session.getAttribute("userID") == null) {

	            response.sendRedirect("login.jsp");
	            return;
	        }

	        int userID = (Integer) session.getAttribute("userID");

	        TimerSetting setting = dao.getTimerSetting(userID);

	        // Create default setting if first login
	        if (setting == null) {

	            dao.createDefaultSetting(userID);

	            setting = dao.getTimerSetting(userID);

	        }

	        request.setAttribute("setting", setting);

	        // Dummy values for now
	        request.setAttribute("currentSession", 1);

	        request.setAttribute("todaySessions", 0);

	        request.setAttribute("todayMinutes", 0);

	        request.setAttribute("todayBreaks", 0);

	        request.setAttribute("todayCoins", 0);

	        request.setAttribute("studyPlans", null);

	        request.setAttribute("sessionLogs", null);

	        request.getRequestDispatcher("timer.jsp")
	                .forward(request, response);

	    }

	    // ===========================
	    // Save Timer Settings
	    // ===========================

	    @Override
	    protected void doPost(HttpServletRequest request,
	                          HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false);

	        if (session == null || session.getAttribute("userID") == null) {

	            response.sendRedirect("login.jsp");
	            return;

	        }

	        int userID = (Integer) session.getAttribute("userID");

	        TimerSetting setting = new TimerSetting();

	        setting.setUserID(userID);

	        setting.setFocusTime(
	                Integer.parseInt(request.getParameter("focusTime")));

	        setting.setShortBreak(
	                Integer.parseInt(request.getParameter("shortBreak")));

	        setting.setLongBreak(
	                Integer.parseInt(request.getParameter("longBreak")));

	        setting.setSessionsUntilLongBreak(
	                Integer.parseInt(request.getParameter("sessionsUntilLongBreak")));

	        setting.setAutoBreak(
	                request.getParameter("autoBreak") != null);

	        setting.setAutoFocus(
	                request.getParameter("autoFocus") != null);

	        setting.setCoinsPerSession(
	                Integer.parseInt(request.getParameter("coinsPerSession")));

	        boolean success = dao.updateTimerSetting(setting);

	        if (success) {

	            request.getSession().setAttribute(
	                    "message",
	                    "Timer settings updated successfully.");

	        } else {

	            request.getSession().setAttribute(
	                    "error",
	                    "Unable to update timer settings.");

	        }

	        response.sendRedirect("TimerServlet");

	    }

}
