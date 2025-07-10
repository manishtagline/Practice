<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>My Subjects - Teacher Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

  <style>
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
      padding: 2rem 1.5rem;
      max-width: 1000px;
      margin: auto;
    }

    .header-container {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 2rem;
      border-bottom: 2px solid rgba(0,201,255,0.25);
      padding-bottom: 0.5rem;
      position: relative;
    }

    .header-container h2 {
      font-weight: 600;
      font-size: 2.2rem;
      color: #66aaff;
      margin: 0;
      text-align: center;
      flex: 1;
    }

    a.btn-back {
      color: #66aaff;
      font-weight: 600;
      padding: 0.4rem 1rem;
      border-radius: 0.5rem;
      text-decoration: none;
      white-space: nowrap;
      font-size: 0.9rem;
      display: flex;
      align-items: center;
      gap: 0.4rem;
      transition: color 0.3s ease;
    }
    a.btn-back:hover {
      color: #a3cfff;
      text-decoration: none;
    }
    a.btn-back i {
      font-size: 1.1rem;
    }

    .subject-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
      gap: 2rem;
    }

    .subject-card {
      background: rgba(255, 255, 255, 0.08);
      backdrop-filter: blur(10px);
      border-radius: 1.5rem;
      padding: 2rem 2.5rem;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      min-height: 230px;
      color: #e0e6f1;
      font-weight: 500;
      transition: background-color 0.3s ease;
    }

    .subject-card:hover {
      background: rgba(255, 255, 255, 0.14);
    }

    .subject-title {
      font-size: 1.8rem;
      font-weight: 700;
      color: #66aaff;
      margin-bottom: 1.5rem;
      text-align: center;
    }

    .subject-detail {
      font-size: 1.1rem;
      color: #cfd6e8;
      margin-bottom: 2rem;
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 0.8rem;
    }

    .subject-detail i {
      font-size: 1.5rem;
      color: #66aaff;
    }

    .card-buttons {
      display: flex;
      gap: 1rem;
    }

    .btn-view-questions, .btn-add-question {
      flex: 1;
      font-weight: 600;
      font-size: 1.1rem;
      padding: 0.75rem 1rem;
      border-radius: 30px;
      box-shadow: 0 6px 20px rgba(102, 170, 255, 0.3);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.6rem;
      user-select: none;
      transition: background-color 0.3s ease, box-shadow 0.3s ease;
      text-decoration: none;
      color: #fff;
    }

    .btn-view-questions {
      background-color: #66aaff;
    }
    .btn-view-questions:hover, .btn-view-questions:focus {
      background-color: #3399ff;
      box-shadow: 0 8px 24px rgba(51, 153, 255, 0.6);
      outline: none;
    }

    .btn-add-question {
      background-color: #28a745;
      box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3);
    }
    .btn-add-question:hover, .btn-add-question:focus {
      background-color: #1e7e34;
      box-shadow: 0 8px 24px rgba(30, 126, 52, 0.6);
      outline: none;
    }

    .btn-view-questions i, .btn-add-question i {
      font-size: 1.3rem;
    }

    .no-subjects {
      text-align: center;
      font-size: 1.3rem;
      margin-top: 3.5rem;
      color: #ddd;
      font-style: italic;
      user-select: none;
    }

    footer {
      background-color: #1a1a2e;
      color: #aaa;
      text-align: center;
      padding: 1rem;
      font-size: 0.9rem;
      user-select: none;
    }
  </style>
</head>
<body>

<jsp:include page="/WEB-INF/view/navbar/teacherNavbar.jsp"/>

<main>
  <div class="header-container">
    <div style="width: 140px;"></div> <!-- left spacer -->
    <h2>My Assigned Subjects</h2>
    <a href="teacherDashboard" class="btn-back" title="Back to Dashboard">
      <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
  </div>

  <c:choose>
    <c:when test="${not empty subjects}">
      <div class="subject-grid">
        <c:forEach var="subject" items="${subjects}">
          <div class="subject-card">
            <div class="subject-title">${subject.name}</div>
            <div class="subject-detail">
              <i class="bi bi-book"></i> Total Questions: ${subject.questionCount}
            </div>

            <div class="card-buttons">
              <a href="${pageContext.request.contextPath}/teacher/viewQuestions?subjectId=${subject.id}"
                 class="btn-view-questions" title="View Questions for ${subject.name}">
                <i class="bi bi-eye"></i> View Questions
              </a>

              <a href="${pageContext.request.contextPath}/teacher/addQuestionPage?subjectId=${subject.id}"
                 class="btn-add-question" title="Add Question for ${subject.name}">
                <i class="bi bi-plus-circle"></i> Add Question
              </a>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:when>
    <c:otherwise>
      <p class="no-subjects">📚 You don't have any assigned subjects at the moment.</p>
    </c:otherwise>
  </c:choose>
</main>

<footer>
  &copy; 2025 Teacher Panel | Exam Center. All rights reserved.
</footer>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
