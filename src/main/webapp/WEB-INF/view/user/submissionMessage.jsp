<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Exam Submission Confirmation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userPageCss/submissionMessage.css"/>


</head>
<body>

<div class="confirmation-card">
    <h1>✅ Exam Submitted Successfully!</h1>
    <h2>Result will be declared after the subject exam is ended.</h2>

    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Go to Home</a>
</div>

<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
