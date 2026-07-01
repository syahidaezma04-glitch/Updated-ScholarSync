package controller;

import java.io.IOException;

import JSPCrud.User;
import JSPCrud.UserDao;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RewardCoinServlet")
public class RewardCoinServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int reward =
                Integer.parseInt(request.getParameter("reward"));

        UserDao.addCoins(user.getUserID(), reward);

        // Reload latest user
        user = UserDao.getUserByID(user.getUserID());

        // Update session
        session.setAttribute("user", user);

        response.setContentType("text/plain");
        response.getWriter().print(user.getCoins());
    }
}