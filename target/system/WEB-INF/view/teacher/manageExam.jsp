<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Manage Exams - Faculty ${facultyName}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/teacherPageCss/manageExam.css"/>


</head>
<body>

<jsp:include page="/WEB-INF/view/navbar/teacherNavbar.jsp" />

<main>
  <div class="header-container">
    <h2>Create Your Exams</h2>
    <a href="teacherDashboard" class="btn-back" title="Back to Dashboard">
      <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
  </div>

  <c:choose>
    <c:when test="${not empty exams}">
      <div class="exam-grid">
        <c:forEach var="exam" items="${exams}">
          <div class="exam-card">
            <div class="exam-title"> Subject Name: ${exam.subjectName}</div>
            <div class="exam-detail"><i class="fa-solid fa-book"></i> Exam ID: ${exam.id}</div>
            <div class="exam-detail"><i class="fa-solid fa-align-left"></i> Description: ${exam.description}</div>
            <div class="exam-detail"><i class="fa-solid fa-check-double"></i> Total Marks: ${exam.totalMarks}</div>
            <div class="exam-detail"><i class="fa-solid fa-list-ol"></i> Number of Questions: ${exam.totalNumberOfQuestion}</div>
            <div class="exam-detail"><i class="fa-regular fa-calendar"></i> Date Created: ${exam.formattedDate}</div>

            <div class="button-group">
              <a href="viewExamDetails?examId=${exam.id}" class="btn btn-sm btn-outline-info">
                <i class="fas fa-eye"></i> View Exam
              </a>
            </div>
          </div>
        </c:forEach>
      </div>

      <a href="addExamPage?facultyId=${teacher.id}" class="add-exam-btn" title="Add New Exam">+</a>
    </c:when>

    <c:otherwise>
      <div style="text-align: center;">
        <a href="addExamPage?facultyId=${teacher.id}" class="add-exam-btn" title="Add New Exam">+</a>
        <p class="no-exams">📘 No exams created yet for this faculty.</p>
      </div>
    </c:otherwise>
  </c:choose>
</main>

<footer>
  &copy; 2025 Teacher Panel | Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
