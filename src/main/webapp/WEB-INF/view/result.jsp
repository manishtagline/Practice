<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Your Exam Results - Student Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background: linear-gradient(90deg,#4a47a3,#6a67ce);
            height:80px; padding: 0 2rem;
            display:flex;align-items:center;justify-content:space-between;
            color:#fff;
            box-shadow:0 4px 15px rgba(74,71,163,0.6);
        }
        .navbar span.username {
            background:#ffd700;color:#4a47a3;
            padding:8px 20px;border-radius:30px;
            font-weight:600;font-size:1.1rem;
            box-shadow:0 3px 10px rgba(0,0,0,0.2);
        }
        .hero {
            padding:3rem 1rem; text-align:center; color:#2c3e50;
        }
        .hero h1 {
            font-size:2.8rem;font-weight:700;
        }
        .results-container {
            max-width:960px; margin:2rem auto; padding:0 1rem;
            display:flex; flex-direction:column; gap:1.5rem;
        }
        .result-card {
            background:white; border-radius:1rem;
            box-shadow:0 10px 30px rgba(74,71,163,0.15);
            padding:2rem; transition:transform .3s ease,box-shadow .3s ease;
        }
        .result-card:hover {
            transform:translateY(-8px);
            box-shadow:0 15px 30px rgba(74,71,163,0.3);
        }
        .result-header {
            display:flex; justify-content:space-between; align-items:center;
            margin-bottom:1rem;
        }
        .result-title {
            font-weight:600; color:#4a47a3;
            font-size:1.3rem;
        }
        .progress {
            height:1.5rem; border-radius:30px;
        }
        .progress-bar {
            font-weight:600;
            line-height:1.5rem;
        }
        footer {
            text-align:center; padding:1rem;
            background:rgba(255,255,255,0.9); color:#4a47a3;
            box-shadow:0 -4px 10px rgba(0,0,0,0.05);
            margin-top:auto;
        }
        @media(max-width:576px){
            .hero h1{font-size:2rem;}
            .result-header{flex-direction:column;align-items:flex-start;gap:0.5rem;}
        }
    </style>
</head>

<body>
<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-brand" onclick="location.href='home.jsp'" style="cursor:pointer;font-size:1.8rem;font-weight:700;user-select:none;">
        Exam Center
    </div>
    <span class="username">Welcome, ${username}</span>
</nav>

<!-- Hero -->
<section class="hero">
    <h1>Your Exam History</h1>
    <p>Review your performance below</p>
</section>

<!-- Results List -->
<section class="results-container">
    <c:if test="${not empty resultList}">
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <c:forEach var="res" items="${resultList}">
                <div class="col">
                    <a href="examResultDetails?resultId=${res.id}" style="text-decoration:none; color:inherit;">
                        <div class="result-card h-100">
                            <div class="result-header">
                                <div class="result-title">
                                        ${res.exam.description}
                                </div>
                                <div class="result-date">
                                    Exam ID: #${res.exam.id}
                                </div>
                            </div>
                            <div>
                                <strong>Score:</strong> ${res.totalScore} / ${res.exam.totalMarks}
                                <br/>
                                <strong>Percentage:</strong>
                                <fmt:formatNumber value="${res.percentage}" maxFractionDigits="2"/>%
                            </div>
                            <div class="progress mt-3">
                                <div class="progress-bar bg-success"
                                     role="progressbar"
                                     style="width:${res.percentage}%"
                                     aria-valuenow="${res.percentage}"
                                     aria-valuemin="0" aria-valuemax="100">
                                    <fmt:formatNumber value="${res.percentage}" maxFractionDigits="1"/>%
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <!-- Back Button -->
    <div class="mb-3 text-start">
        <a href="home" class="btn btn-outline-light btn-sm" style="background-color: #4a47a3; color: white; font-weight: 600; border-radius: 30px;">
            ← Back to Home
        </a>
    </div>


    <c:if test="${empty resultList}">
        <div class="alert alert-info text-center">
            You haven’t taken any exams yet. Try <a href="exam">starting one now</a>!
        </div>
    </c:if>
</section>

<!-- Footer -->
<footer>&copy; 2025 Student Exam Center. All rights reserved.</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
