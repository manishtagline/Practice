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

</head>
<body>

<div class="navbar d-flex justify-content-between align-items-center">
    <div class="mx-auto text-center">
        <i class="fas fa-plus-circle me-2"></i> Add New Exam
    </div>
    <span style="width: 1.5rem;"></span>
</div>

<div class="page-wrapper">
    <div class="form-container">



        <div class="form-header">
            <i class="fas fa-clipboard-list"></i>
            <h2>Create Exam</h2>
            <p class="exam-tip">"Exams are not just tests, they're milestones. Make it count!"</p>
        </div>

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

        <form:form modelAttribute="exam" method="post" action="${pageContext.request.contextPath}/saveExam">

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

            <!-- Back -->
            <div class="text-center">
                <a href="examList" class="btn-back"><i class="fas fa-arrow-left me-1"></i>Back to Exams</a>
            </div>
        </form:form>
    </div>
</div>

</body>
</html>
