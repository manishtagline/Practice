<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Questions List - Teacher Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/teacherPageCss/viewQuestions.css"/>

</head>
<body>

<jsp:include page="/WEB-INF/view/navbar/teacherNavbar.jsp" />

<main>
    <!-- Header -->
    <div class="header-container">
        <h2>Questions List: ${subject.name}</h2>

        <!-- Right-aligned back button -->
        <a href="${pageContext.request.contextPath}/teacher/teacherSubject" class="btn-back" title="Back to My Subjects">
            <i class="fas fa-arrow-left"></i> Back to My Subjects
        </a>
    </div>

    <!-- Line below title -->
    <div class="section-divider"></div>

    <!-- Filter/Sort -->
    <form method="get" action="viewQuestions" class="filter-form">
        <input type="hidden" name="subjectId" value="${subjectId}" />

        <div class="d-flex align-items-center">
            <label for="complexity">Filter by Complexity:</label>
            <select name="complexity" id="complexity" onchange="this.form.submit()">
                <option value="" <c:if test="${empty complexity}">selected</c:if>>All</option>
                <option value="Easy" <c:if test="${complexity == 'Easy'}">selected</c:if>>Easy</option>
                <option value="Medium" <c:if test="${complexity == 'Medium'}">selected</c:if>>Medium</option>
                <option value="Hard" <c:if test="${complexity == 'Hard'}">selected</c:if>>Hard</option>
            </select>
        </div>

        <div class="d-flex align-items-center">
            <label for="sortBy">Sort by:</label>
            <select name="sortBy" id="sortBy" onchange="this.form.submit()">
                <option value="" <c:if test="${empty sortBy}">selected</c:if>>Default</option>
                <option value="marks" <c:if test="${sortBy == 'marks'}">selected</c:if>>Marks</option>
            </select>
        </div>
    </form>

    <!-- Question Table -->
    <div class="table-responsive">
        <table class="table table-hover table-dark text-center align-middle">
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
                            <a href="editQuestion?questionId=${question.id}" class="btn btn-sm btn-action">Edit</a>
                                <%--<a href="deleteQuestion?id=${question.id}&subjectId=${subjectId}" class="btn btn-sm btn-action btn-delete">Delete</a>--%>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Line above pagination -->
    <div class="section-divider"></div>

    <!-- Pagination -->
    <nav class="pagination justify-content-center">
        <c:if test="${currentPage > 1}">
            <a class="btn btn-outline-light mx-1"
               href="viewQuestions?subjectId=${subjectId}&complexity=${complexity}&sortBy=${sortBy}&page=${currentPage - 1}">&laquo; Prev</a>
        </c:if>
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a class="btn ${i == currentPage ? 'btn-light' : 'btn-outline-light'} mx-1"
               href="viewQuestions?subjectId=${subjectId}&complexity=${complexity}&sortBy=${sortBy}&page=${i}">${i}</a>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a class="btn btn-outline-light mx-1"
               href="viewQuestions?subjectId=${subjectId}&complexity=${complexity}&sortBy=${sortBy}&page=${currentPage + 1}">Next &raquo;</a>
        </c:if>
    </nav>
</main>

<footer>
    &copy; 2025 Teacher Panel | Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
