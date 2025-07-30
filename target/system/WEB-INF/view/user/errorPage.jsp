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

  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userPageCss/errorPage.css"/>

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
