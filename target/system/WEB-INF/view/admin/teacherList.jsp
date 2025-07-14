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

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

  <!-- Custom CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminNavbar.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/teacherList.css"/>

  <style>
    .custom-toast-wrapper {
      position: relative;
      margin-top: 1rem;
      right: auto;
      top: auto;
      display: flex;
      justify-content: flex-end;
      width: 100%;
      z-index: 9999;
    }

    .custom-toast {
      background: linear-gradient(135deg, #00c9ff, #005f99);
      color: white;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0,201,255,0.6);
      font-weight: 600;
      font-size: 1rem;
      padding: 1rem 1.5rem;
      opacity: 0;
      transform: translateY(-20px);
      animation-fill-mode: forwards;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    .custom-toast.show {
      animation: fadeInDown 0.5s forwards;
    }

    .custom-toast.fade-out {
      animation: fadeOutUp 0.5s forwards;
    }

    .custom-toast .btn-close {
      filter: brightness(0.8);
      transition: filter 0.3s ease;
    }

    .custom-toast .btn-close:hover {
      filter: brightness(1.2);
    }

    @keyframes fadeInDown {
      from {
        opacity: 0;
        transform: translateY(-20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes fadeOutUp {
      from {
        opacity: 1;
        transform: translateY(0);
      }
      to {
        opacity: 0;
        transform: translateY(-20px);
      }
    }
  </style>
</head>

<body>

<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp"/>

<main style="position: relative;">

  <div class="header-row">
    <h2>👨‍🏫 Faculty Members</h2>
    <div class="back-btn-container">
      <a href="adminPage" class="back-btn">&#8592; Back to Dashboard</a>
    </div>

    <!-- ✅ Toast now below the back button -->
    <c:if test="${not empty successMsg}">
      <div class="custom-toast-wrapper" id="toastWrapper">
        <div class="custom-toast show" role="alert" aria-live="assertive" aria-atomic="true" id="successToast">
          <div>${successMsg}</div>
          <button type="button" class="btn-close btn-close-white" aria-label="Close" id="toastCloseBtn"></button>
        </div>
      </div>
    </c:if>
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
            <div class="row g-2">
              <div class="col-6">
                <a href="${pageContext.request.contextPath}/admin/assignSubjectPage?facultyId=${teacher.id}" class="btn btn-sm btn-outline-primary w-100">Assign Subject</a>
              </div>
              <div class="col-6">
                <a href="${pageContext.request.contextPath}/admin/viewExamDetailsOfTeacher?facultyId=${teacher.id}" class="btn btn-sm btn-outline-success w-100">View Exams</a>
              </div>
              <div class="col-12 d-flex justify-content-center">
                <a href="${pageContext.request.contextPath}/admin/viewTeacherQuestions?facultyId=${teacher.id}" class="btn btn-sm btn-outline-info px-4">View Questions</a>
              </div>
            </div>
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

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const toast = document.getElementById('successToast');
    const closeBtn = document.getElementById('toastCloseBtn');

    if (toast) {
      setTimeout(() => {
        toast.classList.add('fade-out');
        setTimeout(() => {
          const wrapper = document.getElementById('toastWrapper');
          if (wrapper) wrapper.remove();
        }, 500);
      }, 3000);

      closeBtn.addEventListener('click', () => {
        toast.classList.add('fade-out');
        setTimeout(() => {
          const wrapper = document.getElementById('toastWrapper');
          if (wrapper) wrapper.remove();
        }, 500);
      });
    }
  });
</script>

</body>
</html>
