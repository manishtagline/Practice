<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>My Subjects - Teacher Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

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
            padding: 2rem 1.5rem;
            max-width: 1000px;
            margin: auto;
        }

        .header-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
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

        a.btn-back {
            position: static;
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
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 2rem;
        }

        .subject-card {
            background: rgba(60, 60, 60, 0.9);
            padding: 1.8rem 2rem;
            border-radius: 14px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.4);
            transition: 0.3s;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 210px;
        }

        .subject-card:hover {
            transform: translateY(-6px);
            background-color: rgba(80, 80, 80, 0.95);
        }

        .subject-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #00c9ff;
            margin-bottom: 1.2rem;
        }

        .subject-detail {
            font-size: 1.1rem;
            color: #ccc;
            margin-bottom: 1.8rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .subject-detail i {
            color: #00c9ff;
            font-size: 1.3rem;
        }

        /* Big wide View Questions button */
        .btn-view-questions {
            background-color: #00c9ff;
            color: #fff !important;
            font-weight: 600;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            text-align: center;
            text-decoration: none;
            font-size: 1.1rem;
            letter-spacing: 0.03em;
            box-shadow: 0 5px 14px rgba(0,201,255,0.6);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            user-select: none;
            display: block;
            width: 100%;
            line-height: 1.3;
        }
        .btn-view-questions:hover,
        .btn-view-questions:focus {
            background-color: #008dbf;
            box-shadow: 0 6px 18px rgba(0,141,191,0.85);
            color: #fff !important;
            text-decoration: none;
            outline: none;
        }

        .btn-view-questions i {
            margin-right: 0.6rem;
            font-size: 1.2rem;
        }

        .no-subjects {
            text-align: center;
            font-size: 1.3rem;
            margin-top: 3.5rem;
            color: #ddd;
            font-style: italic;
            user-select: none;
        }

        footer {
            background-color: #1a1a2e;
            color: #aaa;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
            user-select: none;
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
                        <div class="card-top">
                            <div class="subject-title">${subject.name}</div>
                            <div class="subject-detail">
                                <i class="fas fa-book-open"></i> Total Questions: ${subject.questionCount}
                            </div>
                        </div>

                        <div class="card-buttons d-flex justify-content-between gap-2 mt-3">
                            <a href="${pageContext.request.contextPath}/teacher/viewQuestions?subjectId=${subject.id}"
                               class="btn-view-questions" title="View Questions for ${subject.name}" style="flex: 1;">
                                <i class="fas fa-eye"></i> View Questions
                            </a>

                            <a href="${pageContext.request.contextPath}/teacher/addQuestionPage?subjectId=${subject.id}"
                               class="btn-view-questions" title="Add Question for ${subject.name}" style="flex: 1; background-color: #28a745; box-shadow: 0 5px 14px rgba(40,167,69,0.6);">
                                <i class="fas fa-plus-circle"></i> Add Question
                            </a>
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
