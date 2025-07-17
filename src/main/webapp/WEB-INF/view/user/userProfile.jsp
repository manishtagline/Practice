<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>User Profile - Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

    <style>
        html, body {
            height: 100%;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            color: #f0f0f0;
            display: flex;
            flex-direction: column;
        }

        main {
            flex: 1;
            padding: 2rem 3rem;
            max-width: 1400px;
            margin: 0 auto;
            box-sizing: border-box;
        }

        .profile-header {
            background: rgba(0, 201, 255, 0.12);
            border: 1px solid #00c9ff50;
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 0 25px rgba(0, 201, 255, 0.2);
            text-align: center;
            margin-bottom: 3rem;
            position: relative;
        }

        .profile-header h1 {
            font-weight: 700;
            font-size: 2.7rem;
            color: #00c9ff;
            margin-bottom: 0.5rem;
        }

        .profile-header p {
            font-size: 1.1rem;
            margin: 0.25rem 0;
            color: #ddd;
        }

        .profile-header::after {
            content: '';
            position: absolute;
            bottom: -12px;
            left: 50%;
            transform: translateX(-50%);
            height: 4px;
            width: 200px;
            background: linear-gradient(to right, #00c9ff, transparent);
            border-radius: 5px;
            opacity: 0.5;
        }

        .section-title {
            color: #00c9ff;
            font-size: 1.7rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            border-bottom: 2px dashed #00c9ff66;
            padding-bottom: 0.3rem;
        }

        .stats-wrapper {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .stats-card {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            background: rgba(47, 47, 47, 0.9);
            border-radius: 1rem;
            border: 1px solid #00c9ff33;
            padding: 2rem;
            box-shadow: 0 12px 30px rgba(0, 201, 255, 0.1);
            position: relative;
            transition: all 0.3s ease-in-out;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 201, 255, 0.3);
        }

        .stats-card h3 {
            color: #00c9ff;
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 1rem;
            width: 100%;
        }

        .stat-item {
            font-size: 1.1rem;
            margin: 0.3rem 1rem 0.3rem 0;
            font-weight: 500;
            position: relative;
            padding-left: 32px;
            flex: 1 1 30%;
        }

        .stat-item strong {
            color: #00c9ff;
        }

        .stat-item i {
            position: absolute;
            left: 0;
            top: 2px;
            color: #00c9ff;
            font-size: 1.2rem;
        }

        footer {
            background-color: #1a1a2e;
            color: #aaa;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
            user-select: none;
        }

        @media(max-width: 768px) {
            .stats-card {
                flex-direction: column;
            }

            .stat-item {
                flex: 1 1 100%;
                margin-bottom: 0.6rem;
            }
        }
    </style>
</head>
<body>

<!-- Include Navbar -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp"/>

<main>
    <!-- Profile Header -->
    <section class="profile-header" aria-label="User Profile Information">
        <h1>${user.username}</h1>
        <p><i class="fas fa-envelope"></i> ${user.email}</p>
        <p><strong>Role:</strong> ${user.role}</p>
        <p><strong>Time Zone:</strong> ${user.zoneId}</p>
    </section>

    <!-- User Stats or Summary Section -->
    <section aria-label="User Exam Statistics or Summary">
        <h2 class="section-title d-flex justify-content-center">Your Exam Summary</h2>

        <div class="stats-wrapper">
            <c:choose>
                <c:when test="${not empty examStats}">
                    <div class="stats-card" role="region" aria-labelledby="exam-summary-title">
                        <h3 id="exam-summary-title">Exams Overview</h3>
                        <div class="stat-item"><i class="fas fa-file-alt"></i><strong> Total Exams Enrolled:</strong> ${examStats.enrolledCount}</div>
                        <div class="stat-item"><i class="fas fa-check-circle"></i><strong> Exams Completed:</strong> ${examStats.completedCount}</div>
                        <div class="stat-item"><i class="fas fa-clock"></i><strong> Pending Exams:</strong> ${examStats.pendingCount}</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-center text-muted fs-5">
                        You currently have no exam statistics to display.
                    </p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</main>

<footer>
    &copy; 2025 Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
