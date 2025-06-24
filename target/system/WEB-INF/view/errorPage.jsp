<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Error - Student Exam Center</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <style>
    body {
      background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
      font-family: 'Segoe UI', sans-serif;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      justify-content: center;
      align-items: center;
      color: #333;
      text-align: center;
    }

    .error-container {
      background: #fff;
      padding: 3rem;
      border-radius: 16px;
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
      max-width: 500px;
    }

    .error-code {
      font-size: 5rem;
      font-weight: bold;
      color: #dc3545;
    }

    .error-message {
      font-size: 1.25rem;
      margin-top: 1rem;
    }

    .back-btn {
      margin-top: 2rem;
      background-color: #dc3545;
      color: white;
      border: none;
      border-radius: 30px;
      padding: 10px 20px;
      font-weight: bold;
      text-decoration: none;
    }

    .back-btn:hover {
      background-color: #bd2130;
    }
  </style>
</head>
<body>

<div class="error-container">
  <div class="error-code">⚠️</div>
  <h2>Error Occurred</h2>
  <div class="error-message">
    <c:out value="${errorMessage}" default="An unexpected error has occurred. Please try again later." />
  </div>
  <a href="${pageContext.request.contextPath}/home" class="back-btn">← Back to Home</a>
</div>

</body>
</html>
