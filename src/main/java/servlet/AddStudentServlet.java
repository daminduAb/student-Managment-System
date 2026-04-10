package servlet;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import dao.StudentDAO;
import model.Student;

@WebServlet("/add")
public class AddStudentServlet extends HttpServlet {
    StudentDAO dao = new StudentDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String course = req.getParameter("course");

        Student s = new Student(name, email, course);
        dao.insertStudent(s);

        res.sendRedirect("view");
    }
}