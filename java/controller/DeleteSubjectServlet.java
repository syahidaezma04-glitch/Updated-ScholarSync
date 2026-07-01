package controller;

import JSPCrud.SubjectDao;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/DeleteSubjectServlet")
public class DeleteSubjectServlet extends HttpServlet{

    SubjectDao dao = new SubjectDao();

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException{

        int id = Integer.parseInt(request.getParameter("id"));

        dao.deleteSubject(id);

        response.sendRedirect("SettingsServlet");
    }

}