<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Question Paper - Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            color: #f0f0f0;
            min-height: 100vh;
            margin: 0;
            display: flex;
            flex-direction: column;
        }
        main {
            flex: 1;
            padding: 2rem;
            max-width: 900px;
            margin: 0 auto;
            width: 100%;
        }

        h1.page-title {
            text-align: center;
            font-weight: 700;
            font-size: 2.8rem;
            color: #00c9ff;
            text-shadow: 0 0 10px #00c9ff88;
            margin-bottom: 0.25rem;
        }
        .exam-info {
            text-align: center;
            font-size: 1.25rem;
            color: #a0d8ff;
            font-weight: 600;
            margin-bottom: 0.75rem;
        }
        .exam-description {
            text-align: center;
            font-size: 1rem;
            color: #7f8c8d;
            margin-bottom: 2rem;
        }

        .question-card {
            background: #3c3c3c;
            border-radius: 1rem;
            padding: 1.8rem 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 20px rgba(0,0,0,0.7);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            color: #f0f0f0;
        }
        .question-card:hover {
            background-color: #505050;
            box-shadow: 0 12px 30px rgba(0,0,0,0.9);
        }

        .question-desc {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #00c9ff;
        }

        .option-list {
            list-style: none;
            padding-left: 0;
            margin-bottom: 1rem;
        }
        .option-list li {
            background-color: #575757;
            margin-bottom: 0.6rem;
            padding: 12px 18px;
            border-radius: 15px;
            border: 1px solid #00c9ff;
            font-size: 1rem;
            cursor: pointer;
            color: #f0f0f0;
            transition: background-color 0.3s ease;
        }
        .option-list li:hover {
            background-color: #00a1cc;
        }
        .option-list li input[type="radio"] {
            margin-right: 10px;
            cursor: pointer;
        }

        .marks-complexity {
            font-size: 0.9rem;
            color: #a0d8ff;
            font-weight: 600;
            display: flex;
            justify-content: flex-end;
        }

        .submit-container {
            text-align: center;
            margin: 3rem 0 2rem;
        }

        footer {
            background-color: #1a1a2e;
            color: #ccc;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
        }

        /* Modal custom styling */
        .modal-content {
            background: #2b2b3d;
            color: #e0e6f1;
            border-radius: 1rem;
            box-shadow: 0 12px 30px rgba(0, 201, 255, 0.7);
        }

        .modal-header {
            border-bottom: 1px solid #00c9ff55;
        }

        .modal-title {
            color: #00c9ff;
            font-weight: 700;
            font-size: 1.4rem;
        }

        .modal-body p {
            font-size: 1rem;
            color: #cce7ff;
            line-height: 1.4;
        }

        .btn-outline-secondary {
            color: #00c9ff;
            border-color: #00c9ff;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .btn-outline-secondary:hover {
            background-color: #00c9ff;
            color: #1f1c2c;
        }

        .btn-primary {
            background-color: #00c9ff;
            border-color: #00c9ff;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0099cc;
            border-color: #0099cc;
        }

        @media (max-width: 576px) {
            main {
                padding: 1rem;
            }
            h1.page-title {
                font-size: 2rem;
            }
            .question-card {
                padding: 1.2rem 1.5rem;
            }
        }
    </style>
</head>

<body>

<main>

    <h1 class="page-title">Question Paper</h1>
    <div class="exam-info">${exam.subject.name} | Total Marks: ${exam.totalMarks}</div>
    <div class="exam-description">${exam.description}</div>

    <form id="examForm" action="${pageContext.request.contextPath}/submitExam" method="post">

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

                <div class="marks-complexity">Marks: ${question.marks}</div>
            </div>
        </c:forEach>

        <div class="submit-container">
            <button type="button" class="btn btn-primary btn-lg" id="submitBtn">
                Submit Exam
            </button>
        </div>
    </form>

</main>

<footer>
    <p>&copy; 2025 Exam Center. All rights reserved.</p>
</footer>

<!-- Bootstrap JS and necessary Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom Script -->
<script>
    let allAnswered = true; // To track if all questions are answered

    const formElements = document.querySelectorAll("input[type='radio']");

    // This will track if any of the questions has been answered
    function checkAllAnswered() {
        allAnswered = true;
        document.querySelectorAll('.question-card').forEach(function(card) {
            const selectedOption = card.querySelector('input[type="radio"]:checked');
            if (!selectedOption) {
                allAnswered = false;
            }
        });
    }

    document.getElementById('submitBtn').addEventListener('click', function(e) {
        checkAllAnswered(); // Check if all questions are answered

        if (!allAnswered) {
            // If not all questions are answered, show a modal
            const modal = new bootstrap.Modal(document.getElementById('incompleteModal'), {
                backdrop: 'static',
                keyboard: false
            });
            modal.show();
            return; // Prevent form submission
        }

        // If all answered, submit the form
        document.getElementById('examForm').submit();
    });

    window.addEventListener('beforeunload', function(event) {
        checkAllAnswered(); // Check if all questions are answered

        if (!allAnswered) {
            const message = "Please provide all answers before submitting the exam.";
            event.returnValue = message; // Standard for most browsers
            return message; // For some older browsers
        }
    });

</script>

<!-- Incomplete Answer Modal -->
<div class="modal fade" id="incompleteModal" tabindex="-1" aria-labelledby="incompleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 shadow">
            <div class="modal-header border-bottom-0">
                <h5 class="modal-title" id="incompleteModalLabel">Incomplete Answers</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body py-4">
                <p>Please make sure you have answered all the questions before submitting the exam.</p>
            </div>
            <div class="modal-footer border-top-0 d-flex justify-content-center">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Okay</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
