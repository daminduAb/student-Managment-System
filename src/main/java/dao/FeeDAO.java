package dao;
import model.Fee;
import java.sql.*;
import java.util.*;

public class FeeDAO {

    public List<Fee> getAllFees() {
        List<Fee> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT f.*, s.name as student_name FROM fees f " +
                         "JOIN students s ON f.student_id=s.id ORDER BY f.year DESC, f.month";
            ResultSet rs = con.prepareStatement(sql).executeQuery();
            while (rs.next()) {
                Fee f = new Fee();
                f.setId(rs.getInt("id"));
                f.setStudentId(rs.getInt("student_id"));
                f.setStudentName(rs.getString("student_name"));
                f.setMonth(rs.getString("month"));
                f.setYear(rs.getInt("year"));
                f.setAmount(rs.getDouble("amount"));
                f.setPaid(rs.getBoolean("paid"));
                f.setPaidDate(rs.getDate("paid_date"));
                list.add(f);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void insert(Fee f) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO fees(student_id,month,year,amount,paid) VALUES(?,?,?,?,?)");
            ps.setInt(1, f.getStudentId());
            ps.setString(2, f.getMonth());
            ps.setInt(3, f.getYear());
            ps.setDouble(4, f.getAmount());
            ps.setBoolean(5, f.isPaid());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void markPaid(int id) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "UPDATE fees SET paid=true, paid_date=CURDATE() WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM fees WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public double totalCollected() {
        try (Connection con = DBConnection.getConnection()) {
            ResultSet rs = con.prepareStatement(
                "SELECT SUM(amount) FROM fees WHERE paid=true").executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int countUnpaid() {
        try (Connection con = DBConnection.getConnection()) {
            ResultSet rs = con.prepareStatement(
                "SELECT COUNT(*) FROM fees WHERE paid=false").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}