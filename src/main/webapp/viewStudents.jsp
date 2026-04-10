<%@ page import="java.util.*, model.Student" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>View Students</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body class="bg-light">
  <nav class="navbar navbar-dark" style="background:#1a1a2e;">
    <div class="container">
      <span class="navbar-brand fw-normal">All Students</span>
      <a href="addStudent.jsp" class="btn btn-sm btn-primary">+ Add new</a>
    </div>
  </nav>
  <div class="container py-4">
    <div class="card border">
      <div class="table-responsive">
        <table class="table table-hover mb-0">
          <thead class="table-light">
            <tr>
              <th>ID</th><th>Name</th><th>Email</th><th>Course</th><th>Action</th>
            </tr>
          </thead>
          <tbody>
            <% List<Student> list = (List<Student>) request.getAttribute("students");
               for(Student s : list) { %>
            <tr>
              <td><code>#<%= s.getId() %></code></td>
              <td><%= s.getName() %></td>
              <td class="text-muted"><%= s.getEmail() %></td>
              <td><span class="badge bg-light text-secondary border"><%= s.getCourse() %></span></td>
              <td>
                <a href="delete?id=<%= s.getId() %>"
                   class="btn btn-sm btn-outline-danger"
                   onclick="return confirm('Delete this student?')">Delete</a>
              </td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</body>
</html>