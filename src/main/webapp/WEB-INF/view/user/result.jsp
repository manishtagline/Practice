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
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #f0f0f0;
        }

        main {
            flex: 1;
            padding: 2rem;
            width: 100%;
        }

        /* Page Header */
        .page-header {
            position: relative;
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-header h2 {
            color: #00c9ff;
            text-shadow: 0 0 10px #00c9ff88;
            font-size: 2rem;
            margin: 0 auto 0.5rem;
        }

        .back-btn {
            position: absolute;
            top: 0;
            right: 0;
            background-color: transparent;
            border: 2px solid #00c9ff;
            color: #00c9ff;
            padding: 0.4rem 1rem;
            border-radius: 30px;
            font-weight: 500;
            transition: 0.3s ease;
            text-decoration: none;
        }

        .back-btn:hover {
            background-color: #00c9ff;
            color: #fff;
            text-decoration: none;
        }

        /* Section Divider */
        .section-divider {
            height: 3px;
            background-color: #00c9ff;
            width: 100%;
            border-radius: 4px;
            margin: 1rem 0 2rem;
            box-shadow: 0 0 10px #00c9ff99;
        }

        /* Exam Grid */
        .exam-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 2rem;
        }

        .exam-card {
            background: #3c3c3c;
            border-radius: 1rem;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
            width: 300px;
            padding: 2rem;
            color: #e0e0e0;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 320px;
            text-align: left;
        }

        .exam-card h4 {
            font-size: 1.6rem;
            font-weight: 700;
            color: #00c9ff;
            margin-bottom: 1rem;
            text-align: center;
        }

        .exam-info p {
            margin: 0.2rem 0;
            font-size: 1rem;
        }

        .progress {
            height: 1.6rem;
            border-radius: 30px;
            background-color: rgba(255, 255, 255, 0.15);
            box-shadow: inset 0 1px 3px rgba(255, 255, 255, 0.2);
            margin: 1rem 0;
        }

        .progress-bar {
            font-weight: 600;
            line-height: 1.6rem;
            background: linear-gradient(90deg, #00c9ff, #0096c7);
            box-shadow: 0 0 10px #00c9ff99;
            text-align: center;
            color: white;
        }

        .view-details-btn {
            align-self: center;
            background-color: transparent;
            border: 2px solid #00c9ff;
            color: #00c9ff;
            padding: 0.5rem 1.5rem;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .view-details-btn:hover {
            background-color: #00c9ff;
            color: #fff;
        }

        .alert-info {
            background-color: rgba(255, 255, 255, 0.15);
            color: #00c9ff;
            font-weight: 600;
            border: none;
            text-align: center;
            box-shadow: 0 8px 24px rgba(0, 201, 255, 0.3);
            padding: 1rem;
            max-width: 600px;
            margin: 2rem auto;
        }

        footer {
            background-color: #1a1a2e;
            color: #ccc;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
        }

        @media (max-width: 576px) {
            .page-header {
                text-align: left;
            }

            .back-btn {
                position: static;
                margin-top: 0.5rem;
                display: inline-block;
            }

            .page-header h2 {
                font-size: 1.5rem;
                text-align: center;
            }

            .exam-card {
                width: 90%;
            }

            .progress {
                height: 1.2rem;
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>

<!-- Include user navbar -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp" />

<main>

    <!-- Page Header and Back Button -->
    <div class="page-header">
        <h2>Your Exam History</h2>
        <a href="${pageContext.request.contextPath}/home" class="back-btn">← Back to Dashboard</a>
    </div>

    <!-- Section Divider -->
    <div class="section-divider"></div>

    <!-- Exam Cards -->
    <section class="exam-grid">
        <c:if test="${not empty resultList}">
            <c:forEach var="res" items="${resultList}">
                <div class="exam-card">
                    <h4>${res.exam.description}</h4>

                    <div class="exam-info">
                        <p><strong>Exam ID:</strong> #${res.exam.id}</p>
                        <p><strong>Score:</strong> ${res.totalScore} / ${res.exam.totalMarks}</p>
<%--                        <p><strong>Percentage:</strong> <fmt:formatNumber value="${res.percentage}" maxFractionDigits="2"/>%</p>--%>
                    </div>

                    <div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="${res.percentage}">
                        <div class="progress-bar" style="width: ${res.percentage}%; padding-right: 10px; padding-left: 10px;">
                            <fmt:formatNumber value="${res.percentage}" maxFractionDigits="1"/>%
                        </div>
                    </div>

                    <button class="view-details-btn"
                            onclick="window.location.href='${pageContext.request.contextPath}/examResultDetails?resultId=${res.id}'">
                        View Exam Details
                    </button>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${empty resultList}">
            <div class="alert alert-info">
                You haven’t taken any exams yet. Try
                <a href="${pageContext.request.contextPath}/exam" style="color:#00c9ff; text-decoration: underline;">starting one now</a>!
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
