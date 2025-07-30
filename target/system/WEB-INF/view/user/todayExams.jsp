<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Today's Exams - Exam Center</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userPageCss/todayExams.css"/>


</head>

<body>

<!-- Navbar include -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp"/>

<main>

  <!-- Page Header with Back Button -->
  <div class="page-header">
    <h2>📌 Exams Scheduled for Today</h2>
    <a href="${pageContext.request.contextPath}/home" class="back-btn">← Back to Dashboard</a>
  </div>

  <!-- Decorative Divider -->
  <div class="section-divider"></div>

  <!-- Exams Content -->
  <c:choose>
    <c:when test="${not empty todayExams}">
      <div class="exam-card-container">
        <c:forEach var="exam" items="${todayExams}">
          <div class="exam-card">
            <div>
              <div class="exam-title">${exam.description}</div>
              <div class="exam-details">
                Subject: ${exam.subject.name}<br/>
                Total Marks: ${exam.totalMarks}<br/>
                Questions: ${exam.totalNumberOfQuestion}
              </div>
            </div>
            <form method="get" action="questionPaper">
              <input type="hidden" name="examId" value="${exam.id}" />
              <button type="submit" class="btn btn-primary w-100 start-btn">Start Exam</button>
            </form>
          </div>
        </c:forEach>
      </div>
    </c:when>
    <c:otherwise>
      <div class="alert alert-info">No exams scheduled for today.</div>
    </c:otherwise>
  </c:choose>

</main>

<footer>
  &copy; 2025 Exam Center. All rights reserved.
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
