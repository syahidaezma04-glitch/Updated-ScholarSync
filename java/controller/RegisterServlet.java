package controller;

import java.io.IOException;

import JSPCrud.User;
import JSPCrud.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("msg", "Passwords do not match.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if (UserDao.emailExists(email)) {
            request.setAttribute("msg", "Email already exists.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Create user object
        User u = new User();
        u.setFullName(fullName);
        u.setEmail(email);
        u.setPassword(password);

        // Default values
        u.setCoins(0);
        u.setStudyGoal(0);
        u.setUniversity("");
        u.setYearLevel("");
        int status = UserDao.save(u);

        if (status > 0) {
            request.setAttribute("msg", "Registration successful! Please login.");
        } else {
            request.setAttribute("msg", "Registration failed.");
        }

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}