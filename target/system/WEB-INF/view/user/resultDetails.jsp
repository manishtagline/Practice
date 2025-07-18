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

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #f0f0f0;
        }

        main {
            flex: 1;
            padding: 2rem;
            max-width: 900px;
            margin: 0 auto;
            width: 100%;
        }

        /* Page Header */
        .page-header {
            position: relative;
            margin-bottom: 1rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid #00c9ff;
        }

        .page-header h1 {
            color: #00c9ff;
            text-shadow: 0 0 10px #00c9ff88;
            font-size: 2.5rem;
            margin-bottom: 0.3rem;
        }

        .page-header p {
            font-weight: 600;
            font-size: 1.2rem;
            color: #a0a0a0;
        }

        /* Back Button */
        .back-btn {
            position: absolute;
            top: 0;
            right: 0;
            background-color: transparent;
            border: 2px solid #00c9ff;
            color: #00c9ff;
            padding: 0.4rem 1.2rem;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s ease;
            cursor: pointer;
            line-height: 1.8rem;
        }

        .back-btn:hover {
            background-color: #00c9ff;
            color: #fff;
            text-decoration: none;
        }

        /* Question Card */
        .question-card {
            background: #3c3c3c;
            border-radius: 1rem;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
            padding: 1.8rem 2rem;
            margin-bottom: 2rem;
            color: #e0e0e0;
            position: relative;
        }

        /* Separator line below each question */
        .question-separator {
            border: 0;
            height: 2px;
            background: linear-gradient(to right, transparent, #00c9ff, transparent);
            margin: 2rem 0;
        }

        .question-desc {
            font-size: 1.3rem;
            font-weight: 600;
            color: #00c9ff;
            margin-bottom: 1rem;
        }

        .option {
            padding: 12px 18px;
            margin-bottom: 10px;
            border-radius: 12px;
            font-size: 1rem;
            border: 1.5px solid #666;
            background-color: #2a2a3a;
            transition: background-color 0.3s ease, border-color 0.3s ease;
        }

        .option.correct {
            background-color: #155724;
            border-color: #28a745;
            color: #d4edda;
            font-weight: 600;
        }

        .option.wrong {
            background-color: #721c24;
            border-color: #dc3545;
            color: #f8d7da;
            font-weight: 600;
        }

        .answer-summary {
            margin-top: 1rem;
            font-weight: 600;
            color: #ccc;
        }

        /* Footer */
        footer {
            background-color: #1a1a2e;
            color: #ccc;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
            margin-top: auto;
            box-shadow: 0 -4px 10px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 576px) {
            main {
                padding: 1rem;
            }

            .question-desc {
                font-size: 1.1rem;
            }

            /* Move back button below header text on small screens */
            .back-btn {
                position: static;
                display: block;
                margin: 0 0 1rem auto;
            }
        }
    </style>
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
