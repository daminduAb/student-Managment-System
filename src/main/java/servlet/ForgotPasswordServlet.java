package servlet;
import dao.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;

@WebServlet("/forgot")
public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String answer = req.getParameter("security_answer");
        String newPass = req.getParameter("new_password");
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE username=? AND security_answer=?");
            ps.setString(1, username);
            ps.setString(2, answer);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PreparedStatement up = con.prepareStatement(
                    "UPDATE users SET password=? WHERE username=?");
                up.setString(1, newPass);
                up.setString(2, username);
                up.executeUpdate();
                req.setAttribute("success", "Password updated! Please login.");
                req.getRequestDispatcher("index.jsp").forward(req, res);
            } else {
                req.setAttribute("error", "Incorrect username or security answer.");
                req.getRequestDispatcher("forgot.jsp").forward(req, res);
            }
        } catch (Exception e) { e.printStackTrace(); }
    }
}