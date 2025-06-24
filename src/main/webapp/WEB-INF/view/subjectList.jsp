<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subject List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4 text-center">📚 Subject Management</h2>
    <table class="table table-striped table-bordered text-center align-middle">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Total Questions</th>
            <th>Total Exams</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="subject" items="${subjects}">
            <tr>
                <td>${subject.id}</td>
                <td>${subject.name}</td>
                <td>${subject.questionCount}</td>
                <td>${subject.examCount}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
