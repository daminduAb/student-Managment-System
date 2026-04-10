<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Add Student</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body class="bg-light">
  <nav class="navbar navbar-dark" style="background:#1a1a2e;">
    <div class="container">
      <span class="navbar-brand fw-normal">Add Student</span>
      <a href="index.jsp" class="text-white-50 text-decoration-none small">← Home</a>
    </div>
  </nav>
  <div class="container py-5" style="max-width:480px;">
    <h5 class="mb-1">Register new student</h5>
    <p class="text-muted small mb-4">Fill in the details to enroll a student.</p>
    <div class="card border p-4">
      <form action="add" method="post">
        <div class="mb-3">
          <label class="form-label small fw-semibold">Full Name</label>
          <input type="text" name="name" class="form-control" placeholder="e.g. Kasun Perera" required>
        </div>
        <div class="mb-3">
          <label class="form-label small fw-semibold">Email Address</label>
          <input type="email" name="email" class="form-control" placeholder="e.g. kasun@email.com" required>
        </div>
        <div class="mb-4">
          <label class="form-label small fw-semibold">Course</label>
          <input type="text" name="course" class="form-control" placeholder="e.g. Computer Science" required>
        </div>
        <button type="submit" class="btn btn-dark w-100">Add Student</button>
      </form>
    </div>
  </div>
</body>
</html>