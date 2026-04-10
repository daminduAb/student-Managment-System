<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Rasika ICT Class</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: #0f172a; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
    .login-card { background: #1e293b; border-radius: 16px; padding: 2.5rem; width: 100%; max-width: 400px; }
    .login-card h2 { color: #fff; font-weight: 500; margin-bottom: 4px; }
    .login-card p { color: #94a3b8; font-size: 14px; margin-bottom: 1.5rem; }
    .form-control { background: #0f172a; border: 1px solid #334155; color: #fff; }
    .form-control:focus { background: #0f172a; border-color: #4f8ef7; color: #fff; box-shadow: none; }
    .form-label { color: #94a3b8; font-size: 13px; }
    .btn-login { background: #4f8ef7; border: none; width: 100%; padding: 11px; border-radius: 8px; color: #fff; font-weight: 500; }
    .btn-login:hover { background: #3b7de0; color: #fff; }
    .logo { width: 56px; height: 56px; background: #4f8ef7; border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-bottom: 1rem; font-size: 22px; color: #fff; font-weight: 700; }
    #clock { color: #64748b; font-size: 13px; text-align: center; margin-top: 1rem; }
  </style>
</head>
<body>
  <div class="login-card">
    <div class="logo">R</div>
    <h2>Rasika ICT Class</h2>
    <p>Sign in to manage your students</p>
    <% if(request.getAttribute("error") != null) { %>
      <div class="alert alert-danger py-2" style="font-size:13px;"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if(request.getAttribute("success") != null) { %>
      <div class="alert alert-success py-2" style="font-size:13px;"><%= request.getAttribute("success") %></div>
    <% } %>
    <form action="login" method="post">
      <div class="mb-3">
        <label class="form-label">Username</label>
        <input type="text" name="username" class="form-control" placeholder="rasika" required>
      </div>
      <div class="mb-4">
        <label class="form-label">Password</label>
        <input type="password" name="password" class="form-control" placeholder="••••••••" required>
      </div>
      <button type="submit" class="btn-login">Sign In</button>
    </form>
    <div class="text-center mt-3">
      <a href="forgot.jsp" style="color:#4f8ef7; font-size:13px;">Forgot password?</a>
    </div>
    <div id="clock"></div>
  </div>
  <script>
    function updateClock() {
      const now = new Date();
      document.getElementById('clock').textContent = now.toLocaleString('en-LK', {
        weekday:'long', year:'numeric', month:'long', day:'numeric',
        hour:'2-digit', minute:'2-digit', second:'2-digit'
      });
    }
    updateClock(); setInterval(updateClock, 1000);
  </script>
</body>
</html>