<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Teacher Profile - Exam Center</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/teacherPageCss/teacherProfile.css"/>

</head>
<body>

<!-- Include Navbar -->
<jsp:include page="/WEB-INF/view/navbar/teacherNavbar.jsp"/>

<main>
  <!-- Profile Header -->
  <section class="profile-header" aria-label="Teacher Profile Information">
    <h1>${teacher.username}</h1>
    <p><i class="fas fa-envelope"></i> ${teacher.email}</p>
    <p><strong>Role:</strong> ${teacher.role}</p>
    <p><strong>Time Zone:</strong> ${teacher.zoneId}</p>
  </section>

  <!-- Subject Stats Section -->
  <section aria-label="Subject Statistics">
    <h2 class="section-title d-flex justify-content-center">Your Subject Statistics</h2>

    <div class="stats-wrapper">
      <c:choose>
        <c:when test="${not empty subjectsStats}">
          <c:forEach var="stat" items="${subjectsStats}">
            <div class="stats-card" role="region" aria-labelledby="subject-${stat.id}-title">
              <h3 id="subject-${stat.id}-title">${stat.name}</h3>
              <div class="stat-item"><i class="fas fa-layer-group"></i><strong> Total Questions:</strong> ${stat.questionCount}</div>
              <div class="stat-item"><i class="fas fa-plus-circle"></i><strong> Questions Added:</strong> ${stat.addedQuestions}</div>
              <div class="stat-item"><i class="fas fa-calendar-check"></i><strong> Exams Conducted:</strong> ${stat.examCount}</div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <p class="text-center text-muted fs-5">
            You currently have no assigned subjects or stats available.
          </p>
        </c:otherwise>
      </c:choose>
    </div>
  </section>
</main>

<footer>
  &copy; 2025 Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
