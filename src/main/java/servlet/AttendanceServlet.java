package servlet;
import dao.AttendanceDAO;
import dao.StudentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.util.*;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {
    AttendanceDAO attDAO = new AttendanceDAO();
    StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String date = req.getParameter("date");
        if (date == null) date = new java.sql.Date(System.currentTimeMillis()).toString();
        req.setAttribute("date", date);
        req.setAttribute("students", studentDAO.getAllStudents());
        req.setAttribute("attendance", attDAO.getByDate(date));
        req.getRequestDispatcher("attendance.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String date = req.getParameter("date");
        String[] present = req.getParameterValues("present");
        List<Integer> presentIds = new ArrayList<>();
        if (present != null)
            for (String id : present) presentIds.add(Integer.parseInt(id));
        for (var s : studentDAO.getAllStudents()) {
            String status = presentIds.contains(s.getId()) ? "present" : "absent";
            attDAO.saveAttendance(s.getId(), date, status);
        }
        res.sendRedirect("attendance?date=" + date);
    }
}