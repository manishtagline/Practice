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

  <style>
    html, body {
      height: 100%;
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #1f1c2c, #928dab);
      color: #f0f0f0;
      display: flex;
      flex-direction: column;
    }

    main {
      flex: 1;
      padding: 2rem 3rem;
      max-width: 1800px;
      width: 100%;
      margin: 0 auto;
      display: flex;
      flex-direction: column;
    }

    .header-container {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 1.5rem;
    }

    .header-container h2 {
      flex: 1;
      text-align: center;
      color: #00c9ff;
      font-weight: 700;
      margin: 0;
    }

    .btn-back {
      color: #ccc;
      font-weight: 600;
      padding: 0.5rem 1rem;
      border: 2px solid transparent;
      border-radius: 0.5rem;
      text-decoration: none;
      transition: color 0.3s ease, border-color 0.3s ease;
      white-space: nowrap;
      font-size: 0.9rem;
      display: flex;
      align-items: center;
      gap: 0.4rem;
      user-select: none;
    }

    .btn-back:hover {
      color: #00c9ff;
      border-color: #00c9ff;
    }

    .section-divider {
      height: 2px;
      background-color: #00c9ff;
      opacity: 0.4;
      margin: 1.5rem 0;
      width: 100%;
    }

    .table-responsive {
      flex: 1;
      overflow-x: auto;
      border-radius: 10px;
      margin-bottom: 2rem;
    }

    table.table-dark {
      width: 100%;
      min-width: 1300px;
      border-collapse: collapse;
      border: 1px solid #50506e;
      background-color: #2a2c3e;
      color: #f0f0f0;
      table-layout: fixed;
    }

    table.table-dark thead th {
      background-color: #00c9ff;
      color: #0a0a0a;
      text-transform: uppercase;
      font-weight: 700;
      padding: 1rem;
      border-bottom: 2px solid #50506e;
    }

    table.table-dark tbody tr:hover {
      background-color: #4b4b66;
    }

    table.table-dark td {
      padding: 1rem;
      border-bottom: 1px solid #50506e;
      word-wrap: break-word;
    }

    .btn-action {
      background-color: #0a84ff;
      color: #fff;
      border-radius: 20px;
      padding: 0.3rem 0.9rem;
      border: none;
      margin: 0 4px;
      font-size: 0.85rem;
      cursor: pointer;
      text-decoration: none;
    }

    .btn-action:hover {
      background-color: #006edc;
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
      border: none;
      text-decoration: none;
      margin-top: 1rem;
    }

    .add-subject-btn:hover {
      background-color: #0096c7;
      box-shadow: 0 6px 18px rgba(0,201,255,0.55);
    }

    .add-subject-btn svg {
      margin-right: 8px;
      width: 20px;
      height: 20px;
      stroke: white;
    }

    .no-exams-message {
      text-align: center;
      font-size: 1.2rem;
      color: #ccc;
      margin-top: 2rem;
      font-weight: 500;
    }

    footer {
      background-color: #1a1a2e;
      color: #ccc;
      text-align: center;
      padding: 1rem;
      font-size: 0.9rem;
    }

    @media (max-width: 768px) {
      main {
        padding: 1rem;
      }

      .table-dark th,
      .table-dark td {
        padding: 0.75rem 0.5rem;
        font-size: 0.9rem;
      }

      .add-subject-btn {
        width: 100%;
        justify-content: center;
      }
    }
  </style>
</head>
<body>

<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp" />

<main>
  <div class="header-container">
    <h2>Manage Exams</h2>
    <a href="${pageContext.request.contextPath}/admin/teacherList" class="btn-back">
      &#8592; Back to Dashboard
    </a>
  </div>

  <div class="section-divider"></div>

  <c:choose>
    <c:when test="${not empty exams}">
      <div class="table-responsive">
        <table class="table table-hover table-dark text-center align-middle">
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
                <a href="${pageContext.request.contextPath}/admin/viewExamDetails?id=${exam.id}&source=teacherExamList&facultyId=${facultyId}"
                   class="btn btn-sm btn-action">View</a>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </c:when>
    <c:otherwise>
      <p class="no-exams-message">No exams available. Teacher hasn’t created any exam yet.</p>
    </c:otherwise>
  </c:choose>

</main>

<footer>
  &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
