<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Assign Subjects - Admin Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Fonts + Navbar CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminNavbar.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/teacherList.css"/>

  <style>
    .btn-submit {
      margin-top: 1.8rem;
      background-color: #00c9ff;
      border: none;
      padding: 0.75rem 1.8rem;
      font-size: 1.1rem;
      border-radius: 30px;
      color: white;
      cursor: pointer;
      box-shadow: 0 4px 12px rgba(0,201,255,0.4);
      transition: background-color 0.3s ease, box-shadow 0.3s ease;
      display: block;
      width: 100%;
      max-width: 280px;
      margin: 0 auto;
      font-weight: 600;
    }
    .btn-submit:hover {
      background-color: #0096c7;
      box-shadow: 0 6px 18px rgba(0,201,255,0.55);
    }
  </style>
</head>
<body>

<jsp:include page="/WEB-INF/view/navbar/adminNavbar.jsp"/>

<main>
  <div class="header-row">
    <h2>📝 Assign Subjects to <span style="color:#00c9ff;">${teacher.username}</span></h2>
    <div class="back-btn-container">
      <a href="${pageContext.request.contextPath}/admin/teacherList" class="back-btn">&#8592; Back to Faculty List</a>
    </div>
  </div>

  <form action="${pageContext.request.contextPath}/admin/assignSubject" method="post" style="max-width:700px; margin: 0 auto;">
    <input type="hidden" name="teacherId" value="${teacher.id}" />

    <div class="card">
      <div class="card-body">
        <label for="subjectSelect" class="form-label">Select Subjects (hold Ctrl/Cmd or Shift for multiple selection)</label>
        <select name="subjectId" id="subjectSelect" multiple class="form-select" size="8" aria-label="Select subjects">
          <c:forEach var="subject" items="${subjects}">
            <c:set var="selected" value="false"/>
            <c:forEach var="assignedId" items="${assignedSubjectIds}">
              <c:if test="${assignedId == subject.id}">
                <c:set var="selected" value="true"/>
              </c:if>
            </c:forEach>
            <option value="${subject.id}" <c:if test="${selected}">selected="selected"</c:if>>${subject.name}</option>
          </c:forEach>
        </select>

        <button type="submit" class="btn-submit mt-3">Save Assigned Subjects</button>
      </div>
    </div>

  </form>
</main>

<footer>
  &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

<!-- Optional modal still kept -->
<div class="modal fade" id="subjectWarningModal" tabindex="-1" aria-labelledby="subjectWarningModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content text-white" style="background-color: #222;">
      <div class="modal-header border-0">
        <h5 class="modal-title" id="subjectWarningModalLabel">⚠️ Subject Selection Required</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Please select at least one subject before submitting the form.
      </div>
      <div class="modal-footer border-0">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Okay</button>
      </div>
    </div>
  </div>
</div>

<script>
  const warningModal = new bootstrap.Modal(document.getElementById('subjectWarningModal'));

  document.querySelector("form").addEventListener("submit", function(e) {
    const select = document.getElementById("subjectSelect");
    const selectedOptions = [...select.selectedOptions];
    if (selectedOptions.length === 0) {
      e.preventDefault();
      warningModal.show();
    }
  });
</script>

</body>
</html>
