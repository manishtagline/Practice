<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Choose Exam - Student Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

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
            background: linear-gradient(90deg, #4a47a3, #6a67ce);
            height: 80px;
            padding: 0 2rem;
            display: flex;
            align-items: center;
            justify-content: center; /* Center all content first */
            position: relative;
            color: #fff;
        }

        /* Centered brand text */
        .navbar-brand-center {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            cursor: pointer;
            user-select: none;
            font-weight: 700;
            font-size: 1.5rem;
            letter-spacing: 1px;
            color: #fff;
            transition: color 0.3s ease;
            text-decoration: none;
        }

        .navbar-brand-center:hover,
        .navbar-brand-center:focus {
            color: #ffd700;
            outline: none;
        }

        /* Welcome badge stays on right */
        .welcome-badge {
            position: absolute;
            right: 2rem;
            font-size: 1rem;
            font-weight: 500;
            background-color: #ffd700;
            color: #4a47a3;
            padding: 6px 18px;
            border-radius: 20px;
            user-select: none;
        }

        .exam-header {
            text-align: center;
            padding: 3rem 1rem 1rem;
            color: #2c3e50;
        }

        .exam-header h1 {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .exam-header p {
            font-size: 1.2rem;
            color: #4a47a3;
        }

        .exam-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            justify-content: center;
            padding: 2rem 1rem;
            max-width: 1100px;
            margin: 0 auto;
        }

        .exam-card {
            background-color: white;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(74, 71, 163, 0.15);
            width: 300px;
            text-align: center;
            padding: 2rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: slideUp 0.6s ease forwards;
        }

        .exam-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(74, 71, 163, 0.3);
        }

        .exam-card h4 {
            font-size: 1.4rem;
            color: #4a47a3;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .exam-card p {
            font-size: 1rem;
            color: #555;
            margin-bottom: 1.5rem;
        }

        .btn-start {
            background-color: #4a47a3;
            color: #fff;
            border: none;
            border-radius: 30px;
            padding: 10px 25px;
            font-weight: 600;
            transition: background 0.3s ease;
        }

        .btn-start:hover {
            background-color: #6a67ce;
        }

        footer {
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
            background-color: rgba(255, 255, 255, 0.9);
            color: #4a47a3;
            margin-top: auto;
            box-shadow: 0 -4px 10px rgba(0, 0, 0, 0.05);
        }

        @keyframes slideUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @media (max-width: 576px) {
            .exam-header h1 { font-size: 2rem; }
            .exam-card { width: 90%; }
        }

        .username-badge {
            position: absolute;
            right: 2rem;
            top: 50%;
            transform: translateY(-50%);
            background: #ffd700;
            color: #4a47a3;
            padding: 8px 20px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 1.1rem;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
            animation: fadeInSlide 1.5s ease-out;
            user-select: none;
            letter-spacing: 0.03em;
            text-transform: capitalize;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            cursor: default;
        }

        @keyframes fadeInSlide {
            from { opacity: 0; right: -100px; }
            to { opacity: 1; right: 2rem; }
        }

        @media (max-width: 576px) {
            .username-badge {
                font-size: 1rem;
                padding: 6px 14px;
                right: 1rem;
            }
        }
    </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar" role="navigation" aria-label="Main navigation">
    <a href="home" class="navbar-brand-center" tabindex="0" aria-label="Go to Home">📘 Exam Center</a>
    <span class="username-badge" aria-label="Logged in username">
        Welcome, ${username}
    </span>
</nav>

<!-- Header -->
<section class="exam-header">
    <h1>Choose Your Exam</h1>
    <p>Select an exam to begin your test.</p>
</section>

<!-- Exam Grid -->
<section class="exam-grid">
    <c:forEach var="exam" items="${examList}">
        <div class="exam-card">
            <h4>${exam.description}</h4>
            <p>Subject: ${exam.subjectName} <br/> Total Marks: ${exam.totalMarks} <br/> Total Question : ${exam.totalNumberOfQuestion}</p>
            <form method="get" action="questionPaper">
                <input type="hidden" name="examId" value="${exam.id}" />
                <button type="submit" class="btn btn-start">Start</button>
            </form>
        </div>
    </c:forEach>
</section>

<!-- Back Button Centered -->
<div class="text-center my-4">
    <a href="home" class="btn btn-outline-light btn-sm"
       style="background-color: #4a47a3; color: white; font-weight: 600; border-radius: 30px; padding: 10px 25px;">
        ← Back to Home
    </a>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
