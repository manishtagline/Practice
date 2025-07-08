<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Assign Subject - ${teacher.username}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>

  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Fonts & Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>

  <!-- Navbar -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminNavbar.css"/>

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      margin: 0;
      padding: 0;
      background: linear-gradient(to right, #1f1c2c, #928dab);
      color: #f2f2f2;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    main {
      flex: 1;
      padding: 3rem 1rem;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .assign-container {
      background: rgba(255, 255, 255, 0.08);
      backdrop-filter: blur(10px);
      border-radius: 1.5rem;
      padding: 2.5rem;
      width: 100%;
      max-width: 600px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
      animation: fadeInUp 0.6s ease-out;
    }

    @keyframes fadeInUp {
      from { transform: translateY(20px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    .btn-back {
      position: absolute;
      top: 1.5rem;
      right: 2rem;
      text-decoration: none;
      color: #00c9ff;
      font-weight: 500;
    }

    .btn-back:hover {
      color: #80dfff;
    }

    h5 {
      font-size: 1.4rem;
      font-weight: 600;
      margin-bottom: 1.5rem;
      text-align: left;
    }

    .form-label {
      font-weight: 500;
      margin-bottom: 0.5rem;
    }

    .form-select {
      border-radius: 12px;
      padding: 0.6rem;
      background-color: rgba(255,255,255,0.07);
      border: 1px solid #888;
      color: #fff;
    }

    .form-select:focus {
      box-shadow: 0 0 10px rgba(0,201,255,0.5);
      border-color: #00c9ff;
      background-color: rgba(255,255,255,0.1);
    }

    .btn-primary {
      background-color: #00c9ff;
      border: none;
      padding: 0.6rem 1.5rem;
      font-weight: 600;
      transition: all 0.3s ease;
      border-radius: 30px;
    }

    .btn-primary:hover {
      background-color: #0096c7;
      box-shadow: 0 6px 20px rgba(0,201,255,0.3);
    }

    .alert {
      margin-top: 1.5rem;
      text-align: center;
      animation: fadeIn 0.5s ease-in-out;
    }

    footer {
      background-color: #12121c;
      text-align: center;
      padding: 1rem;
      color: #ccc;
      font-size: 0.9rem;
    }
  </style>
</head>

<body>

<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp"/>

<main>
  <div class="assign-container position-relative">

    <a href="${pageContext.request.contextPath}/admin/teacherList"
       class="btn-back"> <i class="bi bi-arrow-left-circle"></i> Back
    </a>

    <c:if test="${not empty successMsg}">
      <div class="alert alert-success">${successMsg}</div>
    </c:if>
    <c:if test="${not empty errorMsg}">
      <div class="alert alert-danger">${errorMsg}</div>
    </c:if>

    <h5>
      Assign Subject to <span style="color: #66aaff;">${teacher.username}</span>
    </h5>

    <form method="post" action="admin/assignSubject">
      <input type="hidden" name="teacherId" value="${teacher.id}" />

      <div class="mb-3">
        <label for="subjectId" class="form-label text-light">Select
          Subject</label> <select name="subjectId" class="form-select"
                                  id="subjectId" required>
        <option value="">-- Select a Subject --</option>
        <c:forEach var="subject" items="${subjects}">
          <option value="${subject.id}">${subject.name}</option>
        </c:forEach>
      </select>
      </div>

      <div class="text-center mt-4">
        <button type="submit" class="btn btn-primary px-4">
          <i class="bi bi-bookmark-check"></i> Assign Subject
        </button>
      </div>
    </form>


  </div>
</main>

<footer>
  &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

</body>
</html>
