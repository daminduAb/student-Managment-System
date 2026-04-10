package servlet;
import dao.StudentDAO;
import model.Student;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.Date;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    StudentDAO dao = new StudentDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";
        switch (action) {
            case "delete":
                dao.delete(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect("students?action=list");
                break;
            case "edit":
                req.setAttribute("student", dao.getById(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("students.jsp").forward(req, res);
                break;
            default:
                req.setAttribute("students", dao.getAllStudents());
                req.getRequestDispatcher("students.jsp").forward(req, res);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        Student s = new Student();
        s.setName(req.getParameter("name"));
        s.setEmail(req.getParameter("email"));
        s.setPhone(req.getParameter("phone"));
        s.setGrade(req.getParameter("grade"));
        s.setJoinedDate(Date.valueOf(req.getParameter("joined_date")));
        if ("update".equals(action)) {
            s.setId(Integer.parseInt(req.getParameter("id")));
            s.setStatus(req.getParameter("status"));
            dao.update(s);
        } else {
            dao.insert(s);
        }
        res.sendRedirect("students?action=list");
    }
}