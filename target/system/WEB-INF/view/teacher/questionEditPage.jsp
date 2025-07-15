<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit Question - Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/richtexteditor/rte_theme_default.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/editQuestion.css"/>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        .back-button-wrapper {
            display: flex;
            justify-content: flex-end;
            padding: 0.8rem 1rem 0 1rem;
        }
        .btn-back {
            color: #ccc;
            font-weight: 600;
            padding: 0.4rem 0.8rem;
            border: 2px solid transparent;
            border-radius: 0.5rem;
            text-decoration: none;
            transition: color 0.3s ease, border-color 0.3s ease;
            white-space: nowrap;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
        }
        .btn-back:hover {
            color: #00c9ff;
            border-color: #00c9ff;
            text-decoration: none;
        }
        .form-container {
            padding: 1rem;
            margin-top: 0;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }
        .btn-submit {
            background-color: #1a73e8;
            color: white;
            font-weight: 600;
        }
        .btn-submit:hover {
            background-color: #155ab6;
        }
        footer {
            text-align: center;
            margin-top: 2rem;
            font-size: 0.9rem;
            color: #666;
        }
        /* Optional: style for success/error messages */
        .alert {
            max-width: 800px;
            margin: 1rem auto;
        }
    </style>
</head>

<body>
<!-- Include navbar -->
<jsp:include page="/WEB-INF/view/navbar/teacherNavbar.jsp" />

<!-- Back button aligned to right -->
<div class="back-button-wrapper">
    <a href="viewQuestions?subjectId=${question.subject.id}" class="btn-back" title="Back to My Subjects">
        <i class="fas fa-arrow-left"></i> Back to My Subjects
    </a>
</div>

<div class="form-container">
    <h2>Edit Question</h2>

    <!-- Display success/error if provided -->
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success text-center">${successMsg}</div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger text-center">${errorMsg}</div>
    </c:if>

    <form:form modelAttribute="question" method="post" action="updateTeacherQuestion" onsubmit="onSubmit()">
        <form:hidden path="id" />
        <form:hidden path="subject.id"/>

        <!-- Subject is fixed; optionally display but disabled -->
        <div class="mb-3">
            <label class="form-label">Subject</label>
            <input type="text" class="form-control" value="${question.subject.name}" readonly />
        </div>

        <!-- Rich text editor for question description -->
        <div class="mb-3">
            <label class="form-label">Description</label>
            <div id="div_editor1">${question.questiondDesc}</div>
            <form:hidden path="questiondDesc" id="questiondDesc" />
        </div>

        <!-- Options -->
        <div class="mb-3">
            <label class="form-label">Options</label>
            <c:forEach items="${question.options}" var="opt" varStatus="st">
                <input type="text" name="options" value="${opt}" class="form-control mb-2"
                       placeholder="Option ${st.index + 1}" required="${st.index < 2}" />
            </c:forEach>
        </div>

        <!-- Other fields -->
        <div class="mb-3">
            <form:label path="correctAnswer" cssClass="form-label">Correct Answer</form:label>
            <form:input path="correctAnswer" cssClass="form-control" required="true" />
        </div>
        <div class="mb-3">
            <form:label path="marks" cssClass="form-label">Marks</form:label>
            <form:input path="marks" type="number" cssClass="form-control" required="true" />
        </div>
        <div class="mb-3">
            <form:label path="complexity" cssClass="form-label">Complexity</form:label>
            <form:select path="complexity" cssClass="form-select" required="true">
                <form:option value="" label="--Select--" />
                <form:option value="Easy" label="Easy" />
                <form:option value="Medium" label="Medium" />
                <form:option value="Hard" label="Hard" />
            </form:select>
        </div>

        <button type="submit" class="btn btn-submit">Update Question</button>
    </form:form>
</div>

<footer>&copy; 2025 Admin Panel | Exam Center. All rights reserved.</footer>

<script src="${pageContext.request.contextPath}/static/richtexteditor/rte.js"></script>
<script src="${pageContext.request.contextPath}/static/richtexteditor/plugins/all_plugins.js"></script>
<script>
    let editor;
    document.addEventListener('DOMContentLoaded', function(){
        editor = new RichTextEditor("#div_editor1", {toolbar:"basic"});
    });
    function onSubmit(){
        document.getElementById("questiondDesc").value = editor.getHTMLCode();
    }
</script>
</body>
</html>
