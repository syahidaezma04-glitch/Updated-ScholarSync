package controller;

import JSPCrud.Subject;
import JSPCrud.SubjectDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/EditSubjectServlet")
public class EditSubjectServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int subjectID =
                Integer.parseInt(request.getParameter("id"));

        Subject subject =
                SubjectDao.getSubjectByID(subjectID);

        request.setAttribute("subject", subject);

        request.getRequestDispatcher("editSubject.jsp")
               .forward(request, response);
    }
}