<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Subject List - Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap 5 JS Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

    <!-- Link to your navbar CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminNavbar.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/userList.css"/>

</head>

<body>

<!-- Include navbar -->
<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp" />

<!-- Main Content -->
<main>
    <div class="header-row">
        <h2>Information Of User</h2>
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
            <th>Enrolled Subjects</th>
            <th>Total Number of Exam</th>
            <th>Average Score</th>
            <th>Highest Score</th>
            <th>Lowest Score</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.userId}</td>
                <td>${user.username}</td>
                <td>
                    <c:forEach var="subject" items="${user.enrolledSubjects}" varStatus="status">
                        ${subject}<c:if test="${!status.last}">, </c:if>
                    </c:forEach>
                </td>
                <td>${user.totalExams}</td>
                <td>
                    <c:choose>
                        <c:when test="${user.averageScore != null}">
                            <fmt:formatNumber value="${user.averageScore}" type="number" maxFractionDigits="2" />
                        </c:when>
                        <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${user.highestScore != null}">
                            ${user.highestScore}
                        </c:when>
                        <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${user.lowestScore != null}">
                            ${user.lowestScore}
                        </c:when>
                        <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>

    </table>

    <!-- Add Subject Button -->
   <%-- <div class="text-center">
        <a href="addSubjectPage" class="add-subject-btn mt-4">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <line x1="12" y1="5" x2="12" y2="19"/>
                <line x1="5" y1="12" x2="19" y2="12"/>
            </svg>
            Add User
        </a>
    </div>--%>
</main>

<!-- Footer -->
<footer>
    &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

</body>
</html>
