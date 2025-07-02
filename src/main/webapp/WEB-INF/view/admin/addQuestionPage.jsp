<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Add Question - Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"/>
    <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
            rel="stylesheet"/>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/richtexteditor/rte_theme_default.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/addQuestionPage.css"/>

</head>
<body>

<div class="navbar">➕ Add New Question</div>

<div class="form-container">

    <c:if test="${not empty successMsg}">
        <div class="alert alert-success text-center" role="alert">
                ${successMsg}</div>
    </c:if>

    <h2 class="text-center mb-4">Add New Question</h2>

    <form:form method="post" action="${pageContext.request.contextPath}/saveQuestion" modelAttribute="question" onsubmit="submitForm()">

        <form:hidden path="id"/>
        <input type="hidden" name="subjectId" value="${subjectId}"/>

        <div class="mb-3">
            <label for="div_editor1" class="form-label">Question
                Description</label>
            <div id="div_editor1"></div>
            <form:hidden path="questiondDesc" id="questiondDesc"/>
        </div>

        <label class="form-label">Options</label>
        <div class="mb-2">
            <input type="text" name="options" class="form-control mb-2" placeholder="Option 1" required/>
            <input type="text" name="options" class="form-control mb-2" placeholder="Option 2" required/>
            <input type="text" name="options" class="form-control mb-2" placeholder="Option 3"/>
            <input type="text" name="options" class="form-control" placeholder="Option 4"/>
        </div>

        <div class="mb-3">
            <form:label path="correctAnswer" cssClass="form-label">Correct Answer</form:label>
            <form:select path="correctAnswer" cssClass="form-select" required="true">
                <form:option value="" label="<-- Select Correct Option -->"/>
                <form:option value="A" label="A"/>
                <form:option value="B" label="B"/>
                <form:option value="C" label="C"/>
                <form:option value="D" label="D"/>
            </form:select>
        </div>

        <div class="mb-3">
            <form:label path="marks" cssClass="form-label">Marks</form:label>
            <form:input path="marks" type="number" cssClass="form-control"
                        required="true"/>
        </div>

        <div class="mb-3">
            <form:label path="complexity" cssClass="form-label">Complexity</form:label>
            <form:select path="complexity" cssClass="form-select"
                         required="true">
                <form:option value="" label="--Select--"/>
                <form:option value="Easy" label="Easy"/>
                <form:option value="Medium" label="Medium"/>
                <form:option value="Hard" label="Hard"/>
            </form:select>
        </div>

        <button type="submit" class="btn btn-submit">Save Question</button>

        <div class="text-center">
            <a href="manageQuestions?subjectId=${subjectId}" class="btn-back">←
                Back to List</a>
        </div>

    </form:form>
</div>

<!-- Footer -->
<footer> © 2025 Admin Panel | Exam Center. All rights
    reserved.
</footer>

<!-- RichTextEditor Scripts -->
<script
        src="${pageContext.request.contextPath}/static/richtexteditor/rte.js"></script>
<script
        src="${pageContext.request.contextPath}/static/richtexteditor/plugins/all_plugins.js"></script>

<script>
    var editor1;
    document.addEventListener("DOMContentLoaded", function () {
        editor1 = new RichTextEditor("#div_editor1", {
            toolbar: "basic"
        });
    });

    function submitForm() {
        document.getElementById("questiondDesc").value = editor1
            .getHTMLCode();
    }
</script>

</body>
</html>
