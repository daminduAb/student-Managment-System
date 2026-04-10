package model;
import java.sql.Date;

public class Student {
    private int id;
    private String name, email, phone, grade, status;
    private Date joinedDate;

    public Student() {}
    public Student(String name, String email, String phone, String grade, Date joinedDate) {
        this.name = name; this.email = email;
        this.phone = phone; this.grade = grade;
        this.joinedDate = joinedDate;
    }
    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getJoinedDate() { return joinedDate; }
    public void setJoinedDate(Date joinedDate) { this.joinedDate = joinedDate; }
}