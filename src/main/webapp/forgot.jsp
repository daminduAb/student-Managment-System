<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Forgot Password</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: #0f172a; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
    .card { background: #1e293b; border-radius: 16px; padding: 2rem; width: 100%; max-width: 400px; border: none; }
    .form-control { background: #0f172a; border: 1px solid #334155; color: #fff; }
    .form-control:focus { background: #0f172a; border-color: #4f8ef7; color: #fff; box-shadow: none; }
    .form-label { color: #94a3b8; font-size: 13px; }
    h5 { color: #fff; }
    small { color: #64748b; }
  </style>
</head>
<body>
  <div class="card">
    <h5 class="mb-1">Reset Password</h5>
    <small class="d-block mb-3">Security answer is your favourite colour</small>
    <% if(request.getAttribute("error") != null) { %>
      <div class="alert alert-danger py-2" style="font-size:13px;"><%= request.getAttribute("error") %></div>
    <% } %>
    <form action="forgot" method="post">
      <div class="mb-3">
        <label class="form-label">Username</label>
        <input type="text" name="username" class="form-control" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Security Answer</label>
        <input type="text" name="security_answer" class="form-control" placeholder="Your favourite colour" required>
      </div>
      <div class="mb-4">
        <label class="form-label">New Password</label>
        <input type="password" name="new_password" class="form-control" required>
      </div>
      <button type="submit" class="btn btn-primary w-100">Reset Password</button>
    </form>
    <div class="text-center mt-3">
      <a href="index.jsp" style="color:#4f8ef7; font-size:13px;">← Back to login</a>
    </div>
  </div>
</body>
</html>