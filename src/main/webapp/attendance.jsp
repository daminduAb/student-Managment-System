<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Student, model.Attendance" %>
<%
  if(session.getAttribute("user") == null) { response.sendRedirect("index.jsp"); return; }
  List<Student> students = (List<Student>) request.getAttribute("students");
  List<Attendance> attList = (List<Attendance>) request.getAttribute("attendance");
  String date = (String) request.getAttribute("date");
  Set<Integer> presentSet = new HashSet<>();
  if(attList != null) for(Attendance a : attList) if("present".equals(a.getStatus())) presentSet.add(a.getStudentId());
%>
<!DOCTYPE html>
<html>
<head>
  <title>Attendance – Rasika ICT</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: #0f172a; color: #e2e8f0; }
    .sidebar { width:230px; background:#1e293b; min-height:100vh; position:fixed; top:0; left:0; padding:1.5rem 1rem; }
    .brand { color:#fff; font-size:16px; font-weight:500; margin-bottom:2rem; display:flex; align-items:center; gap:10px; }
    .brand-logo { width:36px; height:36px; background:#4f8ef7; border-radius:8px; display:flex; align-items:center; justify-content:center; font-weight:700; color:#fff; font-size:14px; }
    .nav-link { color:#94a3b8; border-radius:8px; padding:9px 12px; display:flex; align-items:center; gap:10px; font-size:14px; text-decoration:none; margin-bottom:2px; }
    .nav-link:hover, .nav-link.active { background:#0f172a; color:#fff; }
    .main { margin-left:230px; padding:2rem; }
    .card-dark { background:#1e293b; border-radius:12px; padding:1.5rem; }
    .form-control, .form-select { background:#0f172a; border:1px solid #334155; color:#fff; }
    .form-control:focus { background:#0f172a; border-color:#4f8ef7; color:#fff; box-shadow:none; }
    .att-row { display:flex; align-items:center; justify-content:space-between; padding:10px 0; border-bottom:1px solid #1e293b; }
    .att-name { font-size:14px; }
    .toggle { display:flex; gap:8px; }
    .toggle label { padding:4px 14px; border-radius:20px; font-size:12px; cursor:pointer; }
    .toggle input { display:none; }
    .toggle input:checked + label.present { background:#052e16; color:#4ade80; border:1px solid #166534; }
    .toggle input:not(:checked) + label.present { background:transparent; color:#64748b; border:1px solid #334155; }
    .logout { color:#ef4444; font-size:13px; text-decoration:none; display:block; margin-top:auto; padding:8px 12px; }
  </style>
</head>
<body>
<div class="sidebar d-flex flex-column">
  <div class="brand"><div class="brand-logo">R</div>Rasika ICT</div>
  <a href="dashboard.jsp" class="nav-link">🏠 Dashboard</a>
  <a href="students?action=list" class="nav-link">👨‍🎓 Students</a>
  <a href="fees" class="nav-link">💰 Fees</a>
  <a href="attendance" class="nav-link active">📋 Attendance</a>
  <div style="margin-top:auto;"><a href="logout.jsp" class="logout">🚪 Logout</a></div>
</div>
<div class="main">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h5 class="mb-0 text-white">Mark Attendance</h5>
    <form method="get" action="attendance" class="d-flex gap-2">
      <input type="date" name="date" class="form-control form-control-sm" value="<%= date %>">
      <button class="btn btn-primary btn-sm">Load</button>
    </form>
  </div>
  <div class="card-dark">
    <form action="attendance" method="post">
      <input type="hidden" name="date" value="<%= date %>">
      <% if(students != null) for(Student s : students) { boolean isPresent = presentSet.contains(s.getId()); %>
      <div class="att-row">
        <div class="att-name"><%= s.getName() %> <span style="color:#64748b; font-size:12px;"><%= s.getGrade() %></span></div>
        <div class="toggle">
          <input type="checkbox" name="present" value="<%= s.getId() %>" id="att_<%= s.getId() %>" <%= isPresent?"checked":"" %>>
          <label for="att_<%= s.getId() %>" class="present"><%= isPresent ? "✓ Present" : "Absent" %></label>
        </div>
      </div>
      <% } %>
      <button type="submit" class="btn btn-primary mt-4 w-100">Save Attendance</button>
    </form>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>