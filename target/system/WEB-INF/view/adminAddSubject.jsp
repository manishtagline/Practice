<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Add Subject - Admin Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

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
    }

    .background-animation {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: 0;
      overflow: hidden;
      opacity: 0.2;
    }

    .navbar {
      background: linear-gradient(to right, #4a00e0, #8e2de2);
      padding: 1rem 2rem;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
      color: white;
      font-size: 1.5rem;
      font-weight: 600;
      z-index: 10;
      text-align: center;
      letter-spacing: 1px;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    main {
      flex: 1;
      z-index: 2;
      padding: 3rem 2rem;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .form-container {
      background-color: #2a2a3c;
      padding: 2.5rem;
      border-radius: 20px;
      max-width: 500px;
      width: 100%;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
    }

    .form-container h2 {
      color: white;
      font-weight: 700;
      margin-bottom: 1.5rem;
      text-align: center;
    }

    label {
      color: #ccc;
      margin-bottom: 0.5rem;
    }

    input.form-control {
      background-color: #3e3e5e;
      color: white;
      border: 1px solid #555;
    }

    input.form-control:focus {
      background-color: #3e3e5e;
      color: white;
      border-color: #8e2de2;
      box-shadow: 0 0 0 0.2rem rgba(142, 45, 226, 0.25);
    }

    .btn-submit {
      background-color: #00c9ff;
      color: white;
      font-weight: 600;
      padding: 10px 20px;
      border: none;
      border-radius: 30px;
      transition: all 0.3s ease;
    }

    .btn-submit:hover {
      background-color: #0096c7;
      box-shadow: 0 6px 18px rgba(0, 201, 255, 0.45);
    }

    .btn-back {
      background-color: transparent;
      color: #ccc;
      border: 1px solid #ccc;
      padding: 8px 16px;
      border-radius: 20px;
      font-weight: 500;
      margin-top: 1rem;
      text-decoration: none;
      transition: 0.3s;
      display: inline-block;
      text-align: center;
    }

    .btn-back:hover {
      color: white;
      border-color: #fff;
      background-color: rgba(255, 255, 255, 0.1);
    }

    .message {
      text-align: center;
      margin-bottom: 1.5rem;
      font-size: 1rem;
      font-weight: 600;
    }

    .success-msg {
      color: #39ff14;
      text-shadow: 0 0 6px #39ff14, 0 0 12px #39ff14;
    }

    .error-msg {
      color: #ff4c4c;
      text-shadow: 0 0 6px #ff4c4c, 0 0 12px #ff4c4c;
    }

    footer {
      background-color: #1a1a2e;
      color: #ccc;
      text-align: center;
      padding: 1rem;
      font-size: 0.9rem;
      z-index: 2;
    }

    @media (max-width: 576px) {
      .form-container {
        padding: 1.5rem;
      }
    }
  </style>
</head>

<body>

<!-- Background Animation -->
<div class="background-animation">
  <svg viewBox="0 0 1440 320" preserveAspectRatio="none" style="width:100%; height:100%;">
    <path fill="#ffffff" fill-opacity="0.3"
          d="M0,96L48,128C96,160,192,224,288,245.3C384,267,480,245,576,218.7C672,192,768,160,864,154.7C960,149,1056,171,1152,160C1248,149,1344,107,1392,85.3L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
    </path>
  </svg>
</div>

<!-- Navbar -->
<div class="navbar">📘 Add New Subject</div>

<!-- Main Content -->
<main>
  <div class="form-container">
    <h2>Add Subject</h2>

    <!-- Success or Error Messages -->
    <c:if test="${not empty successMsg}">
      <div class="message success-msg">${successMsg}</div>
    </c:if>
    <c:if test="${not empty errorMsg}">
      <div class="message error-msg">${errorMsg}</div>
    </c:if>

    <form action="saveSubject" method="post">
      <div class="mb-3">
        <label for="subjectName" class="form-label">Subject Name</label>
        <input type="text" class="form-control" id="subjectName" name="name" required placeholder="Enter subject name" />
      </div>
      <div class="d-grid mt-4">
        <button type="submit" class="btn btn-submit">Add Subject</button>
      </div>
    </form>

    <!-- Back Button -->
    <div class="text-center mt-3">
      <a href="subjectList" class="btn-back">← Back to Subject List</a>
    </div>
  </div>
</main>

<!-- Footer -->
<footer>
  &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

</body>
</html>
