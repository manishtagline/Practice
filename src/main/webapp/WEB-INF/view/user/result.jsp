<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Your Exam Results - Student Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <style>
        /* Global */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1f1c2c 0%, #928dab 100%);
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #f0f0f0;
        }

        main {
            flex: 1;
            padding: 3rem 1rem 4rem;
            max-width: 1100px;
            margin: 0 auto;
            position: relative;
        }

        /* Back Button fixed top-right */
        .top-right-back-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }
        .top-right-back-btn a {
            background-color: #00c9ff;
            color: white;
            font-weight: 600;
            padding: 10px 25px;
            border-radius: 30px;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(0, 201, 255, 0.4);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            display: inline-block;
        }
        .top-right-back-btn a:hover {
            background-color: #0096c7;
            box-shadow: 0 6px 18px rgba(0, 201, 255, 0.55);
        }

        /* Header */
        .exam-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .exam-header h1 {
            font-size: 2.8rem;
            font-weight: 700;
            color: #00c9ff;
            text-shadow: 0 0 10px #00c9ff88;
        }
        .exam-header p {
            font-size: 1.2rem;
            color: #d0d0d0;
        }

        /* Exam Grid */
        .exam-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            justify-content: center;
        }

        /* Exam Card */
        .exam-card {
            background: rgba(255, 255, 255, 0.08);
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            width: 300px;
            text-align: center;
            padding: 2rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            color: #e0e0e0;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 260px;
        }
        .exam-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 201, 255, 0.7);
            color: #00c9ff;
            text-decoration: none;
        }

        .exam-card h4 {
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #00c9ff;
            text-shadow: 0 0 6px #00c9ffbb;
        }

        .exam-card p {
            flex-grow: 1;
            font-size: 1rem;
            line-height: 1.4;
        }

        /* Progress Bar */
        .progress {
            height: 1.6rem;
            border-radius: 30px;
            background-color: rgba(255,255,255,0.15);
            margin-top: 1.5rem;
            box-shadow: inset 0 1px 3px rgba(255,255,255,0.2);
        }
        .progress-bar {
            font-weight: 600;
            line-height: 1.6rem;
            background: linear-gradient(90deg, #00c9ff, #0096c7);
            box-shadow: 0 0 10px #00c9ff99;
        }

        /* Alert when no results */
        .alert-info {
            max-width: 600px;
            margin: 2rem auto;
            background-color: rgba(255, 255, 255, 0.15);
            color: #00c9ff;
            border: none;
            font-weight: 600;
            box-shadow: 0 8px 24px rgba(0, 201, 255, 0.3);
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
            background-color: rgba(31, 28, 44, 0.8);
            color: #00c9ff;
            margin-top: auto;
            box-shadow: 0 -4px 10px rgba(0, 0, 0, 0.15);
        }

        /* Responsive */
        @media (max-width: 576px) {
            main {
                padding: 2rem 1rem 3rem;
            }
            .exam-header h1 {
                font-size: 2rem;
            }
            .exam-card {
                width: 90%;
                min-height: auto;
            }
            .top-right-back-btn a {
                padding: 8px 20px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>

<!-- Include your existing user navbar -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp" />

<main>
    <!-- Back Button Top Right -->
    <div class="top-right-back-btn">
        <a href="${pageContext.request.contextPath}/home">← Back to Home</a>
    </div>

    <!-- Header -->
    <section class="exam-header">
        <h1>Your Exam History</h1>
        <p>Review your performance below</p>
    </section>

    <!-- Exam Results Grid -->
    <section class="exam-grid">
        <c:if test="${not empty resultList}">
            <c:forEach var="res" items="${resultList}">
                <a href="${pageContext.request.contextPath}/examResultDetails?resultId=${res.id}" class="exam-card">
                    <h4>${res.exam.description}</h4>
                    <p>
                        Exam ID: #${res.exam.id}<br/>
                        <strong>Score:</strong> ${res.totalScore} / ${res.exam.totalMarks}<br/>
                        <strong>Percentage:</strong>
                        <fmt:formatNumber value="${res.percentage}" maxFractionDigits="2"/>%
                    </p>
                    <div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="${res.percentage}">
                        <div class="progress-bar" style="width: ${res.percentage}%;">
                            <fmt:formatNumber value="${res.percentage}" maxFractionDigits="1"/>%
                        </div>
                    </div>
                </a>
            </c:forEach>
        </c:if>

        <c:if test="${empty resultList}">
            <div class="alert alert-info text-center" role="alert">
                You haven’t taken any exams yet. Try <a href="${pageContext.request.contextPath}/exam" style="color:#00c9ff; text-decoration: underline;">starting one now</a>!
            </div>
        </c:if>
    </section>
</main>

<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
