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

    <style>
        body {
            background: linear-gradient(to right, #1f1c2c, #928dab);
            font-family: 'Poppins', sans-serif;
            color: white;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background: linear-gradient(to right, #4a00e0, #8e2de2);
            padding: 1rem 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            font-size: 1.5rem;
            font-weight: 600;
            text-align: center;
        }

        .page-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem 1rem;
        }

        .form-container {
            background-color: #2d2d44;
            padding: 2.5rem;
            border-radius: 16px;
            max-width: 700px;
            width: 100%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            animation: fadeInUp 0.8s ease;
        }

        @keyframes fadeInUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        label, .form-label {
            color: #ccc;
            margin-top: 1rem;
            font-weight: 500;
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: none;
            padding: 10px;
        }

        .btn-submit {
            background-color: #00c9ff;
            color: white;
            font-weight: 600;
            border-radius: 30px;
            padding: 12px 20px;
            margin-top: 1.5rem;
            width: 100%;
            transition: background 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #0096c7;
        }

        .btn-back {
            background-color: transparent;
            border: 1px solid #ccc;
            color: #ccc;
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 30px;
            text-decoration: none;
            display: inline-block;
            margin-top: 1.5rem;
            transition: all 0.3s ease-in-out;
        }

        .btn-back:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-color: white;
        }

        .form-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .form-header i {
            font-size: 2rem;
            color: #00c9ff;
            margin-bottom: 0.5rem;
        }

        .exam-tip {
            font-size: 0.9rem;
            color: #aaa;
            text-align: center;
            margin-top: 1rem;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 1.5rem;
            }
        }
        .navbar {
            background: linear-gradient(to right, #4a00e0, #8e2de2);
            padding: 1rem 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            font-size: 1.5rem;
            font-weight: 600;
            color: white;
            position: relative;
        }

        .navbar a {
            color: white;
            font-size: 1.2rem;
        }

        .navbar a:hover {
            color: #ddd;
        }

        .message {
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 1rem;
            font-weight: 600;
        }

        .success-msg {
            color: #39ff14;
            text-shadow: 0 0 6px #39ff14, 0 0 12px #39ff14;
        }

        .error-msg {
            color: #ff4c4c;
            text-shadow: 0 0 6px #ff4c4c, 0 0 12px #ff4c4c;
        }
    </style>
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
                <form:label path="subject.id" cssClass="form-label">Subject</form:label>
                <form:select path="subject.id" cssClass="form-select" required="true">
                    <form:option value="" label="<-- Select Subject -->"/>
                    <c:forEach var="subject" items="${subjectList}">
                        <form:option value="${subject.id}" label="${subject.name}"/>
                    </c:forEach>
                </form:select>
            </div>

            <!-- Enrollment Row -->
           <%-- <div class="row">
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
            </div>--%>
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
