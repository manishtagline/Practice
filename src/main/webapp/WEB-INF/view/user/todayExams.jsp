<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8"/>
  <title>Today's Exams</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp"/>
<main class="container py-4">
  <h2>📌 Exams Scheduled for Today</h2>
  <c:choose>
    <c:when test="${!empty todayExams}">
      <ul class="list-group mt-3">
        <c:forEach var="exam" items="${todayExams}">
          <li class="list-group-item d-flex justify-content-between align-items-center">
            <div>
              <strong>${exam.description}</strong><br/>
              <span class="text-muted">
                  Start: <fmt:formatDate value="${exam.examStartDate}" pattern="HH:mm"/> –
                  End: <fmt:formatDate value="${exam.examEndDate}" pattern="HH:mm"/>
                </span>
            </div>
            <form method="get" action="questionPaper">
              <input type="hidden" name="examId" value="${exam.id}" />
              <button type="submit" class="btn btn-primary">Start Exam</button>
            </form>
          </li>
        </c:forEach>
      </ul>
    </c:when>
    <c:otherwise>
      <div class="alert alert-info mt-3">No exams scheduled for today.</div>
    </c:otherwise>
  </c:choose>
</main>
</body>
</html>
