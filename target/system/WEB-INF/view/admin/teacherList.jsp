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

  <style>
    html, body {
      height: 100%;
      margin: 0;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #1f1c2c, #928dab);
      display: flex;
      flex-direction: column;
      position: relative;
      color: #fff;
      min-height: 100vh;
    }

    main {
      flex: 1;
      z-index: 2;
      padding: 2rem;
      max-width: 1200px;
      margin: 0 auto;
      width: 100%;
    }

    .header-row {
      position: relative;
      height: 48px;
      margin-bottom: 2rem;
    }

    .header-row h2 {
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
      font-weight: 700;
      font-size: 1.5rem;
      color: #fff;
      line-height: 48px;
      margin: 0;
      user-select: none;
    }

    .back-btn-container {
      position: absolute;
      right: 0;
      top: 0;
      height: 100%;
      display: flex;
      align-items: center;
    }

    .add-subject-btn {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      background-color: #00c9ff;
      color: white;
      font-weight: 600;
      padding: 12px 24px;
      border-radius: 30px;
      font-size: 1rem;
      box-shadow: 0 4px 12px rgba(0,201,255,0.4);
      transition: all 0.3s ease;
      text-decoration: none;
    }

    .add-subject-btn:hover {
      background-color: #0096c7;
      box-shadow: 0 6px 18px rgba(0,201,255,0.55);
    }

    .faculty-grid {
      row-gap: 2rem;
    }

    .card {
      background: rgba(255, 255, 255, 0.05);
      backdrop-filter: blur(6px);
      border-radius: 16px;
      border: 1px solid rgba(255, 255, 255, 0.08);
      box-shadow: 0 10px 30px rgba(0,0,0,0.5);
      transition: 0.3s ease;
      color: #fff;
    }

    .card:hover {
      transform: translateY(-6px);
      box-shadow: 0 12px 36px rgba(0,0,0,0.6);
    }

    .card-body {
      padding: 1.5rem;
      text-align: center;
    }

    .avatar-circle {
      width: 80px;
      height: 80px;
      background-color: #00c9ff;
      border-radius: 50%;
      color: #1f1c2c;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2rem;
      font-weight: 700;
      margin: 0 auto 1rem;
      box-shadow: 0 4px 10px rgba(0,201,255,0.4);
    }

    .card-title {
      font-size: 1.2rem;
      font-weight: 700;
      margin-bottom: 1rem;
    }

    .card-info {
      font-size: 0.95rem;
      text-align: left;
    }

    .card-info p {
      margin-bottom: 0.4rem;
      line-height: 1.5;
    }

    .card-info strong {
      color: #00cec9;
      font-weight: 600;
    }

    .text-warning-visible {
      color: #ffc107;
      font-weight: 600;
    }

    .card-footer {
      background: transparent;
      border: none;
      padding: 1rem 1.5rem;
      display: flex;
      justify-content: space-between;
    }

    .btn-sm {
      padding: 6px 12px;
      font-size: 0.85rem;
    }

    .btn-outline-primary {
      border-color: #00cec9;
      color: #00cec9;
    }

    .btn-outline-primary:hover {
      background-color: #00cec9;
      color: #2d3436;
    }

    .btn-outline-success {
      border-color: #2ed573;
      color: #2ed573;
    }

    .btn-outline-success:hover {
      background-color: #2ed573;
      color: #2d3436;
    }

    footer {
      background-color: #1a1a2e;
      color: #ccc;
      text-align: center;
      padding: 1rem;
      font-size: 0.9rem;
    }
  </style>
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
            <a href="assignSubject?facultyId=${teacher.id}" class="btn btn-sm btn-outline-primary">Assign Subject</a>
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
