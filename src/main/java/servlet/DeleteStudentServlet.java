package servlet;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import dao.StudentDAO;

@WebServlet("/delete")
public class DeleteStudentServlet extends HttpServlet {
    StudentDAO dao = new StudentDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        dao.deleteStudent(id);

        res.sendRedirect("view");
    }
}