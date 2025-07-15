<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Add Exam - Admin Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/addExam.css"/>

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #1f1c2c, #928dab);
      color: #f0f0f0;
      margin: 0;
    }

    .header-container {
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      padding: 1rem 0;
      margin-top: 0.5rem;
      border-bottom: 2px solid rgba(0,201,255,0.25);
      min-height: 70px;
    }

    .header-container h2 {
      color: #00c9ff;
      font-weight: 600;
      font-size: 2rem;
      margin: 0;
      user-select: none;
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
    }

    .btn-back {
      position: absolute;
      right: 0;
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

    .btn-back:hover {
      color: #00c9ff;
      border-color: #00c9ff;
    }

    .form-container {
      max-width: 800px;
      margin: 2rem auto;
      background-color: #2f2f2f;
      padding: 2rem;
      border-radius: 1rem;
      box-shadow: 0 8px 20px rgba(0,0,0,0.5);
      border: 1px solid rgba(0,201,255,0.25);
    }

    .form-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .form-header i {
      color: #00c9ff;
      font-size: 2rem;
    }

    .form-header h2 {
      font-weight: 600;
      color: #00c9ff;
      margin-top: 0.5rem;
    }

    .exam-tip {
      font-size: 0.9rem;
      color: #ccc;
      font-style: italic;
      margin-top: 0.2rem;
    }

    .form-label {
      color: #f0f0f0;
    }

    .form-control,
    .form-select {
      background-color: #1f1f1f;
      border: 1px solid #555;
      color: #f0f0f0;
    }

    .form-control:focus,
    .form-select:focus {
      border-color: #00c9ff;
      box-shadow: 0 0 0 0.2rem rgba(0,201,255,0.25);
      background-color: #1f1f1f;
      color: #fff;
    }

    .btn-submit {
      background-color: #00c9ff;
      border: none;
      color: #1f1c2c;
      font-weight: bold;
      padding: 0.6rem 1.5rem;
      font-size: 1rem;
      border-radius: 0.5rem;
      transition: background-color 0.3s ease;
      margin-top: 1rem;
    }

    .btn-submit:hover {
      background-color: #009ccf;
      color: #fff;
    }

    .flash-msg {
      padding: 1rem;
      border-radius: 0.5rem;
      margin-bottom: 1rem;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 0.6rem;
    }

    .success-msg {
      background-color: #d1f7e7;
      color: #006644;
    }

    .error-msg {
      background-color: #ffe6e6;
      color: #cc0000;
    }
    footer {
      background-color: #1a1a2e;
      color: #aaa;
      text-align: center;
      padding: 1rem;
      font-size: 0.9rem;
    }
    .flash-msg .icon {
      font-size: 1.2rem;
    }
  </style>
</head>
<body>

<!-- Include navbar -->
<jsp:include page="/WEB-INF/view/navbar/teacherNavbar.jsp" />

<!-- Header with label and back button -->
<div class="header-container">
  <h2>Create Your Exams</h2>
  <a href="${pageContext.request.contextPath}/teacher/teacherExamList" class="btn-back" title="Back to Exams">
    <i class="fas fa-arrow-left"></i> Back to Exams
  </a>
</div>

<!-- Form container -->
<div class="form-container">

  <%--<div class="form-header">
    <i class="fas fa-clipboard-list"></i>
    <h2>Create Exam</h2>
    <p class="exam-tip">"Exams are not just tests, they're milestones. Make it count!"</p>
  </div>--%>

  <!-- Success Message -->
  <c:if test="${not empty successMsg}">
    <div class="flash-msg success-msg">
      <i class="fas fa-check-circle icon"></i>
      <span>${successMsg}</span>
    </div>
  </c:if>

  <!-- Error Message -->
  <c:if test="${not empty errorMsg}">
    <div class="flash-msg error-msg">
      <i class="fas fa-exclamation-triangle icon"></i>
      <span>${errorMsg}</span>
    </div>
  </c:if>

  <form:form modelAttribute="exam" method="post" action="${pageContext.request.contextPath}/teacher/saveExam">

    <div class="mb-3">
      <form:label path="description" cssClass="form-label">Description</form:label>
      <form:input path="description" cssClass="form-control" required="true"/>
    </div>

    <div class="mb-3">
      <form:label path="totalMarks" cssClass="form-label">Total Marks</form:label>
      <form:input path="totalMarks" type="number" cssClass="form-control" required="true"/>
    </div>

    <div class="mb-3">
      <form:label path="subjectId" cssClass="form-label">Subject</form:label>
      <form:select path="subjectId" cssClass="form-select" required="true">
        <form:option value="" label="<-- Select Subject -->"/>
        <c:forEach var="subject" items="${subjectList}">
          <form:option value="${subject.id}" label="${subject.name}"/>
        </c:forEach>
      </form:select>
    </div>

    <!-- Enrollment Row -->
    <div class="row">
      <div class="col-md-6 mb-3">
        <form:label path="enrolledStartDate" cssClass="form-label">Enrollment Start Date</form:label>
        <form:input path="enrolledStartDate" type="datetime-local" cssClass="form-control" required="true"/>
      </div>
      <div class="col-md-6 mb-3">
        <form:label path="enrolledEndDate" cssClass="form-label">Enrollment End Date</form:label>
        <form:input path="enrolledEndDate" type="datetime-local" cssClass="form-control" required="true"/>
      </div>
    </div>

    <!-- Exam Row -->
    <div class="row">
      <div class="col-md-6 mb-3">
        <form:label path="examStartDate" cssClass="form-label">Exam Start Date</form:label>
        <form:input path="examStartDate" type="datetime-local" cssClass="form-control" required="true"/>
      </div>
      <div class="col-md-6 mb-3">
        <form:label path="examEndDate" cssClass="form-label">Exam End Date</form:label>
        <form:input path="examEndDate" type="datetime-local" cssClass="form-control" required="true"/>
      </div>
    </div>

    <!-- Submit -->
    <button type="submit" class="btn btn-submit"><i class="fas fa-save me-2"></i>Save Exam</button>

  </form:form>
</div>
<footer>
  &copy; 2025 Teacher Panel | Exam Center. All rights reserved.
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

