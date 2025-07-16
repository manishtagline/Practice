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
      padding: 0 3rem 2rem;
      width: 100%;
      box-sizing: border-box;
      position: relative;
    }

    .header-container {
      display: flex;
      align-items: center;
      justify-content: center; /* center content horizontally */
      position: relative; /* keep for positioning */
      padding: 1rem 0;
      margin-top: 0.5rem;
      border-bottom: 2px solid rgba(0,201,255,0.25);
      min-height: 70px;
      box-shadow: none;
      z-index: 10;
    }

    .header-container h2 {
      color: #00c9ff;
      font-weight: 600;
      font-size: 2rem;
      margin: 0;
      user-select: none;
      position: absolute;  /* position absolute to center it ignoring other items */
      left: 50%;
      transform: translateX(-50%);
    }


    a.btn-back {
      position: absolute;
      right: 0;
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
      z-index: 20;
    }

    a.btn-back:hover {
      color: #00c9ff;
      border-color: #00c9ff;
    }

    .exam-grid {
      margin-top: 2rem;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
      gap: 2rem;
    }

    /* Match subject card style */
    .exam-card {
      position: relative;
      background: #2f2f2f;
      padding: 2rem;
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
      border: 1px solid #00c9ff33;
      z-index: 1;
    }

    .exam-card::before {
      content: '';
      position: absolute;
      width: 200%;
      height: 200%;
      top: -50%;
      left: -50%;
      background-image:
              linear-gradient(135deg, rgba(0,201,255,0.07) 1px, transparent 1px),
              linear-gradient(45deg, rgba(0,201,255,0.07) 1px, transparent 1px);
      background-size: 60px 60px;
      z-index: 0;
      pointer-events: none;
      opacity: 0.4;
    }

    .exam-title,
    .exam-detail,
    .button-group {
      position: relative;
      z-index: 2;
    }

    .exam-title {
      font-size: 1.6rem;
      font-weight: 700;
      color: #00c9ff;
      margin-bottom: 1rem;
    }

    .exam-detail {
      font-size: 1rem;
      color: #ccc;
      margin-bottom: 1.2rem;
      display: flex;
      align-items: center;
      border-bottom: 1px solid rgba(0, 201, 255, 0.2);
      padding-bottom: 0.6rem;
    }

    .exam-detail i {
      color: #00c9ff;
      margin-right: 10px;
    }

    .button-group {
      margin-top: 1.2rem;
      display: flex;
      gap: 1rem;
      flex-wrap: wrap;
    }

    .button-group a.btn {
      font-size: 0.95rem;
      padding: 0.5rem 1.2rem;
      font-weight: 600;
    }

    .btn-outline-info {
      border: 1px solid #00c9ff;
      color: #00c9ff;
    }

    .btn-outline-info:hover {
      background-color: #00c9ff;
      color: #1f1c2c;
    }

    .no-exams {
      text-align: center;
      font-size: 1.2rem;
      margin-top: 3rem;
      color: #ddd;
      font-style: italic;
    }

    footer {
      background-color: #1a1a2e;
      color: #aaa;
      text-align: center;
      padding: 1rem;
      font-size: 0.9rem;
    }

    /* Add Exam floating button style, same as before */
    .add-exam-btn {
      position: fixed;
      bottom: 80px;
      left: 50%;
      transform: translateX(-50%);
      background-color: #00c9ff;
      color: #1f1c2c;
      font-size: 2rem;
      font-weight: 700;
      width: 60px;
      height: 60px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      text-decoration: none;
      box-shadow: 0 8px 20px rgba(0,201,255,0.6);
      z-index: 1000;
    }

    .add-exam-btn:hover {
      background-color: #009ccf;
      color: #fff;
    }
  </style>
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
