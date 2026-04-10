package dao;
import model.Student;
import java.sql.*;
import java.util.*;

public class StudentDAO {

    public List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            ResultSet rs = con.prepareStatement("SELECT * FROM students ORDER BY name").executeQuery();
            while (rs.next()) {
                Student s = new Student();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPhone(rs.getString("phone"));
                s.setGrade(rs.getString("grade"));
                s.setStatus(rs.getString("status"));
                s.setJoinedDate(rs.getDate("joined_date"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Student getById(int id) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM students WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Student s = new Student();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPhone(rs.getString("phone"));
                s.setGrade(rs.getString("grade"));
                s.setStatus(rs.getString("status"));
                s.setJoinedDate(rs.getDate("joined_date"));
                return s;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void insert(Student s) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO students(name,email,phone,grade,joined_date,status) VALUES(?,?,?,?,?,?)");
            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getGrade());
            ps.setDate(5, s.getJoinedDate());
            ps.setString(6, "active");
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void update(Student s) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "UPDATE students SET name=?,email=?,phone=?,grade=?,status=? WHERE id=?");
            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getGrade());
            ps.setString(5, s.getStatus());
            ps.setInt(6, s.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM students WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public int countActive() {
        try (Connection con = DBConnection.getConnection()) {
            ResultSet rs = con.prepareStatement(
                "SELECT COUNT(*) FROM students WHERE status='active'").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}