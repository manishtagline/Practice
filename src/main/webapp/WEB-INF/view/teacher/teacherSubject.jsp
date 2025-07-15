<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Subjects - Teacher Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

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
            padding: 0 3rem 2rem;
            width: 100%;
            box-sizing: border-box;
            position: relative;
        }

        .header-container {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between; /* space left summary and right back */
            padding: 1rem 0;
            margin-top: 0.5rem;
            border-bottom: 2px solid rgba(0,201,255,0.25);
            background: transparent;
            min-height: 70px;
            box-shadow: none;
            gap: 1rem;
        }

        /* Left summary bar */
        .summary-bar {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
            background: rgba(0, 201, 255, 0.15);
            border: 1px solid #00c9ff33;
            padding: 0.7rem 1rem;
            border-radius: 10px;
            flex-shrink: 0;
        }

        .summary-item {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            font-weight: 600;
            color: #00c9ff;
        }

        .summary-item i {
            font-size: 1.2rem;
        }

        .summary-item div {
            display: flex;
            flex-direction: column;
            line-height: 1;
        }

        .summary-item div div:first-child {
            font-size: 1.2rem;
        }

        .summary-item div div:last-child {
            font-size: 0.7rem;
            opacity: 0.7;
            white-space: nowrap;
        }

        /* Center title */
        .header-container h2 {
            flex-grow: 1;
            text-align: center;
            color: #00c9ff;
            font-weight: 600;
            font-size: 2rem;
            margin: 0;
            user-select: none;
            z-index: 20;
        }

        /* Back button on right */
        a.btn-back {
            flex-shrink: 0;
            color: #ccc;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border: 2px solid transparent;
            border-radius: 0.5rem;
            text-decoration: none;
            transition: color 0.3s ease, border-color 0.3s ease;
            white-space: nowrap;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
            user-select: none;
        }

        a.btn-back:hover {
            color: #00c9ff;
            border-color: #00c9ff;
        }

        /* Toast container positioned above back button */
        .custom-toast-wrapper {
            position: absolute;
            top: -80px; /* above header-container */
            right: 1rem;
            z-index: 9999;
            width: 320px;
        }

        /* Toast styling and animation */
        .toast {
            background: linear-gradient(135deg, #00c9ff, #005f99);
            color: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,201,255,0.6);
            font-weight: 600;
            font-size: 1rem;
            padding: 1rem 1.5rem;
            opacity: 0;
            transform: translateY(-20px);
            animation-fill-mode: forwards;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .toast.show {
            animation: fadeInDown 0.5s forwards;
        }

        .toast.fade-out {
            animation: fadeOutUp 0.5s forwards;
        }

        .toast .btn-close {
            filter: brightness(0.8);
            transition: filter 0.3s ease;
        }

        .toast .btn-close:hover {
            filter: brightness(1.2);
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeOutUp {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(-20px);
            }
        }

        .subject-grid {
            margin-top: 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
        }

        /* When only one subject, show card with half width */
        .subject-grid.one-subject {
            grid-template-columns: repeat(auto-fit, minmax(350px, 50%));
            justify-content: center;
        }

        .subject-card {
            position: relative;
            background: #2f2f2f;
            padding: 2rem;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            border: 1px solid #00c9ff33;
            z-index: 1;
        }

        .subject-card::before,
        .subject-card::after {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            top: -50%;
            left: -50%;
            background-image:
                    linear-gradient(135deg, rgba(0,201,255,0.07) 1px, transparent 1px),
                    linear-gradient(45deg, rgba(0,201,255,0.07) 1px, transparent 1px);
            background-size: 60px 60px;
            z-index: 0;
            pointer-events: none;
            opacity: 0.4;
        }

        .subject-title,
        .subject-detail,
        .button-group {
            position: relative;
            z-index: 2;
        }

        .subject-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #00c9ff;
            margin-bottom: 1rem;
        }

        .subject-detail {
            font-size: 1rem;
            color: #ccc;
            margin-bottom: 1.2rem;
            display: flex;
            align-items: center;
            border-bottom: 1px solid rgba(0, 201, 255, 0.2);
            padding-bottom: 0.6rem;
        }

        .subject-detail i {
            color: #00c9ff;
            margin-right: 10px;
        }

        .button-group {
            margin-top: 1.2rem;
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .button-group a.btn {
            font-size: 0.95rem;
            padding: 0.5rem 1.2rem;
            font-weight: 600;
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

    <c:set var="totalQuestions" value="0" />
    <c:forEach var="subject" items="${subjects}">
        <c:set var="totalQuestions" value="${totalQuestions + subject.questionCount}" />
    </c:forEach>

    <div class="header-container">

        <div class="summary-bar">
            <div class="summary-item">
                <i class="fas fa-layer-group"></i>
                <div>
                    <div>${fn:length(subjects)}</div>
                    <div>Subjects</div>
                </div>
            </div>
            <div class="summary-item">
                <i class="fas fa-book-open"></i>
                <div>
                    <div>${totalQuestions}</div>
                    <div>Questions</div>
                </div>
            </div>
            <div class="summary-item">
                <i class="fas fa-pen"></i>
                <div>
                    <div>${totalQuestionss}</div>
                    <div>Questions Added</div>
                </div>
            </div>
        </div>

        <h2 class="d-flex justify-content-center">My Assigned Subjects</h2>

        <a href="teacherDashboard" class="btn-back" title="Back to Dashboard">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>

        <c:if test="${not empty successToast}">
            <div class="custom-toast-wrapper" id="toastWrapper">
                <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true" id="successToast">
                    <div>${successToast}</div>
                    <button type="button" class="btn-close btn-close-white" aria-label="Close" id="toastCloseBtn"></button>
                </div>
            </div>
        </c:if>

    </div>

    <c:choose>
        <c:when test="${not empty subjects}">
            <div class="subject-grid ${fn:length(subjects) == 1 ? 'one-subject' : ''}">
                <c:forEach var="subject" items="${subjects}">
                    <div class="subject-card">
                        <div class="subject-title">Subject Name: ${subject.name}</div>
                        <div class="subject-detail">
                            <i class="fas fa-book-open"></i> Total Questions: ${subject.questionCount}
                        </div>
                        <div class="button-group">
                            <a href="viewQuestions?subjectId=${subject.id}"
                               class="btn btn-sm btn-outline-info">
                                <i class="fas fa-eye"></i> View Questions
                            </a>
                            <a href="addQuestionPage?subjectId=${subject.id}"
                               class="btn btn-sm btn-outline-success">
                                <i class="fas fa-plus"></i> Add Question
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
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const toast = document.getElementById('successToast');
        const toastCloseBtn = document.getElementById('toastCloseBtn');

        if(toast) {
            // Auto-hide after 3 seconds
            setTimeout(() => {
                toast.classList.add('fade-out');

                // Remove from DOM after animation (500ms)
                setTimeout(() => {
                    const wrapper = document.getElementById('toastWrapper');
                    if(wrapper) wrapper.remove();
                }, 500);
            }, 3000);

            // Close button click handler
            toastCloseBtn.addEventListener('click', () => {
                toast.classList.add('fade-out');
                setTimeout(() => {
                    const wrapper = document.getElementById('toastWrapper');
                    if(wrapper) wrapper.remove();
                }, 500);
            });
        }
    });
</script>

</body>
</html>
