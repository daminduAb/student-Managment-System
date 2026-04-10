package model;
import java.sql.Date;

public class Fee {
    private int id, studentId, year;
    private String studentName, month;
    private double amount;
    private boolean paid;
    private Date paidDate;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getMonth() { return month; }
    public void setMonth(String month) { this.month = month; }
    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public boolean isPaid() { return paid; }
    public void setPaid(boolean paid) { this.paid = paid; }
    public Date getPaidDate() { return paidDate; }
    public void setPaidDate(Date paidDate) { this.paidDate = paidDate; }
}