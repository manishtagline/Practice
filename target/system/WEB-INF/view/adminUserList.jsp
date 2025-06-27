<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Subject List - Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

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
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
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
            padding: 2rem;
        }


        table.table {
            width: 100%;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
            background-color: #5a5a5a; /* medium grey background */
            color: #f0f0f0;
            border-collapse: separate;
            border-spacing: 0;
        }

        thead th {
            background-color: #3c3c3c; /* dark grey header */
            color: #e0e0e0;
            text-transform: uppercase;
            font-size: 0.9rem;
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 2px solid #777;
        }

        tbody tr {
            background-color: #6e6e6e; /* lighter grey rows */
            transition: 0.3s ease;
            color: #fff;
        }

        tbody tr:hover {
            background-color: #8f8f8f; /* lighter on hover */
            transform: scale(1.005);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }

        tbody td {
            padding: 1rem;
            vertical-align: middle;
        }

        h2 {
            font-weight: 700;
            color: #fff;
            margin: 0;
            /* For centering */
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 0.85rem;
        }

        .btn-manage {
            background-color: #8e2de2;
            color: white;
        }

        .btn-manage:hover {
            background-color: #6a11cb;
        }

        .add-subject-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background-color: #00c9ff;
            color: white;
            font-weight: 600;
            padding: 12px 20px;
            border-radius: 30px;
            font-size: 1rem;
            margin-top: 2rem;
            box-shadow: 0 4px 12px rgba(0, 201, 255, 0.4);
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            text-decoration: none;
            position: relative; /* for stacking context */
            z-index: 1;
        }

        .add-subject-btn:hover {
            background-color: #0096c7;
            box-shadow: 0 6px 18px rgba(0, 201, 255, 0.55);
        }

        .add-subject-btn svg {
            margin-right: 8px;
            width: 20px;
            height: 20px;
            stroke: white;
        }

        footer {
            background-color: #1a1a2e;
            color: #ccc;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
            z-index: 2;
        }

        @media (max-width: 768px) {
            table.table {
                font-size: 0.9rem;
            }

            thead th, tbody td {
                padding: 0.75rem 0.5rem;
            }

            .add-subject-btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* Container for header */
        .header-row {
            position: relative;
            margin-bottom: 2rem;
            height: 48px;
        }

        /* Back button container */
        .back-btn-container {
            position: absolute;
            right: 0;
            top: 0;
            height: 100%;
            display: flex;
            align-items: center;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<div class="navbar">📚 User Details</div>

<!-- Main Content -->
<main>
    <div class="header-row">
        <h2>Information User</h2>
        <div class="back-btn-container">
            <a href="adminPage" class="add-subject-btn" style="width: auto; padding: 12px 24px; margin: 0;">
                &#8592; Back to Dashboard
            </a>
        </div>
    </div>


    <table class="table table-hover text-center align-middle">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Enrolled Subjects</th>
            <th>Total Number of Exam</th>
            <th>Average Score</th>
            <th>Highest Score</th>
            <th>Lowest Score</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.userId}</td>
                <td>${user.username}</td>
                <td>
                    <c:forEach var="subject" items="${user.enrolledSubjects}" varStatus="status">
                        ${subject}<c:if test="${!status.last}">, </c:if>
                    </c:forEach>
                </td>
                <td>${user.totalExams}</td>
                <td>
                    <c:choose>
                        <c:when test="${user.averageScore != null}">
                            <fmt:formatNumber value="${user.averageScore}" type="number" maxFractionDigits="2" />
                        </c:when>
                        <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${user.highestScore != null}">
                            ${user.highestScore}
                        </c:when>
                        <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${user.lowestScore != null}">
                            ${user.lowestScore}
                        </c:when>
                        <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>

    </table>

    <!-- Add Subject Button -->
   <%-- <div class="text-center">
        <a href="addSubjectPage" class="add-subject-btn mt-4">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <line x1="12" y1="5" x2="12" y2="19"/>
                <line x1="5" y1="12" x2="19" y2="12"/>
            </svg>
            Add User
        </a>
    </div>--%>
</main>

<!-- Footer -->
<footer>
    &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

</body>
</html>
