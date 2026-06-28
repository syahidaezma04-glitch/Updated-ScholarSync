package controller;

import JSPCrud.User;
import java.io.IOException;
import JSPCrud.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)

            throws ServletException, IOException {

        String email = request.getParameter("email");

        String password = request.getParameter("password");

        if(UserDao.validate(email,password)){

        	HttpSession session = request.getSession();

        	session.setAttribute("email", email);

        	response.sendRedirect("DashboardServlet");

        }

        else{

            request.setAttribute("msg","Invalid Email or Password");

            RequestDispatcher rd=request.getRequestDispatcher("login.jsp");

            rd.forward(request,response);

        }

    }

}