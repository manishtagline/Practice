<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Manage Exams - Faculty ${facultyName}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

  <!-- Font Awesome for Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />

  <style>
    /* Global */
    html, body {
      height: 100%;
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #1f1c2c, #928dab);
      color: #f0f0f0;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    main {
      flex: 1;
      max-width: 1000px;
      margin: 2rem auto 4rem;
      padding: 0 1rem;
      width: 100%;
      position: relative;
      z-index: 2;
    }

    /* Header: center title with back button on right */
    .header-container {
      display: flex;
      justify-content: center; /* center horizontally */
      align-items: center;
      margin-bottom: 2rem;
      border-bottom: 2px solid rgba(0,201,255,0.25);
      padding-bottom: 0.5rem;
      position: relative; /* for positioning back button */
    }

    .header-container h2 {
      font-weight: 600;
      font-size: 2.25rem;
      color: #00c9ff;
      margin: 0;
      flex-grow: 1;
      text-align: center;
    }
    .header-container h2 strong {
      font-weight: 700;
    }

    /* Back button on right, vertically centered */
    a.btn-back {
      position: absolute;
      right: 1rem;
      top: 50%;
      transform: translateY(-50%);
      color: #ccc;
      font-weight: 600;
      padding: 0.4rem 1rem;
      border: 2px solid transparent;
      border-radius: 0.5rem;
      text-decoration: none;
      transition: color 0.3s ease, border-color 0.3s ease;
      white-space: nowrap;
      font-size: 0.9rem;
      display: flex;
      align-items: center;
      gap: 0.4rem;
    }
    a.btn-back:hover {
      color: #00c9ff;
      border-color: #00c9ff;
      text-decoration: none;
    }
    a.btn-back i {
      font-size: 1.1rem;
    }

    /* Exam List Grid */
    .exam-list {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 1.5rem;
    }

    /* Exam Card */
    .exam-card {
      background: rgba(60, 60, 60, 0.9);
      border-radius: 12px;
      padding: 1.5rem 1.8rem;
      box-shadow: 0 8px 20px rgba(0,0,0,0.5);
      transition: transform 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      min-height: 200px;
    }
    .exam-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(0,0,0,0.8);
      background-color: rgba(80, 80, 80, 0.95);
    }

    .exam-card h4 {
      color: #00c9ff;
      margin-bottom: 0.8rem;
      font-weight: 700;
      font-size: 1.3rem;
    }

    /* Info with icons */
    .exam-info {
      color: #ccc;
      font-size: 0.95rem;
      margin-bottom: 0.7rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }
    .exam-info i {
      color: #00c9ff;
      min-width: 18px;
      text-align: center;
    }

    /* Button group */
    .btn-group {
      margin-top: auto;
      display: flex;
      gap: 0.6rem;
      flex-wrap: wrap;
    }
    .btn-group a {
      flex: 1;
      min-width: 80px;
      font-size: 0.85rem;
      padding: 0.45rem 0.8rem;
      border-radius: 0.5rem;
      text-align: center;
      font-weight: 600;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.4rem;
      box-shadow: 0 2px 8px rgba(0,0,0,0.2);
      transition: background-color 0.3s ease;
      color: #1f1c2c;
    }
    .btn-primary {
      background-color: #00c9ff;
    }
    .btn-primary:hover {
      background-color: #009ccf;
      color: #fff;
    }
    .btn-warning {
      background-color: #ffa500;
    }
    .btn-warning:hover {
      background-color: #cc8400;
      color: #fff;
    }
    .btn-danger {
      background-color: #ff4d4d;
      color: #fff !important;
    }
    .btn-danger:hover {
      background-color: #e60000;
      color: #fff !important;
    }
    .btn-group a i {
      font-size: 1rem;
    }

    /* Empty state */
    p.no-exams {
      text-align: center;
      font-size: 1.2rem;
      color: #aaa;
      margin-top: 0;
      font-style: italic;
    }

    /* Floating Add Exam Button: fixed at bottom center */
    .add-exam-btn {
      position: fixed;
      bottom: 40px;
      left: 50%;
      transform: translateX(-50%);
      background-color: #00c9ff;
      color: #1f1c2c;
      font-size: 2.5rem;
      font-weight: 700;
      width: 60px;
      height: 60px;
      border-radius: 50%;
      border: none;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 8px 20px rgba(0,201,255,0.6);
      transition: background-color 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      z-index: 10;
      text-decoration: none;
      user-select: none;
    }
    .add-exam-btn:hover {
      background-color: #009ccf;
      color: #f0f0f0;
      box-shadow: 0 12px 30px rgba(0,156,207,0.8);
      text-decoration: none;
    }

    /* Centered add button style variant for no exams (inside main) */
    .add-exam-btn.inline {
      position: static !important;
      display: inline-flex !important;
      margin-bottom: 1.5rem !important;
      transform: none !important;
      font-size: 3rem !important;
      width: 70px !important;
      height: 70px !important;
      box-shadow: 0 8px 15px rgba(0,201,255,0.5) !important;
    }

    /* Footer */
    footer {
      background-color: #1a1a2e;
      color: #aaa;
      text-align: center;
      padding: 1rem 0;
      font-size: 0.9rem;
      user-select: none;
    }
  </style>
</head>
<body>

<!-- Navbar Include -->
<jsp:include page="/WEB-INF/view/navbar/teacherNavbar.jsp" />

<main>
  <!-- Header -->
  <div class="header-container">
    <h2>Exams for <strong>${facultyName}</strong></h2>
    <a href="teacherDashboard" class="btn-back" title="Back to Dashboard">
      <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
  </div>

  <!-- Exam Cards or Empty State -->
  <c:choose>
    <c:when test="${not empty exams}">
      <div class="exam-list">
        <c:forEach var="exam" items="${exams}">
          <div class="exam-card">
            <h4>${exam.title}</h4>
            <p class="exam-info"><i class="fa-regular fa-calendar"></i> <strong>Date:</strong> ${exam.date}</p>
            <p class="exam-info"><i class="fa-regular fa-clock"></i> <strong>Duration:</strong> ${exam.duration} minutes</p>
            <div class="btn-group">
              <a href="viewExamDetails?examId=${exam.id}" class="btn btn-primary btn-sm" title="View Exam">
                <i class="fas fa-eye"></i> View
              </a>
              <a href="editExam?examId=${exam.id}" class="btn btn-warning btn-sm" title="Edit Exam">
                <i class="fas fa-pen"></i> Edit
              </a>
              <a href="deleteExam?examId=${exam.id}" class="btn btn-danger btn-sm"
                 onclick="return confirm('Are you sure you want to delete this exam?');" title="Delete Exam">
                <i class="fas fa-trash"></i> Delete
              </a>
            </div>
          </div>
        </c:forEach>
      </div>

      <!-- Floating add exam button fixed bottom center -->
      <a href="addExamPage?facultyId=${facultyId}" class="add-exam-btn" title="Add New Exam">+</a>

    </c:when>

    <c:otherwise>
      <div style="text-align: center; margin-top: 3rem;">
        <!-- Add Exam button centered above message -->
        <a href="addExamPage?facultyId=${facultyId}" class="add-exam-btn inline" title="Add New Exam">+</a>
        <p class="no-exams">No exams created yet.</p>
      </div>
    </c:otherwise>
  </c:choose>

</main>

<footer>
  &copy; 2025 Teacher Panel | Exam Center. All rights reserved.
</footer>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
