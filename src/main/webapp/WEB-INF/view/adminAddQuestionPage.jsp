<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Add Question - Admin Panel</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/richtexteditor/rte_theme_default.css" />

  <style>
    html, body {
      height: 100%;
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #1f1c2c, #928dab);
      color: white;
    }

    .navbar {
      background: linear-gradient(to right, #4a00e0, #8e2de2);
      padding: 1rem 2rem;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
      color: white;
      font-size: 1.5rem;
      font-weight: 600;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .form-container {
      background-color: #2d2d44;
      padding: 2rem;
      border-radius: 16px;
      max-width: 800px;
      margin: 2rem auto;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.4);
      height: 700px;
      overflow-y: auto;
    }

    label {
      margin-top: 1rem;
    }

    .btn-submit {
      background-color: #00c9ff;
      color: white;
      font-weight: 600;
      border-radius: 30px;
      padding: 10px 20px;
      margin-top: 1.5rem;
    }

    .btn-submit:hover {
      background-color: #0096c7;
    }

    .btn-back {
      background-color: #6c757d;
      border: none;
      color: white;
      margin-bottom: 1rem;
      font-weight: 600;
    }

    .btn-back:hover {
      background-color: #5a6268;
    }

    footer {
      background-color: #1a1a2e;
      color: #ccc;
      text-align: center;
      padding: 1rem;
      font-size: 0.9rem;
    }

    #div_editor1 {
      min-height: 150px;
      max-width: 100%;
      border: 1px solid #555;
      border-radius: 6px;
      background-color: white;
      color: black;
    }

    #div_editor1 .rte-editor {
      min-height: 150px;
    }

    .alert-success {
      background-color: #28a745;
      color: white;
      border-radius: 8px;
      font-weight: 600;
    }
  </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">➕ Add New Question</div>

<!-- Form Container -->
<div class="form-container">

  <!-- Success Flash Message -->
  <c:if test="${not empty successMsg}">
    <div class="alert alert-success text-center" role="alert">
        ${successMsg}
    </div>
  </c:if>

  <h2 class="text-center mb-4">Add New Question</h2>

  <form:form method="post" action="${pageContext.request.contextPath}/saveQuestion" modelAttribute="question" onsubmit="submitForm()">

    <form:hidden path="id" />
    <input type="hidden" name="subjectId" value="${subjectId}" />

    <div class="mb-3">
      <label for="div_editor1" class="form-label">Question Description</label>
      <div id="div_editor1"></div>
      <form:hidden path="questiondDesc" id="questiondDesc" />
    </div>

    <label class="form-label">Options</label>
    <div class="mb-2">
      <input type="text" name="options" class="form-control mb-2" placeholder="Option 1" required />
      <input type="text" name="options" class="form-control mb-2" placeholder="Option 2" required />
      <input type="text" name="options" class="form-control mb-2" placeholder="Option 3" />
      <input type="text" name="options" class="form-control" placeholder="Option 4" />
    </div>

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

    <button type="submit" class="btn btn-submit w-100">Save Question</button>

  </form:form>
</div>

<!-- Footer -->
<footer>
  © 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

<!-- RichTextEditor Scripts -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/richtexteditor/rte.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/richtexteditor/plugins/all_plugins.js"></script>

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
