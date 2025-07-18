<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Error - Student Exam Center</title>

  <!-- Bootstrap 5 CSS (updated) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

  <style>
    body {
      background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #f8f9fa;
      margin: 0;
      padding: 0 1rem;
    }

    .error-container {
      background: #1f2937; /* dark slate */
      padding: 2.5rem 3rem;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.4);
      max-width: 480px;
      width: 100%;
      text-align: center;
    }

    .error-icon {
      font-size: 4.5rem;
      color: #f87171; /* soft red */
      margin-bottom: 1rem;
    }

    h2 {
      font-weight: 700;
      font-size: 2rem;
      margin-bottom: 0.5rem;
      color: #f3f4f6; /* light gray */
    }

    .error-message {
      font-size: 1.1rem;
      margin-bottom: 2rem;
      color: #d1d5db; /* lighter gray */
      min-height: 3rem;
    }

    .back-btn {
      display: inline-block;
      background-color: #3b82f6; /* bright blue */
      color: white;
      font-weight: 600;
      padding: 0.6rem 1.8rem;
      border-radius: 30px;
      text-decoration: none;
      transition: background-color 0.3s ease;
      box-shadow: 0 4px 10px rgba(59, 130, 246, 0.4);
      user-select: none;
    }

    .back-btn:hover,
    .back-btn:focus {
      background-color: #2563eb;
      box-shadow: 0 6px 15px rgba(37, 99, 235, 0.6);
      outline: none;
      color: white;
    }

    @media (max-width: 576px) {
      .error-container {
        padding: 2rem 1.5rem;
      }
    }
  </style>
</head>
<body>

<main class="error-container" role="main" aria-labelledby="error-title">
  <i class="bi bi-exclamation-triangle-fill error-icon" aria-hidden="true"></i>
  <h2 id="error-title">Oops! Something went wrong</h2>
  <p class="error-message" role="alert" aria-live="assertive">
    <c:out value="${errorMessage}" default="An unexpected error has occurred. Please try again later." />
  </p>
  <a href="${pageContext.request.contextPath}/home" class="back-btn" role="button" aria-label="Back to Home">
    ← Back to Home
  </a>
</main>

</body>
</html>
