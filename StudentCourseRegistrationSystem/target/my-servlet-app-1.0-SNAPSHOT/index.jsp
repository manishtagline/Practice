<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Course Registration System</title>
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
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 90vh;
            text-align: center;
        }

        .title {
            font-size: 48px;
            margin-bottom: 10px;
        }

        .tagline {
            font-size: 20px;
            margin-bottom: 30px;
            font-style: italic;
            color: #ffeb3b;
        }

        .description {
            max-width: 600px;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        .start-link {
            display: inline-block;
            background: #00c9ff;
            padding: 15px 30px;
            border-radius: 30px;
            font-size: 18px;
            font-weight: bold;
            text-decoration: none;
            color: #fff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: background 0.3s ease;
        }

        .start-link:hover {
            background: #0072ff;
        }

        .illustration {
            width: 200px;
            height: auto;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<header>Tech Institute - Empowering Education</header>

<div class="container">
    <div class="container">
        <img class="illustration" src="https://img.icons8.com/clouds/200/student-male.png" alt="Student Graphic"/>
        <div class="title">Student Course Registration System</div>
        <div class="tagline">“Build your future, one course at a time.”</div>
        <div class="description">
            Welcome to our student registration portal. This platform allows students to register themselves, enroll in multiple courses,
            and view their enrolled course list in real-time. Backed by a modern Spring MVC + Hibernate architecture, your data is secure and persistent.
        </div>

        <div style="display: flex; gap: 20px; justify-content: center;">
            <a href="studentForm" class="start-link">Get Started</a>
            <a href="studentList" class="start-link" style="background:#ff6b6b;">Check Enrolled Students</a>
        </div>
    </div>
</div>
</body>
</html>
