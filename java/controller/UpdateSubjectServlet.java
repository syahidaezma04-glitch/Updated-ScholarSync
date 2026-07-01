package controller;

import JSPCrud.Subject;
import JSPCrud.SubjectDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/UpdateSubjectServlet")
public class UpdateSubjectServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        Subject s = new Subject();

        s.setSubjectID(
                Integer.parseInt(request.getParameter("subjectID")));

        s.setSubjectCode(
                request.getParameter("subjectCode"));

        s.setSubjectName(
                request.getParameter("subjectName"));

        s.setCreditHour(
                Integer.parseInt(request.getParameter("creditHour")));

        s.setLecturerName(
                request.getParameter("lecturerName"));

        SubjectDao.updateSubject(s);

        response.sendRedirect("SettingsServlet");
    }
}