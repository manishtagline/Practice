<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Choose Exam - Student Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            margin: 0;
            min-height: 100vh;
            color: #f0f0f0;
            display: flex;
            flex-direction: column;
        }

        main {
            flex: 1;
            padding: 2rem 1rem 4rem;
            position: relative;
        }

        /* Back button fixed top-right */
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

        .exam-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .exam-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #00c9ff;
            text-shadow: 0 0 10px #00c9ff88;
        }

        .separator {
            height: 2px;
            background-color: #00c9ff;
            margin: 2rem auto;
            width: 100%;
        }

        .exam-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            justify-content: center;
            padding: 1rem;
        }

        .exam-card {
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 1rem;
            padding: 2rem;
            width: 350px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

        .exam-card:hover {
            transform: translateY(-8px);
            background-color: rgba(255, 255, 255, 0.08);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
        }

        .exam-title {
            font-size: 1.6rem;
            font-weight: 600;
            color: #00c9ff;
            margin-bottom: 1rem;
            text-align: center;
        }

        .exam-details {
            font-size: 1rem;
            color: #e0e0e0;
            margin-bottom: 1.5rem;
        }

        .exam-details div {
            margin-bottom: 8px;
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            padding-bottom: 4px;
        }

        .exam-details div span:first-child {
            font-weight: 500;
            color: #ccc;
            min-width: 130px; /* Fixed width for label alignment */
            display: inline-block;
        }

        .exam-details div span:last-child {
            color: #fff;
            font-weight: 600;
            white-space: nowrap;
        }

        /* Special styling for Enrollment with two lines */
        .enrollment-values {
            display: flex;
            flex-direction: column;
            white-space: nowrap;
        }
        .enrollment-values span {
            padding-left: 10px; /* indent second date */
        }
        .enrollment-label {
            font-weight: 500;
            color: #ccc;
            min-width: 130px; /* same width as other labels */
            display: inline-block;
            vertical-align: top;
        }

        .btn-start {
            background-color: #00c9ff;
            color: white;
            border: none;
            border-radius: 30px;
            padding: 10px 25px;
            font-weight: 600;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        .btn-start:hover {
            background-color: #0096c7;
        }

        footer {
            background-color: #1a1a2e;
            color: #ccc;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
            margin-top: auto;
        }

        @media (max-width: 576px) {
            .exam-card {
                width: 90%;
            }

            .exam-header h1 {
                font-size: 2rem;
            }

            .top-right-back-btn a {
                padding: 8px 20px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>

<body>

<!-- Navbar -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp"/>

<main>
    <!-- Back Button Top Right -->
    <div class="top-right-back-btn">
        <a href="${pageContext.request.contextPath}/home">← Back to Home</a>
    </div>

    <!-- Header -->
    <div class="exam-header">
        <h1>Choose Your Exam</h1>
    </div>

    <!-- Separator Line -->
    <div class="separator"></div>

    <p class="d-flex justify-content-center">Select an exam to begin your enrollment.</p>

    <!-- Toast for success/error messages -->
    <c:if test="${not empty toastMessage}">
        <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 9999">
            <div id="toastMessage" class="toast align-items-center text-bg-${toastType} border-0 show" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                            ${toastMessage}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const toastEl = document.getElementById('toastMessage');
                if (toastEl) {
                    new bootstrap.Toast(toastEl).show();
                }
            });
        </script>
    </c:if>

    <!-- Exam Grid -->
    <section class="exam-grid">
        <c:forEach var="exam" items="${examList}">
            <div class="exam-card">
                <div class="exam-title">${exam.description}</div>
                <div class="exam-details">
                    <div><span>Subject:</span> <span>${exam.subjectName}</span></div>
                    <div><span>Total Marks:</span> <span>${exam.totalMarks}</span></div>
                    <div><span>Total Questions:</span> <span>${exam.totalNumberOfQuestion}</span></div>
                    <c:if test="${not empty exam.formattedEnrolledStartDate && not empty exam.formattedEnrolledEndDate}">
                        <div>
                            <span class="enrollment-label">Enrollment:</span>
                            <span class="enrollment-values">
                                <span>${exam.formattedEnrolledStartDate}</span>
                                <span>${exam.formattedEnrolledEndDate}</span>
                            </span>
                        </div>
                    </c:if>
                </div>
                <form method="get" action="enrollUser">
                    <input type="hidden" name="examId" value="${exam.id}" />
                    <button type="submit" class="btn btn-start">Enroll</button>
                </form>
            </div>
        </c:forEach>
    </section>
</main>

<!-- Footer -->
<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

</body>
</html>
