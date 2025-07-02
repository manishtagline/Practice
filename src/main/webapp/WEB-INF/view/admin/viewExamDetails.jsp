<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>View Exam - Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/viewExamDetails.css"/>

</head>
<body>

<div class="navbar d-flex justify-content-center">
    <h1>📄 Exam Details</h1>
</div>

<div class="back-button-container">
    <a href="examList" class="btn-back">&#8592; Back to Exam List</a>
</div>

<div class="container">

    <div class="exam-detail">
        <h2>${exam.description}</h2>
        <p><strong>Subject:</strong> ${exam.subject.name}</p>
        <p><strong>Total Marks:</strong> ${exam.totalMarks}</p>
        <p><strong>Number of Questions:</strong> ${exam.totalNumberOfQuestion}</p>
        <p><strong>Date Created:</strong> ${formattedDate}</p>
    </div>

    <c:forEach var="question" items="${exam.questions}">
        <div class="question-block">
            <div class="question-title">Q: ${question.questiondDesc}</div>
            <ul class="option-list">
                <c:forEach var="option" items="${question.options}">
                    <li>&#10148; ${option}</li>
                </c:forEach>
            </ul>
            <p><strong>Correct Answer:</strong> ${question.correctAnswer}</p>
            <p><strong>Marks:</strong> ${question.marks}</p>
            <p><strong>Complexity:</strong> ${question.complexity}</p>
        </div>
    </c:forEach>

</div>

<footer>
    &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

</body>
</html>
