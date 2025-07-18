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
  <!-- Bootstrap 5 CSS and JS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Fonts + Navbar CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminNavbar.css" />

  <!-- Your existing page CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminPageCss/teacherList.css"/>

  <style>
    /* Additional styles for multi-select */
    select[multiple] {
      width: 100%;
      height: 280px;
      background: rgba(255 255 255 / 0.05);
      border: 1px solid rgba(255 255 255 / 0.1);
      border-radius: 12px;
      color: #eee;
      font-size: 1.1rem;
      padding: 0.5rem 1rem;
      backdrop-filter: blur(6px);
      user-select: auto;
      cursor: pointer;
      outline: none;
    }
    option {
      background-color: #292929;
      color: #eee;
      padding: 0.3rem 0.5rem;
    }
    option:hover {
      background-color: #3a3a3a;
    }
    .multi-select-hint {
      color: #00c9ff;
      font-style: italic;
      font-size: 0.9rem;
      margin-bottom: 1rem;
      text-align: center;
      user-select: none;
    }
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
        <div class="multi-select-hint">
          Hold <kbd>Cmd (⌘)</kbd> or <kbd>Shift</kbd> to select multiple subjects
        </div>

        <select name="subjectId" multiple>
          <c:forEach var="subject" items="${subjects}">
            <option value="${subject.id}"
                    <c:if test="${teacher.subjects != null && teacher.subjects.contains(subject)}">selected</c:if>>
                ${subject.name}
            </option>
          </c:forEach>
        </select>

        <button type="submit" class="btn-submit mt-2">Save Assigned Subjects</button>
      </div>
    </div>
  </form>
</main>

<footer>
  &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

<!-- Modal for warning -->
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
  // Bootstrap 5 modal instance
  const warningModal = new bootstrap.Modal(document.getElementById('subjectWarningModal'));

  document.querySelector("form").addEventListener("submit", function (e) {
    const select = document.querySelector("select[name='subjectId']");
    const selectedOptions = [...select.selectedOptions];

    if (selectedOptions.length === 0) {
      e.preventDefault();
      // Show Bootstrap modal instead of alert
      warningModal.show();
    }
  });
</script>

</body>
</html>
