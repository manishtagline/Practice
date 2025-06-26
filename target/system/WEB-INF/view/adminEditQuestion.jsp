<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Edit Question - Admin Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/richtexteditor/rte_theme_default.css" />

  <style>
    html, body { height:100%; margin:0; font-family:'Poppins', sans-serif; background:linear-gradient(to right,#1f1c2c,#928dab); color:white; }
    .navbar {
      background: linear-gradient(to right, #4a00e0, #8e2de2);
      padding:1rem 2rem; box-shadow:0 4px 20px rgba(0,0,0,0.3);
      color:white; font-size:1.5rem; font-weight:600;
      display:flex; justify-content:center; align-items:center;
    }
    .form-container {
      background-color:#2a2a3c; padding:2rem; border-radius:20px;
      max-width:600px; margin:3rem auto; box-shadow:0 10px 30px rgba(0,0,0,0.4);
    }
    .form-container h2 { text-align:center; margin-bottom:1.5rem; }
    label, .form-label { color:#ccc; }
    input.form-control, select.form-select, textarea.form-control {
      background-color:#3e3e5e; color:white; border:1px solid #555;
    }
    .btn-submit {
      background-color: #00c9ff; color:white; font-weight:600;
      padding:10px 20px; border:none; border-radius:30px; width:100%;
      margin-top:1.5rem;
    }
    .btn-submit:hover { background-color:#0096c7; }
    .btn-back {
      display:inline-block;
      margin-top:1rem;
      padding:8px 16px;
      border:1px solid #ccc; color:#ccc;
      border-radius:20px;
      text-decoration:none;
      transition:0.3s;
    }
    .btn-back:hover { background-color:rgba(255,255,255,0.1); color:white; border-color:white; }
    footer {
      background-color:#1a1a2e; color:#ccc; text-align:center;
      padding:1rem; font-size:0.9rem;
    }
    #div_editor1 { min-height:150px; border:1px solid #555; border-radius:6px; background:white; color:black; }
    #div_editor1 .rte-editor { min-height:150px; }
    .message { text-align:center; margin-bottom:1rem; font-weight:600; }
    .success-msg { color:#39ff14; }
    .error-msg { color:#ff4c4c; }
  </style>
</head>

<body>
<div class="navbar">✏️ Edit Question</div>

<div class="form-container">
  <h2>Edit Question</h2>

  <!-- Display success/error if provided -->
  <c:if test="${not empty successMsg}">
    <div class="message success-msg">${successMsg}</div>
  </c:if>
  <c:if test="${not empty errorMsg}">
    <div class="message error-msg">${errorMsg}</div>
  </c:if>

  <form:form modelAttribute="question" method="post" action="${pageContext.request.contextPath}/updateQuestion" onsubmit="onSubmit()">
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

    <button type="submit" class="btn-submit">Update Question</button>
  </form:form>

  <!-- Back Button -->
  <div class="text-center">
    <a href="manageQuestions?subjectId=${question.subject.id}" class="btn-back">← Back to List</a>
  </div>
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
