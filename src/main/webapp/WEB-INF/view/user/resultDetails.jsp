<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Exam Result Details - Student Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userPageCss/resultDetails.css"/>

</head>
<body>

<!-- Include User Navbar -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp" />

<main>
    <div class="page-header">
        <h1>Exam Result Details</h1>
        <p>Subject: ${exam.subject.name} | Total Marks: ${exam.totalMarks}</p>

        <a href="${pageContext.request.contextPath}/result" class="back-btn">← Back to Home</a>
    </div>

    <c:forEach var="question" items="${questions}">
        <c:set var="qidStr" value="Q${question.id}" />
        <c:set var="correctAnswer" value="${correctAnswers[qidStr]}" />
        <c:set var="userAnswer" value="${userAnswers[qidStr]}" />

        <div class="question-card">
            <div class="question-desc">${question.questiondDesc}</div>

            <c:forEach var="opt" items="${question.options}">
                <div class="option
                    ${opt == correctAnswer ? 'correct' : ''}
                    ${opt == userAnswer && userAnswer != correctAnswer ? 'wrong' : ''}">
                        ${opt}
                </div>
            </c:forEach>

            <div class="answer-summary">
                Your Answer: <span style="color: ${userAnswer == correctAnswer ? '#28a745' : '#dc3545'};">
                    ${userAnswer}
            </span><br/>
                Correct Answer: ${correctAnswer}
            </div>
        </div>

        <!-- Separator line after each question -->
        <hr class="question-separator" />
    </c:forEach>
</main>

<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
