package servlet;
import dao.FeeDAO;
import dao.StudentDAO;
import model.Fee;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;

@WebServlet("/fees")
public class FeeServlet extends HttpServlet {
    FeeDAO feeDAO = new FeeDAO();
    StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            feeDAO.delete(Integer.parseInt(req.getParameter("id")));
            res.sendRedirect("fees");
        } else if ("paid".equals(action)) {
            feeDAO.markPaid(Integer.parseInt(req.getParameter("id")));
            res.sendRedirect("fees");
        } else {
            req.setAttribute("fees", feeDAO.getAllFees());
            req.setAttribute("students", studentDAO.getAllStudents());
            req.getRequestDispatcher("fees.jsp").forward(req, res);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Fee f = new Fee();
        f.setStudentId(Integer.parseInt(req.getParameter("student_id")));
        f.setMonth(req.getParameter("month"));
        f.setYear(Integer.parseInt(req.getParameter("year")));
        f.setAmount(Double.parseDouble(req.getParameter("amount")));
        f.setPaid(false);
        feeDAO.insert(f);
        res.sendRedirect("fees");
    }
}