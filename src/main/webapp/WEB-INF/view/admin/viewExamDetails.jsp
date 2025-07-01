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
    <style>
        body {
            background: linear-gradient(to right, #1f1c2c, #928dab);
            font-family: 'Poppins', sans-serif;
            margin: 0;
            color: #f0f0f0;
        }

        .navbar {
            background: linear-gradient(to right, #4a00e0, #8e2de2);
            padding: 1rem;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

        .navbar h1 {
            color: white;
            font-size: 1.6rem;
            font-weight: 600;
            margin: 0;
        }

        .back-button-container {
            padding: 1rem 2rem 0 2rem;
            text-align: right;
        }

        .btn-back {
            background-color: #00c9ff;
            color: white;
            padding: 8px 20px;
            font-weight: 600;
            border: none;
            border-radius: 20px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background-color: #0096c7;
        }

        .container {
            padding: 2rem;
        }

        h2 {
            color: #ffffff;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .exam-detail, .question-block {
            background-color: #4e4e4e;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.4);
        }

        .question-title {
            font-weight: 600;
            margin-bottom: .8rem;
            font-size: 1.1rem;
        }

        ul.option-list {
            list-style-type: none;
            padding-left: 1rem;
        }

        ul.option-list li {
            margin-bottom: .4rem;
        }

        footer {
            text-align: center;
            padding: 1rem;
            background: #1a1a2e;
            color: #ccc;
        }
    </style>
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
