<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Subject List - Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap 5 JS Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <!-- Link to your navbar CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminNavbar.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/subjectList.css"/>
</head>

<body>

<!-- Include navbar -->
<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp" />

<!-- Main Content -->
<main>
    <div class="header-row">
        <h2>Manage Subjects</h2>
        <div class="back-btn-container">
            <a href="adminPage" class="add-subject-btn" style="width: auto; padding: 12px 24px; margin: 0;">
                &#8592; Back to Dashboard
            </a>
        </div>
    </div>


    <table class="table table-hover text-center align-middle">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Total Questions</th>
            <th>Total Exams</th>
            <th>Manage Questions</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="subject" items="${subjects}">
            <tr>
                <td>${subject.id}</td>
                <td>${subject.name}</td>
                <td>${subject.questionCount}</td>
                <td>${subject.examCount}</td>
                <td>
                    <a href="manageQuestions?subjectId=${subject.id}" class="btn btn-sm btn-manage">Manage</a>
                </td>
                <td>
                    <a href="editSubject?id=${subject.id}" class="btn btn-sm btn-warning">Edit</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Add Subject Button -->
    <div class="text-center">
        <a href="addSubjectPage" class="add-subject-btn mt-4">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <line x1="12" y1="5" x2="12" y2="19"/>
                <line x1="5" y1="12" x2="19" y2="12"/>
            </svg>
            Add Subject
        </a>
    </div>
</main>

<!-- Footer -->
<footer>
    &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

</body>
</html>
