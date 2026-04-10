<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Fee, model.Student" %>
<%
  if(session.getAttribute("user") == null) { response.sendRedirect("index.jsp"); return; }
  List<Fee> fees = (List<Fee>) request.getAttribute("fees");
  List<Student> students = (List<Student>) request.getAttribute("students");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Fees – Rasika ICT</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background:#0f172a; color:#e2e8f0; }
    .sidebar { width:230px; background:#1e293b; min-height:100vh; position:fixed; top:0; left:0; padding:1.5rem 1rem; }
    .brand { color:#fff; font-size:16px; font-weight:500; margin-bottom:2rem; display:flex; align-items:center; gap:10px; }
    .brand-logo { width:36px; height:36px; background:#4f8ef7; border-radius:8px; display:flex; align-items:center; justify-content:center; font-weight:700; color:#fff; font-size:14px; }
    .nav-link { color:#94a3b8; border-radius:8px; padding:9px 12px; display:flex; align-items:center; gap:10px; font-size:14px; text-decoration:none; margin-bottom:2px; }
    .nav-link:hover, .nav-link.active { background:#0f172a; color:#fff; }
    .main { margin-left:230px; padding:2rem; }
    .card-dark { background:#1e293b; border-radius:12px; border:none; }
    table { color:#e2e8f0; }
    thead { background:#0f172a; }
    th { color:#64748b; font-size:12px; font-weight:500; letter-spacing:0.5px; text-transform:uppercase; border:none !important; padding:12px 16px; }
    td { border-color:#334155 !important; font-size:14px; vertical-align:middle; padding:12px 16px; }
    tr:hover td { background:#0f172a !important; }
    .badge-paid { background:#052e16; color:#4ade80; padding:3px 10px; border-radius:20px; font-size:12px; }
    .badge-unpaid { background:#450a0a; color:#f87171; padding:3px 10px; border-radius:20px; font-size:12px; }
    .form-control, .form-select { background:#0f172a; border:1px solid #334155; color:#fff; }
    .form-control:focus, .form-select:focus { background:#0f172a; border-color:#4f8ef7; color:#fff; box-shadow:none; }
    .form-label { color:#94a3b8; font-size:13px; }
    .modal-content { background:#1e293b; border:1px solid #334155; }
    .modal-header { border-color:#334155; }
    .stat-card { background:#1e293b; border-radius:12px; padding:1.25rem 1.5rem; }
    .stat-label { font-size:12px; color:#64748b; margin-bottom:4px; }
    .stat-num { font-size:24px; font-weight:500; }
    .logout { color:#ef4444; font-size:13px; text-decoration:none; display:block; margin-top:auto; padding:8px 12px; }
  </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar d-flex flex-column">
  <div class="brand"><div class="brand-logo">R</div>Rasika ICT</div>
  <a href="dashboard.jsp" class="nav-link">🏠 Dashboard</a>
  <a href="students?action=list" class="nav-link">👨‍🎓 Students</a>
  <a href="fees" class="nav-link active">💰 Fees</a>
  <a href="attendance" class="nav-link">📋 Attendance</a>
  <div style="margin-top:auto;"><a href="logout.jsp" class="logout">🚪 Logout</a></div>
</div>

<!-- Main Content -->
<div class="main">

  <!-- Top bar -->
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h5 class="mb-0 text-white">Fee Records</h5>
    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addFeeModal">+ Add Fee</button>
  </div>

  <!-- Summary Cards -->
  <%
    double totalCollected = 0;
    int unpaidCount = 0;
    if(fees != null) for(Fee f : fees) {
      if(f.isPaid()) totalCollected += f.getAmount();
      else unpaidCount++;
    }
  %>
  <div class="row g-3 mb-4">
    <div class="col-md-4">
      <div class="stat-card">
        <div class="stat-label">Total Collected</div>
        <div class="stat-num" style="color:#4ade80;">Rs. <%= String.format("%.2f", totalCollected) %></div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="stat-card">
        <div class="stat-label">Unpaid Records</div>
        <div class="stat-num" style="color:#f87171;"><%= unpaidCount %></div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="stat-card">
        <div class="stat-label">Total Records</div>
        <div class="stat-num" style="color:#fff;"><%= fees != null ? fees.size() : 0 %></div>
      </div>
    </div>
  </div>

  <!-- Fee Table -->
  <div class="card-dark p-0">
    <table class="table table-hover mb-0">
      <thead>
        <tr>
          <th>ID</th>
          <th>Student</th>
          <th>Month</th>
          <th>Year</th>
          <th>Amount (Rs.)</th>
          <th>Status</th>
          <th>Paid Date</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% if(fees != null && !fees.isEmpty()) {
             for(Fee f : fees) { %>
        <tr>
          <td><code style="color:#64748b">#<%= f.getId() %></code></td>
          <td><%= f.getStudentName() %></td>
          <td><%= f.getMonth() %></td>
          <td><%= f.getYear() %></td>
          <td>Rs. <%= String.format("%.2f", f.getAmount()) %></td>
          <td>
            <span class="<%= f.isPaid() ? "badge-paid" : "badge-unpaid" %>">
              <%= f.isPaid() ? "✓ Paid" : "✗ Unpaid" %>
            </span>
          </td>
          <td style="color:#64748b"><%= f.getPaidDate() != null ? f.getPaidDate() : "—" %></td>
          <td>
            <% if(!f.isPaid()) { %>
              <a href="fees?action=paid&id=<%= f.getId() %>"
                 class="btn btn-outline-success btn-sm"
                 onclick="return confirm('Mark this fee as paid?')">✓ Mark Paid</a>
            <% } %>
            <a href="fees?action=delete&id=<%= f.getId() %>"
               class="btn btn-outline-danger btn-sm"
               onclick="return confirm('Delete this fee record?')">Delete</a>
          </td>
        </tr>
        <%   }
           } else { %>
        <tr>
          <td colspan="8" class="text-center py-4" style="color:#64748b;">
            No fee records found. Click "+ Add Fee" to get started.
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
</div>

<!-- Add Fee Modal -->
<div class="modal fade" id="addFeeModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h6 class="modal-title text-white">Add Fee Record</h6>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <form action="fees" method="post">
          <div class="mb-3">
            <label class="form-label">Student</label>
            <select class="form-select" name="student_id" required>
              <option value="">Select student...</option>
              <% if(students != null) for(Student s : students) { %>
                <option value="<%= s.getId() %>"><%= s.getName() %> (<%= s.getGrade() %>)</option>
              <% } %>
            </select>
          </div>
          <div class="row g-2">
            <div class="col-6">
              <label class="form-label">Month</label>
              <select class="form-select" name="month" required>
                <option>January</option><option>February</option><option>March</option>
                <option>April</option><option>May</option><option>June</option>
                <option>July</option><option>August</option><option>September</option>
                <option>October</option><option>November</option><option>December</option>
              </select>
            </div>
            <div class="col-6">
              <label class="form-label">Year</label>
              <input type="number" class="form-control" name="year"
                     value="2025" min="2020" max="2030" required>
            </div>
          </div>
          <div class="mt-3 mb-4">
            <label class="form-label">Amount (Rs.)</label>
            <input type="number" class="form-control" name="amount"
                   placeholder="e.g. 2500" step="0.01" min="0" required>
          </div>
          <button type="submit" class="btn btn-primary w-100">Add Fee Record</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>