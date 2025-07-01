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

  <style>
    html, body {
      height: 100%;
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #1f1c2c, #928dab);
      display: flex;
      flex-direction: column;
      position: relative;
    }
    main {
      flex: 1;
      padding: 2rem;
      z-index: 2;
    }
    .header-row {
      position: relative;
      margin-bottom: 2rem;
      height: 48px;
    }
    .header-row h2 {
      font-weight: 700;
      color: #fff;
      margin: 0;
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
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
      border: none;
      cursor: pointer;
      text-decoration: none;
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
    table.table {
      width: 100%;
      border-radius: 16px;
      overflow: hidden;
      background: #5a5a5a;
      color: #f0f0f0;
      box-shadow: 0 10px 30px rgba(0,0,0,0.4);
      border-collapse: separate;
      border-spacing: 0;
    }
    thead th {
      background: #3c3c3c;
      color: #e0e0e0;
      text-transform: uppercase;
      font-size: .9rem;
      padding: 1rem;
      border-bottom: 2px solid #777;
    }
    tbody tr {
      background: #6e6e6e;
      transition: .3s;
    }
    tbody tr:hover {
      background: #8f8f8f;
      transform: scale(1.005);
      box-shadow: 0 4px 10px rgba(0,0,0,0.3);
    }
    tbody td {
      padding: 1rem;
      vertical-align: middle;
    }
    .btn-action {
      background: #8e2de2;
      color: white;
      font-size: .85rem;
      padding: .4rem .8rem;
      border: none;
      border-radius: 4px;
      transition: background .3s;
      text-decoration: none;
    }
    .btn-action:hover {
      background: #6a11cb;
    }
    footer {
      background: #1a1a2e;
      color: #ccc;
      text-align: center;
      padding: 1rem;
      font-size: .9rem;
    }
    @media (max-width: 768px) {
      thead th, tbody td {
        padding: .75rem .5rem;
        font-size: .9rem;
      }
      .add-subject-btn {
        width: 100%;
        justify-content: center;
      }
    }
  </style>
</head>
<body>

<!-- Include navbar -->
<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp" />

<!-- Main Content -->
<main>
  <div class="header-row">
    <h2>Manage Exams</h2>
    <div class="back-btn-container">
      <a href="adminPage" class="add-subject-btn">
        &#8592; Back to Dashboard
      </a>
    </div>
  </div>

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
          <a href="viewExamDetails?id=${exam.id}" class="btn-action">View</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <!-- Add Exam Button -->
  <div class="text-center">
    <a href="addExamPage" class="add-subject-btn mt-4">
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <line x1="12" y1="5" x2="12" y2="19"/>
        <line x1="5" y1="12" x2="19" y2="12"/>
      </svg>
      Add Exam
    </a>
  </div>
</main>

<!-- Footer -->
<footer>&copy; 2025 Admin Panel | Exam Center. All rights reserved.</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
