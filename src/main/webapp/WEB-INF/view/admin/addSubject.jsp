<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Add Subject - Admin Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/addSubject.css"/>

</head>

<body>

<!-- Background Animation -->
<div class="background-animation">
  <svg viewBox="0 0 1440 320" preserveAspectRatio="none" style="width:100%; height:100%;">
    <path fill="#ffffff" fill-opacity="0.3"
          d="M0,96L48,128C96,160,192,224,288,245.3C384,267,480,245,576,218.7C672,192,768,160,864,154.7C960,149,1056,171,1152,160C1248,149,1344,107,1392,85.3L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
    </path>
  </svg>
</div>

<!-- Navbar -->
<div class="navbar">📘 Add New Subject</div>

<!-- Main Content -->
<main>
  <div class="form-container">
    <h2>Add Subject</h2>

    <!-- Success or Error Messages -->
    <c:if test="${not empty successMsg}">
      <div class="message success-msg">${successMsg}</div>
    </c:if>
    <c:if test="${not empty errorMsg}">
      <div class="message error-msg">${errorMsg}</div>
    </c:if>

    <form action="saveSubject" method="post">
      <div class="mb-3">
        <label for="subjectName" class="form-label">Subject Name</label>
        <input type="text" class="form-control" id="subjectName" name="name" required placeholder="Enter subject name" />
      </div>
      <div class="d-grid mt-4">
        <button type="submit" class="btn btn-submit">Add Subject</button>
      </div>
    </form>

    <!-- Back Button -->
    <div class="text-center mt-3">
      <a href="subjectList" class="btn-back">← Back to Subject List</a>
    </div>
  </div>
</main>

<!-- Footer -->
<footer>
  &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

</body>
</html>
