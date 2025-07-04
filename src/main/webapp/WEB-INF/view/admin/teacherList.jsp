<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Faculty List - Admin Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Fonts + Navbar -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminNavbar.css" />

  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/teacherList.css"/>
</head>

<body>

<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp"/>

<main>
  <div class="header-row">
    <h2>👨‍🏫 Faculty Members</h2>
    <div class="back-btn-container">
      <a href="adminPage" class="add-subject-btn">&#8592; Back to Dashboard</a>
    </div>
  </div>

  <div class="row faculty-grid">
    <c:forEach var="teacher" items="${teachers}">
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100">
          <div class="card-body">
            <div class="avatar-circle">
              <c:out value="${fn:toUpperCase(fn:substring(teacher.username, 0, 1))}" />
            </div>
            <h3 class="card-title">${teacher.username}</h3>
            <div class="card-info">
              <p><strong>ID:</strong> ${teacher.id}</p>
              <p><strong>Email:</strong> ${teacher.email}</p>
              <p><strong>Role:</strong> ${teacher.role}</p>
              <p><strong>Subject:</strong>
                <c:choose>
                  <c:when test="${not empty teacher.subjectName}">
                    ${teacher.subjectName}
                  </c:when>
                  <c:otherwise>
                    <span class="text-warning-visible">Not Assigned</span>
                  </c:otherwise>
                </c:choose>
              </p>
            </div>
          </div>
          <div class="card-footer">
            <a href="assignSubjectPage?facultyId=${teacher.id}" class="btn btn-sm btn-outline-primary">Assign Subject</a>
            <a href="viewExam?facultyId=${teacher.id}" class="btn btn-sm btn-outline-success">View Exams</a>
          </div>
        </div>
      </div>
    </c:forEach>

    <c:if test="${empty teachers}">
      <div class="col-12 text-center">
        <p class="fs-5 text-light">No faculty members available.</p>
      </div>
    </c:if>
  </div>
</main>

<footer>
  &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

</body>
</html>
