<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit Subject - Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/editSubject.css"/>

</head>

<body>

<!-- Background Animation -->
<div class="background-animation">
    <svg viewBox="0 0 1440 320" preserveAspectRatio="none" style="width:100%; height:100%;">
        <path fill="#ffffff" fill-opacity="0.3"
              d="M0,96L48,128C96,160,192,224,288,245.3C384,267,480,245,576,218.7C672,192,768,160,864,154.7C960,149,1056,171,1152,160C1248,149,1344,107,1392,85.3L1440,64L1440,320L0,320Z">
        </path>
    </svg>
</div>

<!-- Navbar -->
<div class="navbar">✏️ Edit Subject</div>

<!-- Main Content -->
<main>
    <div class="form-container">
        <h2>Edit Subject</h2>

        <form action="${pageContext.request.contextPath}/updateSubject" method="post">
            <!-- Hidden ID field -->
            <input type="hidden" name="id" value="${subject.id}" />

            <div class="mb-3">
                <label for="subjectName" class="form-label">Subject Name</label>
                <input type="text" class="form-control" id="subjectName" name="name" value="${subject.name}" required />
            </div>

            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-submit">Update Subject</button>
            </div>
        </form>

        <!-- Back Button -->
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/subjectList" class="btn-back">← Back to Subject List</a>
        </div>
    </div>
</main>

<!-- Footer -->
<footer>
    &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

</body>
</html>
