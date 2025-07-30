<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Choose Exam - Student Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />


    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userPageCss/enrollmentExam.css"/>

</head>

<body>

<!-- Navbar -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp"/>

<main>
    <!-- Back Button Top Right -->
    <div class="top-right-back-btn">
        <a href="${pageContext.request.contextPath}/home">← Back to Home</a>
    </div>

    <!-- Header -->
    <div class="exam-header">
        <h1>Choose Your Exam</h1>
    </div>

    <!-- Separator Line -->
    <div class="separator"></div>

    <p class="d-flex justify-content-center">Select an exam to begin your enrollment.</p>

    <!-- Toast for success/error messages -->
    <c:if test="${not empty toastMessage}">
        <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 9999">
            <div id="toastMessage" class="toast align-items-center text-bg-${toastType} border-0 show" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                            ${toastMessage}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const toastEl = document.getElementById('toastMessage');
                if (toastEl) {
                    new bootstrap.Toast(toastEl).show();
                }
            });
        </script>
    </c:if>

    <!-- Exam Grid -->
    <section class="exam-grid">
        <c:forEach var="exam" items="${examList}">
            <div class="exam-card">
                <div class="exam-title">${exam.description}</div>
                <div class="exam-details">
                    <div><span>Subject:</span> <span>${exam.subjectName}</span></div>
                    <div><span>Total Marks:</span> <span>${exam.totalMarks}</span></div>
                    <div><span>Total Questions:</span> <span>${exam.totalNumberOfQuestion}</span></div>
                    <c:if test="${not empty exam.formattedEnrolledStartDate && not empty exam.formattedEnrolledEndDate}">
                        <div>
                            <span class="enrollment-label">Enrollment:</span>
                            <span class="enrollment-values">
                                <span>${exam.formattedEnrolledStartDate}</span>
                                <span>${exam.formattedEnrolledEndDate}</span>
                            </span>
                        </div>
                    </c:if>
                </div>
                <c:choose>
                    <c:when test="${exam.userEnrolled}">
                        <div class="text-center text-success fw-bold mt-2">✅ Already Enrolled</div>
                    </c:when>
                    <c:otherwise>
                        <form method="get" action="enrollUser">
                            <input type="hidden" name="examId" value="${exam.id}" />
                            <button type="submit" class="btn btn-start">Enroll</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>
    </section>
</main>

<!-- Footer -->
<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

</body>
</html>
