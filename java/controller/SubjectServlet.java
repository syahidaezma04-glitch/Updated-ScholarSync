package controller;

import JSPCrud.Subject;
import JSPCrud.SubjectDao;
import JSPCrud.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/SubjectServlet")
public class SubjectServlet extends HttpServlet {

    SubjectDao dao = new SubjectDao();

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        // ==========================
        // ADD SUBJECT
        // ==========================
        if ("add".equals(action)) {

            Subject s = new Subject();

            s.setSubjectCode(request.getParameter("subjectCode"));
            s.setSubjectName(request.getParameter("subjectName"));
            s.setCreditHour(Integer.parseInt(request.getParameter("creditHour")));
            s.setLecturerName(request.getParameter("lecturerName"));
            s.setUserID(user.getUserID());

            dao.addSubject(s);
        }

        // ==========================
        // UPDATE SUBJECT
        // ==========================
        else if ("update".equals(action)) {

            Subject s = new Subject();

            s.setSubjectID(Integer.parseInt(request.getParameter("subjectID")));
            s.setSubjectCode(request.getParameter("subjectCode"));
            s.setSubjectName(request.getParameter("subjectName"));
            s.setCreditHour(Integer.parseInt(request.getParameter("creditHour")));
            s.setLecturerName(request.getParameter("lecturerName"));
            s.setUserID(user.getUserID());

            dao.updateSubject(s);
        }

        response.sendRedirect("SettingsServlet");
    }
}