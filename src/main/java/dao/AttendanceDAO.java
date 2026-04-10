package dao;
import model.Attendance;
import java.sql.*;
import java.util.*;

public class AttendanceDAO {

    public List<Attendance> getByDate(String date) {
        List<Attendance> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT a.*, s.name FROM attendance a " +
                         "JOIN students s ON a.student_id=s.id WHERE a.date=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, date);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Attendance a = new Attendance();
                a.setId(rs.getInt("id"));
                a.setStudentId(rs.getInt("student_id"));
                a.setStudentName(rs.getString("name"));
                a.setStatus(rs.getString("status"));
                a.setDate(rs.getDate("date"));
                list.add(a);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void saveAttendance(int studentId, String date, String status) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement check = con.prepareStatement(
                "SELECT id FROM attendance WHERE student_id=? AND date=?");
            check.setInt(1, studentId);
            check.setString(2, date);
            ResultSet rs = check.executeQuery();
            if (rs.next()) {
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE attendance SET status=? WHERE student_id=? AND date=?");
                ps.setString(1, status);
                ps.setInt(2, studentId);
                ps.setString(3, date);
                ps.executeUpdate();
            } else {
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO attendance(student_id,date,status) VALUES(?,?,?)");
                ps.setInt(1, studentId);
                ps.setString(2, date);
                ps.setString(3, status);
                ps.executeUpdate();
            }
        } catch (Exception e) { e.printStackTrace(); }
    }

    public int countPresentToday() {
        try (Connection con = DBConnection.getConnection()) {
            ResultSet rs = con.prepareStatement(
                "SELECT COUNT(*) FROM attendance WHERE date=CURDATE() AND status='present'").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}