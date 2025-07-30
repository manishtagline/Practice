<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Add Question - Admin Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>

  <!-- Custom CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/richtexteditor/rte_theme_default.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/teacherPageCss/addTeacherQuestion.css"/>

</head>
<body>

<!-- Navbar Include -->
<jsp:include page="/WEB-INF/view/navbar/teacherNavbar.jsp" />

<!-- Header -->
<div class="header-container">
  <h2>Add New Question: ${subject.name}</h2>
  <a href="${pageContext.request.contextPath}/teacher/teacherSubject" class="btn-back" title="Back to My Subjects">
    <i class="fas fa-arrow-left"></i> Back to My Subjects
  </a>
</div>

<!-- Main form card -->
<div class="form-container container">

  <c:if test="${not empty successMsg}">
    <div class="alert alert-success text-center" role="alert">
        ${successMsg}
    </div>
  </c:if>

  <form:form method="post" action="${pageContext.request.contextPath}/teacher/saveQuestion" modelAttribute="question" onsubmit="submitForm()">

    <form:hidden path="id" />
    <input type="hidden" name="subjectId" value="${subjectId}" />

    <!-- Question Description -->
    <div class="mb-3">
      <label for="div_editor1" class="form-label">Question Description</label>
      <div id="div_editor1"></div>
      <form:hidden path="questiondDesc" id="questiondDesc" />
    </div>

    <!-- Options -->
    <label class="form-label">Options</label>
    <div class="mb-2">
      <input type="text" name="options" class="form-control mb-2" placeholder="Option 1" required />
      <input type="text" name="options" class="form-control mb-2" placeholder="Option 2" required />
      <input type="text" name="options" class="form-control mb-2" placeholder="Option 3" />
      <input type="text" name="options" class="form-control" placeholder="Option 4" />
    </div>

    <!-- Correct Answer -->
    <div class="mb-3">
      <form:label path="correctAnswer" cssClass="form-label">Correct Answer</form:label>
      <form:select path="correctAnswer" cssClass="form-select" required="true">
        <form:option value="" label="<-- Select Correct Option -->" />
        <form:option value="A" label="A" />
        <form:option value="B" label="B" />
        <form:option value="C" label="C" />
        <form:option value="D" label="D" />
      </form:select>
    </div>

    <!-- Marks -->
    <div class="mb-3">
      <form:label path="marks" cssClass="form-label">Marks</form:label>
      <form:input path="marks" type="number" cssClass="form-control" required="true" />
    </div>

    <!-- Complexity -->
    <div class="mb-3">
      <form:label path="complexity" cssClass="form-label">Complexity</form:label>
      <form:select path="complexity" cssClass="form-select" required="true">
        <form:option value="" label="--Select--" />
        <form:option value="Easy" label="Easy" />
        <form:option value="Medium" label="Medium" />
        <form:option value="Hard" label="Hard" />
      </form:select>
    </div>

    <!-- Submit Button -->
    <button type="submit" class="btn btn-submit"><i class="fas fa-save me-2"></i>Save Question</button>

  </form:form>
</div>

<!-- Footer -->
<footer>
  &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

<!-- RichTextEditor Scripts -->
<script src="${pageContext.request.contextPath}/static/richtexteditor/rte.js"></script>
<script src="${pageContext.request.contextPath}/static/richtexteditor/plugins/all_plugins.js"></script>

<script>
  var editor1;
  document.addEventListener("DOMContentLoaded", function () {
    editor1 = new RichTextEditor("#div_editor1", {
      toolbar: "basic"
    });
  });

  function submitForm() {
    document.getElementById("questiondDesc").value = editor1.getHTMLCode();
  }
</script>

</body>
</html>
