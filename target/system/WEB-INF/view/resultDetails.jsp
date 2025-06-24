<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Exam Result - Student Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background: linear-gradient(90deg, #4a47a3, #6a67ce);
            height: 80px;
            padding: 0 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: #fff;
        }

        .question-header {
            text-align: center;
            padding: 3rem 1rem 1rem;
            color: #2c3e50;
        }

        .question-list {
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .question-card {
            background-color: white;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(74, 71, 163, 0.15);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .question-desc {
            font-size: 1.25rem;
            font-weight: 600;
            color: #4a47a3;
            margin-bottom: 1rem;
        }

        .option {
            padding: 10px 15px;
            margin-bottom: 10px;
            border-radius: 12px;
            font-size: 1rem;
            border: 1px solid #ccc;
        }

        .correct {
            background-color: #d4edda;
            border-color: #28a745;
            color: #155724;
        }

        .wrong {
            background-color: #f8d7da;
            border-color: #dc3545;
            color: #721c24;
        }

        footer {
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
            background-color: rgba(255, 255, 255, 0.9);
            color: #4a47a3;
            margin-top: auto;
            box-shadow: 0 -4px 10px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <h2>📘 Exam Center</h2>
    <span>Exam: ${exam.description}</span>
</nav>

<!-- Header -->
<section class="question-header">
    <h1>Exam Result</h1>
    <p>Subject: ${exam.subject.name} | Total Marks: ${exam.totalMarks}</p>
</section>

<!-- Questions with Answers -->
<div class="question-list">
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

            <div class="mt-2">
                <strong>Your Answer:</strong> ${userAnswer}<br/>
                <strong>Correct Answer:</strong> ${correctAnswer}
            </div>
        </div>
    </c:forEach>
</div>

<!-- Back Button -->
<div class="mb-4 text-center">
    <a href="result" class="btn btn-outline-light btn-sm"
       style="background-color: #4a47a3; color: white; font-weight: 600; border-radius: 30px;">
        ← Back to Home
    </a>
</div>


<!-- Footer -->
<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

</body>
</html>
