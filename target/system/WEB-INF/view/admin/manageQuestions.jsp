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

    <!-- Admin navbar stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminNavbar.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/manageQuestions.css"/>

</head>
<body>

<!-- ✅ Include the Admin Navbar -->
<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp" />

<div class="container-fluid">
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
                <select name="complexity" id="complexity" class="form-select form-select-sm text-primary" onchange="this.form.submit()">
                    <option value="" <c:if test="${empty complexity}">selected</c:if>>All</option>
                    <option value="Easy" <c:if test="${complexity == 'Easy'}">selected</c:if>>Easy</option>
                    <option value="Medium" <c:if test="${complexity == 'Medium'}">selected</c:if>>Medium</option>
                    <option value="Hard" <c:if test="${complexity == 'Hard'}">selected</c:if>>Hard</option>
                </select>
            </div>

            <div class="d-flex align-items-center gap-2">
                <label for="sortBy" class="mb-0 fw-semibold text-white">Sort by:</label>
                <select name="sortBy" id="sortBy" class="form-select form-select-sm text-primary" onchange="this.form.submit()">
                    <option value="" <c:if test="${empty sortBy}">selected</c:if>>Default</option>
                    <option value="marks" <c:if test="${sortBy == 'marks'}">selected</c:if>>Marks</option>
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
                   href="manageQuestions?subjectId=${subjectId}&complexity=${complexity}&sortBy=${sortBy}&page=${i}">${i}</a>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a class="btn btn-outline-light page-link"
                   href="manageQuestions?subjectId=${subjectId}&complexity=${complexity}&sortBy=${sortBy}&page=${currentPage + 1}">Next &raquo;</a>
            </c:if>
        </nav>
    </main>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

<!-- JS -->
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
