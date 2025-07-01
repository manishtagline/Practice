<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Question Paper - Student Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Google Fonts -->
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

        .navbar h2 {
            font-weight: 700;
            font-size: 1.5rem;
            letter-spacing: 1px;
        }

        .navbar span {
            font-size: 1rem;
            font-weight: 500;
            background-color: #ffd700;
            color: #4a47a3;
            padding: 6px 18px;
            border-radius: 20px;
        }

        .question-header {
            text-align: center;
            padding: 3rem 1rem 1rem;
            color: #2c3e50;
        }

        .question-header h1 {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .question-header p {
            font-size: 1.2rem;
            color: #4a47a3;
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
            animation: slideUp 0.6s ease forwards;
        }

        .question-card:hover {
            box-shadow: 0 20px 40px rgba(74, 71, 163, 0.3);
        }

        .question-desc {
            font-size: 1.25rem;
            font-weight: 600;
            color: #4a47a3;
            margin-bottom: 1rem;
        }

        .option-list {
            list-style: none;
            padding-left: 0;
            margin-bottom: 1rem;
        }

        .option-list li {
            background-color: #f4f6ff;
            margin-bottom: 0.6rem;
            padding: 10px 15px;
            border-radius: 15px;
            border: 1px solid #d0d6f9;
            font-size: 1rem;
            color: #333;
            cursor: pointer;
        }

        .option-list li input[type="radio"] {
            margin-right: 10px;
            cursor: pointer;
        }

        .marks-complexity {
            font-size: 0.9rem;
            color: #6a67ce;
            font-weight: 600;
            display: flex;
            justify-content: space-between;
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

        @keyframes slideUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @media (max-width: 576px) {
            .question-header h1 { font-size: 2rem; }
            .question-card { padding: 1.5rem; }
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
    <h1>Question Paper</h1>
    <p>Subject: ${exam.subject.name} | Total Marks: ${exam.totalMarks}</p>
</section>

<!-- Question List Form -->
<form id="examForm" action="${pageContext.request.contextPath}/submitExam" method="post" class="question-list">

    <!-- Hidden examId -->
    <input type="hidden" name="examId" value="${exam.id}" />

    <c:forEach var="question" items="${questions}">
        <div class="question-card">
            <div class="question-desc">${question.questiondDesc}</div>

            <ul class="option-list">
                <c:forEach var="opt" items="${question.options}" varStatus="status">
                    <li>
                        <input
                                type="radio"
                                name="answers[${question.id}]"
                                id="q${question.id}_opt${status.index}"
                                value="${opt}"
                                required
                        />
                        <label for="q${question.id}_opt${status.index}">${opt}</label>
                    </li>
                </c:forEach>
            </ul>

            <div class="marks-complexity">
                <span>Marks: ${question.marks}</span>
                <%--<span>Complexity: ${question.complexity}</span>--%>
            </div>
        </div>
    </c:forEach>

    <div style="text-align:center; margin: 2rem;">
        <!-- Button triggers Bootstrap modal -->
        <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#confirmSubmitModal">
            Submit Exam
        </button>
    </div>
</form>

<!-- Bootstrap Confirmation Modal -->
<div class="modal fade" id="confirmSubmitModal" tabindex="-1" aria-labelledby="confirmSubmitModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 shadow">
            <div class="modal-header border-bottom-0">
                <h5 class="modal-title" id="confirmSubmitModalLabel">Confirm Submission</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body py-4">
                <p>Are you sure you want to submit the exam? Once submitted, you cannot change your answers.</p>
            </div>
            <div class="modal-footer border-top-0 d-flex justify-content-between">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="modalConfirmBtn">Yes, Submit</button>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Submit form when modal confirmation button clicked
    document.getElementById('modalConfirmBtn').addEventListener('click', function () {
        document.getElementById('examForm').submit();
    });
</script>

</body>
</html>
