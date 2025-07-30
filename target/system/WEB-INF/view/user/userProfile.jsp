<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>User Profile - Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userPageCss/userProfile.css"/>


</head>
<body>

<!-- Include Navbar -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp"/>

<main>
    <!-- Profile Header -->
    <section class="profile-header" aria-label="User Profile Information">
        <h1>${user.username}</h1>
        <p><i class="fas fa-envelope"></i> ${user.email}</p>
        <p><strong>Role:</strong> ${user.role}</p>
        <p><strong>Time Zone:</strong> ${user.zoneId}</p>
    </section>

    <!-- User Stats or Summary Section -->
    <section aria-label="User Exam Statistics or Summary">
        <h2 class="section-title">Your Exam Summary</h2>

        <div class="stats-wrapper">
            <c:choose>
                <c:when test="${not empty examStats}">
                    <div class="stats-card" role="region" aria-labelledby="exam-summary-title">
                        <h3 id="exam-summary-title">Exams Overview</h3>

                        <!-- First Row -->
                        <div class="stats-row">
                            <div class="stat-item"><i class="fas fa-file-alt"></i><strong>Total Exams Enrolled:</strong> ${examStats.enrolledCount}</div>
                            <div class="stat-item"><i class="fas fa-check-circle"></i><strong>Exams Completed:</strong> ${examStats.completedCount}</div>
                        </div>

                        <!-- Second Row -->
                        <div class="stats-row">
                            <div class="stat-item"><i class="fas fa-check"></i><strong>Total Correct Answers:</strong> ${examStats.totalCorrectAnswers}</div>
                            <div class="stat-item"><i class="fas fa-times"></i><strong>Total Wrong Answers:</strong> ${examStats.totalWrongAnswers}</div>
                            <div class="stat-item"><i class="fas fa-percent"></i><strong>Overall Percentage:</strong> ${examStats.overallPercentage} %</div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <p>No exam data available.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</main>

<footer>
    &copy; 2025 Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
