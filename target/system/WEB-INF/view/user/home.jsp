<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Student Dashboard - Exam Center</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userPageCss/home.css"/>

</head>
<body>

<!-- Navbar -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp"/>

<main>

  <h1>Student Dashboard</h1>

  <div class="welcome-user" aria-live="polite" aria-atomic="true">
    👋 Welcome <strong>${username}</strong>, ready for your next exam?
  </div>

  <div class="card-container">

    <!-- Enrollment Exam -->
    <div class="card" onclick="location.href='enrollExam'" role="button" tabindex="0"
         aria-label="Enroll in Exam" onkeypress="if(event.key==='Enter'){location.href='enrollExam'}">
      <svg class="card-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
           stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
        <!-- Clipboard shape -->
        <rect x="8" y="2" width="8" height="4" rx="1" ry="1"/>
        <path d="M6 6h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2z"/>
        <!-- Check mark -->
        <polyline points="9 12 11 14 15 10" />
      </svg>
      <h5 class="card-title">Enroll Exam</h5>
      <p class="card-text">Register for upcoming exams easily.</p>
    </div>

    <!-- Start Exam -->
    <div class="card" onclick="location.href='exam'" role="button" tabindex="0"
         aria-label="Start Exam" onkeypress="if(event.key==='Enter'){location.href='exam'}">
      <svg class="card-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
           stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
        <circle cx="12" cy="12" r="10"/>
        <polygon points="10 8 16 12 10 16 10 8"/>
      </svg>
      <h5 class="card-title">Start Exam</h5>
      <p class="card-text">Begin your scheduled exams with a click.</p>
    </div>

    <!-- View Results -->
    <div class="card" onclick="location.href='result'" role="button" tabindex="0"
         aria-label="View Results" onkeypress="if(event.key==='Enter'){location.href='${pageContext.request.contextPath}/exam/results'}">
      <svg class="card-icon" viewBox="0 0 24 24" fill="none" stroke="#00c9ff"
           stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" role="img" focusable="false">
        <path d="M12 2l7 4v6c0 5-3 9-7 10-4-1-7-5-7-10V6l7-4z"/>
        <polyline points="9 12 11 14 15 10" />
      </svg>
      <h5 class="card-title">View Results</h5>
      <p class="card-text">Check your exam scores and history.</p>
    </div>

    <!-- Profile -->
    <div class="card" onclick="location.href='profile'" role="button" tabindex="0"
         aria-label="View Profile" onkeypress="if(event.key==='Enter'){location.href='${pageContext.request.contextPath}/user/profile'}">
      <svg class="card-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
           stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
        <circle cx="12" cy="7" r="4"/>
        <path d="M5.5 21h13a2 2 0 0 0-13 0z"/>
      </svg>
      <h5 class="card-title">My Profile</h5>
      <p class="card-text">View and update your profile information.</p>
    </div>

    <!-- Upcoming Exams -->
    <div class="card" onclick="location.href='calendar'" role="button" tabindex="0"
         aria-label="View Upcoming Exams" onkeypress="if(event.key==='Enter'){location.href='calendar'}">
      <svg class="card-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
           stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
        <line x1="16" y1="2" x2="16" y2="6"/>
        <line x1="8" y1="2" x2="8" y2="6"/>
        <line x1="3" y1="10" x2="21" y2="10"/>
      </svg>
      <h5 class="card-title">Upcoming Exams</h5>
      <p class="card-text">Check your scheduled exams in calendar view.</p>
    </div>

  </div>
</main>

<footer>
  &copy; 2025 Exam Center. All rights reserved.
</footer>

<!-- Logout Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content custom-modal">
      <div class="modal-header custom-header">
        <h5 class="modal-title" id="logoutModalLabel">Confirm Logout</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to logout?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
          <button type="submit" class="btn btn-danger">Logout</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function showLogoutModal() {
    const logoutModal = new bootstrap.Modal(document.getElementById('logoutModal'));
    logoutModal.show();
  }
</script>

</body>
</html>
