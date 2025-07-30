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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/teacherPageCss/teacherSubject.css"/>

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
