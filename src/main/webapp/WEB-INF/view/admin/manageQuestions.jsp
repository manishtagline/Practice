<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Manage Questions - Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        /* CSS styles same as your original code */
        html, body {
            height: 100%;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background: linear-gradient(to right, #4a00e0, #8e2de2);
            padding: 1rem 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            color: white;
            font-size: 1.5rem;
            font-weight: 600;
            text-align: center;
        }
        main {
            flex: 1;
            padding: 4rem 2rem 2rem;
        }
        .table {
            width: 100%;
            border-radius: 16px;
            overflow: hidden;
            background-color: #2a2a3c;
            color: #fff;
        }
        th, td {
            padding: 1rem;
            vertical-align: middle;
        }
        thead th {
            background-color: #33334d;
        }
        tbody tr:hover {
            background-color: #3e3e5e;
        }
        h2 {
            color: #fff;
            font-weight: 700;
            text-align: center;
        }
        .btn-sm {
            font-size: 0.85rem;
        }
        .btn-action {
            background-color: #00c9ff;
            color: white;
            border-radius: 20px;
            margin: 0 4px;
        }
        .btn-delete {
            background-color: #e63946 !important;
        }
        .btn-delete:hover {
            background-color: #b92a39 !important;
        }
        .add-question-btn, .back-btn {
            background-color: #00c9ff;
            color: white;
            font-weight: 600;
            padding: 12px 24px;
            border-radius: 30px;
            text-decoration: none;
        }
        .pagination {
            margin-top: 2rem;
            display: flex;
            justify-content: center;
            gap: 0.5rem;
        }
        .page-link {
            border-radius: 20px !important;
            padding: 6px 12px;
        }
        .page-link.btn-light {
            background-color: #00c9ff !important;
            color: #fff !important;
            pointer-events: none;
        }
        .filter-form {
            width: 100%;
            margin-bottom: 2rem;
            color: #fff;
        }
        .filter-form label {
            font-weight: 600;
            min-width: max-content;
        }
        .filter-form select.form-select-sm {
            background-color: #1a1a2e !important;
            border: 2px solid #00c9ff !important;
            color: #00c9ff !important;
            border-radius: 10px !important;
        }
        footer {
            text-align: center;
            background-color: #1a1a2e;
            color: #ccc;
            padding: 1rem;
        }
    </style>
</head>
<body>

<div class="navbar d-flex justify-content-center">📝 Manage Questions - ${subject.name}</div>

<main>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/subjectList" class="back-btn">&larr; Back</a>
        <h2>Questions List</h2>
        <a href="addQuestionPage?subjectId=${subjectId}" class="add-question-btn">+ Add Question</a>
    </div>

    <!-- Filter & Sort -->
    <form method="get" action="manageQuestions" class="filter-form d-flex align-items-center gap-4 flex-wrap">
        <input type="hidden" name="subjectId" value="${subjectId}" />

        <div class="d-flex align-items-center gap-2">
            <label for="complexity" class="mb-0 fw-semibold text-white">Filter by Complexity:</label>
            <select name="complexity" id="complexity" class="form-select form-select-sm text-primary" style="min-width: 140px;" onchange="this.form.submit()">
                <option value="" <c:if test="${empty complexity}">selected</c:if>>All</option>
                <option value="Easy" <c:if test="${complexity == 'Easy'}">selected</c:if>>Easy</option>
                <option value="Medium" <c:if test="${complexity == 'Medium'}">selected</c:if>>Medium</option>
                <option value="Hard" <c:if test="${complexity == 'Hard'}">selected</c:if>>Hard</option>
            </select>
        </div>

        <div class="d-flex align-items-center gap-2">
            <label for="sortBy" class="mb-0 fw-semibold text-white">Sort by:</label>
            <select name="sortBy" id="sortBy" class="form-select form-select-sm text-primary" style="min-width: 140px;" onchange="this.form.submit()">
                <option value="" <c:if test="${empty sortBy}">selected</c:if>>Default</option>
                <option value="marks" <c:if test="${sortBy == 'marks'}">selected</c:if>>Marks</option>
            <%--    <option value="complexity" <c:if test="${sortBy == 'complexity'}">selected</c:if>>Complexity</option>--%>
            </select>
        </div>
    </form>

    <!-- Questions Table -->
    <table class="table table-hover text-center align-middle">
        <thead>
        <tr>
            <th>ID</th>
            <th>Description</th>
            <th>Options</th>
            <th>Correct Answer</th>
            <th>Marks</th>
            <th>Complexity</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="question" items="${questions}">
            <tr>
                <td>${question.id}</td>
                <td>${question.questiondDesc}</td>
                <td>
                    <ul class="list-unstyled mb-0">
                        <c:set var="labels" value="${['A','B','C','D']}" />
                        <c:forEach var="option" items="${question.options}" varStatus="status">
                            <li><strong>${labels[status.index]}:</strong> ${option}</li>
                        </c:forEach>
                    </ul>
                </td>
                <td>${question.correctAnswer}</td>
                <td>${question.marks}</td>
                <td>${question.complexity}</td>
                <td>
                    <div class="d-flex justify-content-center">
                        <a href="editQuestion?id=${question.id}&subjectId=${subjectId}" class="btn btn-sm btn-action">Edit</a>
                        <a href="#" class="btn btn-sm btn-action btn-delete"
                           data-delete-url="deleteQuestion?id=${question.id}&subjectId=${subjectId}"
                           data-question-id="${question.id}">
                            Delete
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Pagination -->
    <nav class="pagination">
        <c:if test="${currentPage > 1}">
            <a class="btn btn-outline-light page-link"
               href="manageQuestions?subjectId=${subjectId}&complexity=${complexity}&sortBy=${sortBy}&page=${currentPage - 1}">&laquo; Prev</a>
        </c:if>

        <c:forEach var="i" begin="1" end="${totalPages}">
            <a class="btn ${i == currentPage ? 'btn-light' : 'btn-outline-light'} page-link"
               href="manageQuestions?subjectId=${subjectId}&complexity=${complexity}&sortBy=${sortBy}&page=${i}">
                    ${i}
            </a>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
            <a class="btn btn-outline-light page-link"
               href="manageQuestions?subjectId=${subjectId}&complexity=${complexity}&sortBy=${sortBy}&page=${currentPage + 1}">Next &raquo;</a>
        </c:if>
    </nav>
</main>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-white" style="background-color:#2a2a3c;">
            <div class="modal-header">
                <h5 class="modal-title">Confirm Delete</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete question ID <span id="questionNumberSpan"></span>?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-action" data-bs-dismiss="modal">Cancel</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger btn-action">Delete</a>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const deleteButtons = document.querySelectorAll('.btn-delete');
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
        const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
        const questionNumberSpan = document.getElementById('questionNumberSpan');

        deleteButtons.forEach(btn => {
            btn.addEventListener('click', function (e) {
                e.preventDefault();
                const url = this.getAttribute('data-delete-url');
                const questionId = this.getAttribute('data-question-id');

                questionNumberSpan.textContent = questionId;
                confirmDeleteBtn.setAttribute('href', url);
                deleteModal.show();
            });
        });
    });
</script>

</body>
</html>
