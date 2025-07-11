<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Questions List - Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            color: #f0f0f0;
        }

        main {
            padding: 2rem 3rem;
            max-width: 1800px;
            margin: 0 auto;
        }

        .header-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .header-container h2 {
            flex: 1;
            text-align: center;
            color: #00c9ff;
            font-weight: 700;
            margin: 0;
        }

        .btn-back {
            color: #ccc;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border: 2px solid transparent;
            border-radius: 0.5rem;
            text-decoration: none;
            transition: color 0.3s ease, border-color 0.3s ease;
            white-space: nowrap;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
            user-select: none;
        }

        .btn-back:hover {
            color: #00c9ff;
            border-color: #00c9ff;
        }

        .section-divider {
            height: 2px;
            background-color: #00c9ff;
            opacity: 0.4;
            margin: 1.5rem 0;
        }

        .filter-form {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .filter-form label {
            font-weight: 600;
            color: #fff;
            margin-right: 0.5rem;
        }

        .filter-form select {
            background-color: #1a1a2e;
            border: 2px solid #00c9ff;
            color: #00c9ff;
            border-radius: 10px;
            font-weight: 600;
            padding: 0.2rem 0.5rem;
            cursor: pointer;
        }

        .table-dark th,
        .table-dark td {
            border: 1px solid #50506e;
        }

        .table-dark tbody tr {
            border-bottom: 1px solid #50506e;
        }

        .table-dark tbody tr:hover {
            background-color: #4b4b66;
        }

        .table th {
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        ul.option-list {
            list-style: none;
            padding: 0;
            margin: 0;
            text-align: left;
        }

        ul.option-list li {
            margin-bottom: 0.3rem;
            font-weight: 500;
        }

        .btn-action {
            background-color: #0a84ff;
            color: #fff;
            border-radius: 20px;
            padding: 0.3rem 0.9rem;
            border: none;
            margin: 0 4px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        .btn-action:hover {
            background-color: #006edc;
        }

        .btn-delete {
            background-color: #e63946 !important;
        }

        .btn-delete:hover {
            background-color: #b92a39 !important;
        }

        footer {
            background-color: #1a1a2e;
            text-align: center;
            padding: 1rem;
            color: #ccc;
            user-select: none;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp" />

<main>
    <!-- Header -->
    <div class="header-container">
        <h2>Questions List</h2>
        <a href="${pageContext.request.contextPath}/admin/teacherList" class="btn-back" title="Back to Faculty List">
            <i class="fas fa-arrow-left"></i> Back to Faculty List
        </a>
    </div>

    <div class="section-divider"></div>

    <!-- Filter/Sort -->
    <form method="get" action="${pageContext.request.contextPath}/admin/viewTeacherQuestions" class="filter-form">
        <input type="hidden" name="facultyId" value="${facultyId}" />

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
                <th>Subject Name</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty questions}">
                    <tr>
                        <td colspan="8" class="text-center text-warning fw-bold">
                            This teacher hasn’t added any questions yet.
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="question" items="${questions}">
                        <tr>
                            <td>${question.id}</td>
                            <td>${question.questiondDesc}</td>
                            <td>
                                <ul class="option-list">
                                    <c:set var="labels" value="${['A','B','C','D']}" />
                                    <c:forEach var="option" items="${question.options}" varStatus="status">
                                        <li><strong>${labels[status.index]}:</strong> ${option}</li>
                                    </c:forEach>
                                </ul>
                            </td>
                            <td>${question.correctAnswer}</td>
                            <td>${question.marks}</td>
                            <td>${question.complexity}</td>
                            <td>${question.subjectName}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/deleteQuestion?id=${question.id}&facultyId=${facultyId}" class="btn btn-sm btn-action btn-delete" onclick="return confirm('Are you sure to delete this question?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <div class="section-divider"></div>

    <!-- Pagination -->
    <nav class="pagination justify-content-center">
        <c:if test="${currentPage > 1}">
            <a class="btn btn-outline-light mx-1"
               href="${pageContext.request.contextPath}/admin/viewTeacherQuestions?facultyId=${facultyId}&complexity=${complexity}&sortBy=${sortBy}&page=${currentPage - 1}">&laquo; Prev</a>
        </c:if>
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a class="btn ${i == currentPage ? 'btn-light' : 'btn-outline-light'} mx-1"
               href="${pageContext.request.contextPath}/admin/viewTeacherQuestions?facultyId=${facultyId}&complexity=${complexity}&sortBy=${sortBy}&page=${i}">${i}</a>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a class="btn btn-outline-light mx-1"
               href="${pageContext.request.contextPath}/admin/viewTeacherQuestions?facultyId=${facultyId}&complexity=${complexity}&sortBy=${sortBy}&page=${currentPage + 1}">Next &raquo;</a>
        </c:if>
    </nav>
</main>

<footer>
    &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
