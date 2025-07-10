<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Exam List - Admin Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

  <!-- Link to your navbar CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminNavbar.css" />

  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/examList.css"/>

  <style>
    /* Make table container scrollable horizontally and vertically */
    .table-responsive {
      overflow-x: auto;
      max-height: 400px;  /* Adjust as needed */
      overflow-y: auto;
      -webkit-overflow-scrolling: touch; /* smooth scrolling on iOS */
    }
  </style>

</head>
<body>

<!-- Include navbar -->
<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp" />

<!-- Main Content -->
<main>
  <div class="header-row d-flex justify-content-between align-items-center mb-3">
    <h2>Manage Exams</h2>
    <div class="back-btn-container">
      <a href="adminPage" class="back-btn">
        &#8592; Back to Dashboard
      </a>
    </div>
  </div>

  <div class="table-responsive">
    <table class="table table-hover text-center align-middle">
      <thead>
      <tr>
        <th>ID</th>
        <th>Subject</th>
        <th>Description</th>
        <th>Total Marks</th>
        <th>Number Of Questions</th>
        <th>Date Created</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="exam" items="${exams}">
        <tr>
          <td>${exam.id}</td>
          <td>${exam.subjectName}</td>
          <td>${exam.description}</td>
          <td>${exam.totalMarks}</td>
          <td>${exam.totalNumberOfQuestion}</td>
          <td>${exam.formattedDate}</td>
          <td>
            <a href="${pageContext.request.contextPath}/admin/viewExamDetails?id=${exam.id}" class="btn btn-sm btn-primary">
              View
            </a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

  <!-- Add Exam Button -->
  <div class="text-center mt-4">
    <a href="${pageContext.request.contextPath}/admin/addExamPage" class="btn btn-success">
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" width="16" height="16" viewBox="0 0 24 24" style="vertical-align:middle; margin-right:4px;">
        <line x1="12" y1="5" x2="12" y2="19" stroke-width="2" stroke-linecap="round"/>
        <line x1="5" y1="12" x2="19" y2="12" stroke-width="2" stroke-linecap="round"/>
      </svg>
      Add Exam
    </a>
  </div>
</main>

<!-- Footer -->
<footer class="text-center mt-5 mb-3 text-muted">&copy; 2025 Admin Panel | Exam Center. All rights reserved.</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
