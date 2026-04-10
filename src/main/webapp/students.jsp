<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Student" %>
<%
  if(session.getAttribute("user") == null) { response.sendRedirect("index.jsp"); return; }
  List<Student> students = (List<Student>) request.getAttribute("students");
  Student editStudent = (Student) request.getAttribute("student");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Students – Rasika ICT</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: #0f172a; color: #e2e8f0; }
    .sidebar { width: 230px; background: #1e293b; min-height: 100vh; position: fixed; top: 0; left: 0; padding: 1.5rem 1rem; }
    .brand { color: #fff; font-size: 16px; font-weight: 500; margin-bottom: 2rem; display: flex; align-items: center; gap: 10px; }
    .brand-logo { width: 36px; height: 36px; background: #4f8ef7; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-weight: 700; color: #fff; font-size: 14px; }
    .nav-link { color: #94a3b8; border-radius: 8px; padding: 9px 12px; display: flex; align-items: center; gap: 10px; font-size: 14px; text-decoration: none; margin-bottom: 2px; }
    .nav-link:hover, .nav-link.active { background: #0f172a; color: #fff; }
    .main { margin-left: 230px; padding: 2rem; }
    .card-dark { background: #1e293b; border-radius: 12px; border: none; }
    table { color: #e2e8f0; }
    thead { background: #0f172a; }
    th { color: #64748b; font-size: 12px; font-weight: 500; letter-spacing: 0.5px; text-transform: uppercase; border: none !important; }
    td { border-color: #334155 !important; font-size: 14px; }
    tr:hover td { background: #0f172a !important; }
    .badge-active { background: #052e16; color: #4ade80; padding: 3px 10px; border-radius: 20px; font-size: 12px; }
    .badge-inactive { background: #450a0a; color: #f87171; padding: 3px 10px; border-radius: 20px; font-size: 12px; }
    .form-control, .form-select { background: #0f172a; border: 1px solid #334155; color: #fff; }
    .form-control:focus, .form-select:focus { background: #0f172a; border-color: #4f8ef7; color: #fff; box-shadow: none; }
    .form-label { color: #94a3b8; font-size: 13px; }
    .logout { color: #ef4444; font-size: 13px; text-decoration: none; display: block; margin-top: auto; padding: 8px 12px; }
  </style>
</head>
<body>
<div class="sidebar d-flex flex-column">
  <div class="brand"><div class="brand-logo">R</div>Rasika ICT</div>
  <a href="dashboard.jsp" class="nav-link">🏠 Dashboard</a>
  <a href="students?action=list" class="nav-link active">👨‍🎓 Students</a>
  <a href="fees" class="nav-link">💰 Fees</a>
  <a href="attendance" class="nav-link">📋 Attendance</a>
  <div style="margin-top:auto;"><a href="logout.jsp" class="logout">🚪 Logout</a></div>
</div>
<div class="main">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h5 class="mb-0 text-white">Students</h5>
    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addModal">+ Add Student</button>
  </div>
  <% if(editStudent != null) { %>
  <div class="card-dark p-4 mb-4">
    <h6 class="text-white mb-3">Edit Student</h6>
    <form action="students" method="post">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="id" value="<%= editStudent.getId() %>">
      <div class="row g-3">
        <div class="col-md-3"><label class="form-label">Name</label><input class="form-control" name="name" value="<%= editStudent.getName() %>" required></div>
        <div class="col-md-3"><label class="form-label">Email</label><input class="form-control" name="email" value="<%= editStudent.getEmail() %>"></div>
        <div class="col-md-2"><label class="form-label">Phone</label><input class="form-control" name="phone" value="<%= editStudent.getPhone() %>"></div>
        <div class="col-md-2"><label class="form-label">Grade</label><input class="form-control" name="grade" value="<%= editStudent.getGrade() %>"></div>
        <div class="col-md-2"><label class="form-label">Joined</label><input type="date" class="form-control" name="joined_date" value="<%= editStudent.getJoinedDate() %>"></div>
        <div class="col-md-2"><label class="form-label">Status</label>
          <select class="form-select" name="status">
            <option <%= "active".equals(editStudent.getStatus())?"selected":"" %>>active</option>
            <option <%= "inactive".equals(editStudent.getStatus())?"selected":"" %>>inactive</option>
          </select>
        </div>
      </div>
      <button class="btn btn-success btn-sm mt-3">Save Changes</button>
      <a href="students?action=list" class="btn btn-secondary btn-sm mt-3">Cancel</a>
    </form>
  </div>
  <% } %>
  <div class="card-dark p-0">
    <table class="table table-hover mb-0">
      <thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Grade</th><th>Joined</th><th>Status</th><th>Actions</th></tr></thead>
      <tbody>
        <% if(students != null) for(Student s : students) { %>
        <tr>
          <td><code style="color:#64748b">#<%= s.getId() %></code></td>
          <td><%= s.getName() %></td>
          <td style="color:#64748b"><%= s.getEmail() %></td>
          <td><%= s.getPhone() %></td>
          <td><%= s.getGrade() %></td>
          <td style="color:#64748b"><%= s.getJoinedDate() %></td>
          <td><span class="<%= "active".equals(s.getStatus()) ? "badge-active" : "badge-inactive" %>"><%= s.getStatus() %></span></td>
          <td>
            <a href="students?action=edit&id=<%= s.getId() %>" class="btn btn-outline-warning btn-sm">Edit</a>
            <a href="students?action=delete&id=<%= s.getId() %>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Delete?')">Delete</a>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
</div>

<!-- Add Modal -->
<div class="modal fade" id="addModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content" style="background:#1e293b; border:1px solid #334155;">
      <div class="modal-header" style="border-color:#334155;">
        <h6 class="modal-title text-white">Add New Student</h6>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <form action="students" method="post" id="addForm">
          <input type="hidden" name="action" value="insert">
          <div class="mb-3"><label class="form-label">Full Name</label><input class="form-control" name="name" required></div>
          <div class="mb-3"><label class="form-label">Email</label><input type="email" class="form-control" name="email"></div>
          <div class="mb-3"><label class="form-label">Phone</label><input class="form-control" name="phone"></div>
          <div class="mb-3"><label class="form-label">Grade</label><input class="form-control" name="grade" placeholder="e.g. Grade 11"></div>
          <div class="mb-3"><label class="form-label">Joined Date</label><input type="date" class="form-control" name="joined_date" required></div>
          <button type="submit" class="btn btn-primary w-100">Add Student</button>
        </form>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>