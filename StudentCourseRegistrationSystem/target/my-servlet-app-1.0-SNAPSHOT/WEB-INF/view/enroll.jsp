<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Students & Their Enrollments - Student Course Registration System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #2c3e50, #4ca1af);
            color: #fff;
        }

        header {
            background: rgba(0, 0, 0, 0.4);
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            border-bottom: 2px solid #00d8ff;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }

        .title {
            font-size: 36px;
            margin-bottom: 20px;
            color: #ffeb3b;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 12px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            color: #fff;
            vertical-align: top;
        }

        th {
            background: #00c9ff;
            font-weight: 600;
            letter-spacing: 0.05em;
        }

        tr:nth-child(even) {
            background: rgba(0, 0, 0, 0.15);
        }

        tr:hover {
            background: rgba(0, 201, 255, 0.3);
            cursor: default;
        }

        .btn {
            display: inline-block;
            margin-right: 6px;
            padding: 6px 12px;
            font-size: 14px;
            font-weight: 600;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn-edit {
            background-color: #4caf50;
        }

        .btn-edit:hover {
            background-color: #388e3c;
        }

        .btn-delete {
            background-color: #f44336;
        }

        .btn-delete:hover {
            background-color: #d32f2f;
        }

        .btn-view {
            background-color: #2196f3;
        }

        .btn-view:hover {
            background-color: #1976d2;
        }

        .back-link {
            display: inline-block;
            margin: 30px auto 0 auto;
            background: #00c9ff;
            padding: 12px 28px;
            border-radius: 30px;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            color: #fff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: background 0.3s ease;
            text-align: center;
        }

        .back-link:hover {
            background: #0072ff;
        }

        .no-data {
            margin-top: 30px;
            font-size: 18px;
            color: #ff6b6b;
            text-align: center;
        }
    </style>
</head>
<body>
<header>Tech Institute - Student Course Registration System</header>

<div class="container">
    <div class="title">All Students and Their Enrollments</div>

    <c:choose>
        <c:when test="${not empty students}">
            <table>
                <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Enrolled Courses</th>
                    <th>Actions</th> <!-- New Actions Column -->
                </tr>
                </thead>
                <tbody>
                <c:forEach var="student" items="${students}">
                    <tr>
                        <td><c:out value="${student.studentId}"/></td>
                        <td><c:out value="${student.studentName}"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty student.courses}">
                                    <c:forEach var="course" items="${student.courses}" varStatus="status">
                                        <c:out value="${course.title}"/>
                                        <c:if test="${!status.last}">, </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <span>No courses enrolled</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="editStudent?id=${student.studentId}" class="btn btn-edit">Edit</a>
                            <a href="deleteStudent?id=${student.studentId}" class="btn btn-delete"
                               onclick="return confirm('Are you sure you want to delete this student?');">Delete</a>
                            <a href="viewStudent?id=${student.studentId}" class="btn btn-view">View</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-data">No student data found.</div>
        </c:otherwise>
    </c:choose>

    <div style="text-align:center;">
        <a href="studentForm" class="back-link">Back to Registration</a>
    </div>
</div>
</body>
</html>
