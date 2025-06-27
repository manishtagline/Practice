update this page <%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            display: flex;
            flex-direction: column;
            position: relative;
        }
        .navbar {
            background: linear-gradient(to right, #4a00e0, #8e2de2);
            padding: 1rem 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            color: white;
            font-size: 1.5rem;
            font-weight: 600;
            text-align: center;
            letter-spacing: 1px;
        }
        main {
            flex: 1;
            padding: 4rem 2rem 2rem;
        }
        table.table {
            width: 100%;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
            background-color: #2a2a3c;
            color: #fff;
        }
        thead th {
            background-color: #33334d;
            text-transform: uppercase;
            font-size: 0.9rem;
        }
        tbody tr {
            background-color: #2d2d44;
            transition: 0.3s ease;
        }
        tbody tr:hover {
            background-color: #3e3e5e;
            transform: scale(1.005);
        }
        th, td {
            padding: 1rem;
            vertical-align: middle;
        }
        h2 {
            font-weight: 700;
            text-align: center;
            color: #fff;
        }
        .btn-sm {
            padding: 6px 12px;
            font-size: 0.85rem;
        }
        .btn-action {
            background-color: #00c9ff;
            color: white;
            border-radius: 20px;
            margin: 0 4px;
            transition: background-color 0.3s ease;
        }
        .btn-action:hover {
            background-color: #0096c7;
        }
        .btn-delete {
            background-color: #e63946 !important;
        }
        .btn-delete:hover {
            background-color: #b92a39 !important;
        }
        .add-question-btn, .back-btn {
            display: inline-block;
            background-color: #00c9ff;
            color: white;
            font-weight: 600;
            padding: 12px 24px;
            border-radius: 30px;
            font-size: 1rem;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .add-question-btn:hover, .back-btn:hover {
            background-color: #0096c7;
        }
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 8px;
        }

        /* Pagination styles */
        .pagination {
            margin-top: 2rem;
            display: flex;
            justify-content: center;
            gap: 0.5rem;
        }
        .page-link {
            border-radius: 20px !important;
            padding: 6px 12px;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }
        /* Normal page buttons */
        .page-link.btn-outline-light {
            background-color: transparent;
            border: 1.5px solid #ccc;
            color: #ccc;
        }
        .page-link.btn-outline-light:hover {
            background-color: #00c9ff;
            color: white;
            border-color: #00c9ff;
            cursor: pointer;
        }
        /* Current page button */
        .page-link.btn-light {
            background-color: #00c9ff !important; /* bright blue */
            color: #fff !important;
            font-weight: 700;
            box-shadow: 0 0 10px #00c9ff;
            cursor: default;
            pointer-events: none; /* disable click on current page */
        }

        .modal-content {
            background: #2a2a3c;
            color: white;
            border-radius: 15px;
        }
        .modal-header, .modal-footer {
            border: none;
        }
        ul.option-list {
            list-style: none;
            padding-left: 0;
        }
        ul.option-list li::before {
            content: attr(data-label) ". ";
            font-weight: bold;
            color: #00c9ff;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">📝 Manage Questions - ${subject.name}</div>

<!-- Main Content -->
<main>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/subjectList" class="back-btn">&larr; Back</a>
        <h2>Questions List</h2>
        <a href="addQuestionPage?subjectId=${subjectId}" class="add-question-btn">+ Add Question</a>
    </div>

    <!-- Table -->
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
                    <ul class="option-list">
                        <c:set var="labels" value="${['A','B','C','D']}" />
                        <c:forEach var="option" items="${question.options}" varStatus="status">
                            <li data-label="${labels[status.index]}">${option}</li>
                        </c:forEach>
                    </ul>
                </td>
                <td>${question.correctAnswer}</td>
                <td>${question.marks}</td>
                <td>${question.complexity}</td>
                <td>
                    <div class="action-buttons">
                        <a href="editQuestion?id=${question.id}" class="btn btn-sm btn-action">Edit</a>
                        <a href="#"
                           class="btn btn-sm btn-action btn-delete"
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
            <a class="btn btn-outline-light page-link" href="manageQuestions?subjectId=${subjectId}&page=${currentPage - 1}">&laquo; Prev</a>
        </c:if>
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a class="btn ${i == currentPage ? 'btn-light' : 'btn-outline-light'} page-link"
               href="manageQuestions?subjectId=${subjectId}&page=${i}">
                    ${i}
            </a>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a class="btn btn-outline-light page-link" href="manageQuestions?subjectId=${subjectId}&page=${currentPage + 1}">Next &raquo;</a>
        </c:if>
    </nav>

</main>

<!-- Modal for delete confirmation -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Confirm Delete</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete the question number <span id="questionNumberSpan"></span>?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-action" data-bs-dismiss="modal">Cancel</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger btn-action">Delete</a>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="text-center mt-auto py-3" style="background-color: #1a1a2e; color: #ccc;">
    &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const deleteButtons = document.querySelectorAll('.btn-delete');
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
        const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
        const questionNumberSpan = document.getElementById('questionNumberSpan');

        deleteButtons.forEach(btn => {
            btn.addEventListener('click', function(e) {
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