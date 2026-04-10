<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.*" %>
<%
  if(session.getAttribute("user") == null) { response.sendRedirect("index.jsp"); return; }
  StudentDAO sDao = new StudentDAO();
  FeeDAO fDao = new FeeDAO();
  AttendanceDAO aDao = new AttendanceDAO();
  int totalStudents = sDao.countActive();
  double totalFees = fDao.totalCollected();
  int unpaid = fDao.countUnpaid();
  int presentToday = aDao.countPresentToday();
%>
<!DOCTYPE html>
<html>
<head>
  <title>Dashboard – Rasika ICT</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: #0f172a; color: #e2e8f0; }
    .sidebar { width: 230px; background: #1e293b; min-height: 100vh; position: fixed; top: 0; left: 0; padding: 1.5rem 1rem; }
    .sidebar .brand { color: #fff; font-size: 16px; font-weight: 500; margin-bottom: 2rem; display: flex; align-items: center; gap: 10px; }
    .brand-logo { width: 36px; height: 36px; background: #4f8ef7; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-weight: 700; color: #fff; font-size: 14px; }
    .nav-link { color: #94a3b8; border-radius: 8px; padding: 9px 12px; display: flex; align-items: center; gap: 10px; font-size: 14px; text-decoration: none; margin-bottom: 2px; }
    .nav-link:hover, .nav-link.active { background: #0f172a; color: #fff; }
    .main { margin-left: 230px; padding: 2rem; }
    .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; }
    .topbar h4 { color: #fff; font-weight: 500; margin: 0; }
    #clock { color: #64748b; font-size: 13px; }
    .stat-card { background: #1e293b; border-radius: 12px; padding: 1.25rem 1.5rem; }
    .stat-label { font-size: 12px; color: #64748b; margin-bottom: 4px; }
    .stat-num { font-size: 26px; font-weight: 500; color: #fff; }
    .stat-icon { width: 40px; height: 40px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px; }
    .logout { color: #ef4444; font-size: 13px; text-decoration: none; display: block; margin-top: auto; padding: 8px 12px; }
  </style>
</head>
<body>
<div class="sidebar d-flex flex-column">
  <div class="brand"><div class="brand-logo">R</div>Rasika ICT</div>
  <a href="dashboard.jsp" class="nav-link active">🏠 Dashboard</a>
  <a href="students?action=list" class="nav-link">👨‍🎓 Students</a>
  <a href="fees" class="nav-link">💰 Fees</a>
  <a href="attendance" class="nav-link">📋 Attendance</a>
  <div style="margin-top:auto;">
    <a href="logout.jsp" class="logout">🚪 Logout</a>
  </div>
</div>
<div class="main">
  <div class="topbar">
    <h4>Good morning, <%= session.getAttribute("user") %> 👋</h4>
    <div id="clock"></div>
  </div>
  <div class="row g-3 mb-4">
    <div class="col-md-3">
      <div class="stat-card">
        <div class="stat-label">Active Students</div>
        <div class="stat-num"><%= totalStudents %></div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stat-card">
        <div class="stat-label">Fees Collected</div>
        <div class="stat-num">Rs. <%= String.format("%.0f", totalFees) %></div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stat-card">
        <div class="stat-label">Unpaid Fees</div>
        <div class="stat-num" style="color:#f87171;"><%= unpaid %></div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stat-card">
        <div class="stat-label">Present Today</div>
        <div class="stat-num" style="color:#4ade80;"><%= presentToday %></div>
      </div>
    </div>
  </div>
  <div class="row g-3">
    <div class="col-md-4">
      <div class="stat-card text-center py-4">
        <div style="font-size:32px;">👨‍🎓</div>
        <div class="mt-2" style="color:#94a3b8; font-size:14px;">Manage Students</div>
        <a href="students?action=list" class="btn btn-sm btn-primary mt-3">Open</a>
      </div>
    </div>
    <div class="col-md-4">
      <div class="stat-card text-center py-4">
        <div style="font-size:32px;">💰</div>
        <div class="mt-2" style="color:#94a3b8; font-size:14px;">Fee Records</div>
        <a href="fees" class="btn btn-sm btn-primary mt-3">Open</a>
      </div>
    </div>
    <div class="col-md-4">
      <div class="stat-card text-center py-4">
        <div style="font-size:32px;">📋</div>
        <div class="mt-2" style="color:#94a3b8; font-size:14px;">Mark Attendance</div>
        <a href="attendance" class="btn btn-sm btn-primary mt-3">Open</a>
      </div>
    </div>
  </div>
</div>
<script>
  function updateClock() {
    document.getElementById('clock').textContent = new Date().toLocaleString('en-LK', {
      weekday:'long', year:'numeric', month:'long', day:'numeric',
      hour:'2-digit', minute:'2-digit', second:'2-digit'
    });
  }
  updateClock(); setInterval(updateClock, 1000);
</script>
</body>
</html>