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
            z-index: 10;
            text-align: center;
            letter-spacing: 1px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        main {
            flex: 1;
            z-index: 2;
            padding: 4rem 2rem 2rem;
        }
        .table-container {
            background-color: #2a2a3c;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
            padding: 2rem;
            overflow-x: auto;
        }
        thead th {
            background-color: #33334d;
            color: #fff;
            text-transform: uppercase;
            font-size: 0.9rem;
        }
        tbody tr {
            background-color: #2d2d44;
            transition: 0.3s ease;
            color: #fff;
        }
        tbody tr:hover {
            background-color: #3e3e5e;
            transform: scale(1.005);
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        th, td {
            padding: 1rem;
            vertical-align: middle;
        }
        h2 {
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
            color: #fff;
        }
        .btn-sm {
            padding: 6px 12px;
            font-size: 0.85rem;
        }
        .btn-manage {
            background-color: #8e2de2;
            color: white;
            border-radius: 20px;
            border: none;
        }
        .btn-manage:hover {
            background-color: #6a11cb;
            color: white;
        }
        .btn-action {
            background-color: #00c9ff;
            color: white;
            border: none;
            border-radius: 20px;
            transition: background-color 0.3s ease;
        }
        .btn-action:hover {
            background-color: #0096c7;
            color: white;
        }
        .add-question-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background-color: #00c9ff;
            color: white;
            font-weight: 600;
            padding: 12px 24px;
            border-radius: 30px;
            font-size: 1rem;
            margin-top: 2rem;
            box-shadow: 0 4px 12px rgba(0,201,255,0.4);
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            text-decoration: none;
        }
        .add-question-btn:hover {
            background-color: #0096c7;
            box-shadow: 0 6px 18px rgba(0,201,255,0.55);
            color: white;
        }
        footer {
            background-color: #1a1a2e;
            color: #ccc;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
            z-index: 2;
        }
        ul.option-list {
            list-style: none;
            padding-left: 0;
            margin-bottom: 0;
        }
        ul.option-list li {
            margin-bottom: 0.3rem;
        }
        ul.option-list li::before {
            content: attr(data-label) ". ";
            font-weight: 700;
            color: #00c9ff;
        }
        @media (max-width: 768px) {
            .table-container {
                padding: 1rem;
            }
            th, td {
                padding: 0.75rem 0.5rem;
                font-size: 0.9rem;
            }
            .add-question-btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* Modal Custom Styles */
        .modal-content {
            background: #2a2a3c;
            color: white;
            border-radius: 15px;
        }
        .modal-header, .modal-footer {
            border: none;
        }
        .btn-danger {
            background-color: #e63946;
            border: none;
            border-radius: 20px;
            padding: 6px 16px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .btn-danger:hover {
            background-color: #b92a39;
            color: white;
        }
        .btn-secondary.btn-action {
            background-color: #6c757d;
            color: white;
            border-radius: 20px;
            padding: 6px 16px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .btn-secondary.btn-action:hover {
            background-color: #5a6268;
            color: white;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<div class="navbar">📝 Manage Questions - ${subject.name}</div>

<!-- Main Content -->
<main>
    <div style="position: relative; margin-bottom: 2rem; color: #fff; height: 48px;">
        <h2 style="position: absolute; left: 50%; transform: translateX(-50%); margin: 0; line-height: 48px;">
            Questions List
        </h2>
        <a href="javascript:history.back()"
           class="add-question-btn"
           style="position: absolute; right: 0; top: 0; padding: 12px 24px; font-weight: 600; border-radius: 30px; font-size: 1rem; margin-bottom: 0.5rem;">
            &larr; Back
        </a>
    </div>


    <div class="table-container">
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
            <c:forEach var="question" items="${subject.questions}">
                <c:if test="${question.deleted != true}">
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
                        <a href="editQuestion?id=${question.id}" class="btn btn-sm btn-action">Edit</a>
                        <a href="#"
                           class="btn btn-sm btn-action btn-delete"
                           style="background-color:#e63946;"
                           data-delete-url="deleteQuestion?id=${question.id}&subjectId=${subject.id}">
                            Delete
                        </a>
                    </td>
                </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Add Question Button -->
    <div class="text-center">
        <a href="addQuestionPage?subjectId=${subject.id}" class="add-question-btn mt-4">
            + Add Question
        </a>
    </div>
</main>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this question?</p>
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

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const deleteButtons = document.querySelectorAll('.btn-delete');
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
        const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

        deleteButtons.forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                const url = this.getAttribute('data-delete-url');
                confirmDeleteBtn.setAttribute('href', url);
                deleteModal.show();
            });
        });
    });
</script>

</body>
</html>
