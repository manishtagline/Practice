<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Your Exam Results - Student Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userPageCss/result.css"/>

</head>
<body>

<!-- Include user navbar -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp" />

<main>

    <!-- Page Header and Back Button -->
    <div class="page-header">
        <h2>Your Exam History</h2>
        <a href="${pageContext.request.contextPath}/home" class="back-btn">← Back to Dashboard</a>
    </div>

    <!-- Section Divider -->
    <div class="section-divider"></div>

    <!-- Exam Cards -->
    <section class="exam-grid">
        <c:if test="${not empty resultList}">
            <c:forEach var="res" items="${resultList}">
                <div class="exam-card">
                    <h4>${res.exam.description}</h4>

                    <div class="exam-info">
                        <p><strong>Exam ID:</strong> #${res.exam.id}</p>
                        <p><strong>Score:</strong> ${res.totalScore} / ${res.exam.totalMarks}</p>
<%--                        <p><strong>Percentage:</strong> <fmt:formatNumber value="${res.percentage}" maxFractionDigits="2"/>%</p>--%>
                    </div>

                    <div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="${res.percentage}">
                        <div class="progress-bar" style="width: ${res.percentage}%; padding-right: 10px; padding-left: 10px;">
                            <fmt:formatNumber value="${res.percentage}" maxFractionDigits="1"/>%
                        </div>
                    </div>

                    <button class="view-details-btn"
                            onclick="window.location.href='${pageContext.request.contextPath}/examResultDetails?resultId=${res.id}'">
                        View Exam Details
                    </button>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${empty resultList}">
            <div class="alert alert-info">
                You haven’t taken any exams yet. Try
                <a href="${pageContext.request.contextPath}/exam" style="color:#00c9ff; text-decoration: underline;">starting one now</a>!
            </div>
        </c:if>
    </section>

</main>

<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
