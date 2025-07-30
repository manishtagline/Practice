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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userPageCss/questionPaper.css"/>

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
