<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Subjects - Teacher Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

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
            padding: 2rem 1rem;
            max-width: 1000px;
            margin: auto;
        }

        .header-container {
            display: flex;
            align-items: center;
            justify-content: space-between; /* space between left, center, right */
            margin-bottom: 2rem;
            border-bottom: 2px solid rgba(0,201,255,0.25);
            padding-bottom: 0.5rem;
            position: relative;
        }

        .header-container h2 {
            font-weight: 600;
            font-size: 2.2rem;
            color: #00c9ff;
            margin: 0;
            text-align: center;
            flex: 1;
        }

        /* back button style remains same but remove absolute */
        a.btn-back {
            position: static; /* remove absolute */
            color: #ccc;
            font-weight: 600;
            padding: 0.4rem 1rem;
            border: 2px solid transparent;
            border-radius: 0.5rem;
            text-decoration: none;
            transition: color 0.3s ease, border-color 0.3s ease;
            white-space: nowrap;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }
        a.btn-back:hover {
            color: #00c9ff;
            border-color: #00c9ff;
            text-decoration: none;
        }
        a.btn-back i {
            font-size: 1.1rem;
        }

        .subject-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 1.5rem;
        }

        .subject-card {
            background: rgba(60, 60, 60, 0.9);
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.4);
            transition: 0.3s;
        }

        .subject-card:hover {
            transform: translateY(-6px);
            background-color: rgba(80, 80, 80, 0.95);
        }

        .subject-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: #00c9ff;
            margin-bottom: 0.8rem;
        }

        .subject-detail {
            font-size: 0.95rem;
            color: #ccc;
            margin-bottom: 0.4rem;
        }

        .subject-detail i {
            color: #00c9ff;
            margin-right: 8px;
        }

        .no-subjects {
            text-align: center;
            font-size: 1.2rem;
            margin-top: 3rem;
            color: #ddd;
            font-style: italic;
        }

        footer {
            background-color: #1a1a2e;
            color: #aaa;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
        }

    </style>
</head>
<body>

<jsp:include page="/WEB-INF/view/navbar/teacherNavbar.jsp"/>

<main>
    <div class="header-container">
        <div style="width: 140px;"></div> <!-- left spacer -->
        <h2>My Assigned Subjects</h2>
        <a href="teacherDashboard" class="btn-back" title="Back to Dashboard">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
    
    <c:choose>
        <c:when test="${not empty subjects}">
            <div class="subject-grid">
                <c:forEach var="subject" items="${subjects}">
                    <div class="subject-card">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div class="subject-title">Assign Subject: ${subject.name}</div>
                            <a href="${pageContext.request.contextPath}/teacher/viewQuestions?subjectId=${subject.id}"
                               class="btn btn-sm btn-outline-info" title="View Questions">
                                <i class="fas fa-eye"></i> View Questions
                            </a>
                        </div>
                        <div class="subject-detail mt-2">
                            <i class="fas fa-book-open"></i> Total Question: ${subject.questionCount}
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <p class="no-subjects">📚 You don't have any assigned subjects at the moment.</p>
        </c:otherwise>
    </c:choose>
</main>

<footer>
    &copy; 2025 Teacher Panel | Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
