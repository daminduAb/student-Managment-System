package servlet;

import java.io.IOException;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import dao.StudentDAO;

@WebServlet("/view")
public class ViewStudentServlet extends HttpServlet {
    StudentDAO dao = new StudentDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        List list = dao.getAllStudents();
        req.setAttribute("students", list);

        RequestDispatcher rd = req.getRequestDispatcher("viewStudents.jsp");
        rd.forward(req, res);
    }
}