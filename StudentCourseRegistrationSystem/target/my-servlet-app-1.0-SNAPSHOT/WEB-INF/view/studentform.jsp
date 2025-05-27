<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Registration</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #2c3e50, #4ca1af);
            color: #fff;
        }

        header {
            background: rgba(0, 0, 0, 0.4);
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            border-bottom: 2px solid #00d8ff;
        }

        .form-container {
            max-width: 700px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }

        h2 {
            text-align: center;
            color: #ffeb3b;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
        }

        input[type="text"],
        input[type="email"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: none;
            outline: none;
            font-size: 16px;
            background: #ffffff;
            color: #333;
            box-shadow: inset 0 0 5px rgba(0,0,0,0.1);
        }

        select {
            appearance: none;
            background-image: url('https://img.icons8.com/ios-filled/20/000000/expand-arrow--v1.png');
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 14px;
            padding-right: 40px;
        }

        select[multiple] {
            height: 100px; /* Compact height for multi-select */
            overflow-y: auto;
        }

        input:focus, select:focus {
            outline: none;
            box-shadow: 0 0 5px #00c9ff;
        }

        .error {
            color: #ff6b6b;
            font-size: 14px;
        }

        .submit-btn {
            background: #00c9ff;
            padding: 15px 30px;
            border: none;
            border-radius: 30px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            cursor: pointer;
            transition: background 0.3s;
        }

        .submit-btn:hover {
            background: #0072ff;
        }

        .illustration {
            display: block;
            margin: 0 auto 20px;
            width: 100px;
        }
    </style>
</head>
<body>
<header>Tech Institute - Student Registration</header>

<div class="form-container">
    <img class="illustration" src="https://img.icons8.com/clouds/200/student-male.png" alt="Student Graphic"/>

    <h2>Register as a Student</h2>

    <form:form action="addStudent" method="post" modelAttribute="student">

        <div class="form-group">
            <label>Name:</label>
            <form:input path="studentName"/>
            <form:errors path="studentName" cssClass="error"/>
        </div>

        <div class="form-group">
            <label>Email:</label>
            <form:input path="email"/>
            <form:errors path="email" cssClass="error"/>
        </div>

        <div class="form-group">
            <label>Date of Birth:</label>
            <form:input path="dateOfBirth" type="date"/>
        </div>

        <div class="form-group">
            <label>Select Courses:</label>
            <form:select path="courses" multiple="true" items="${courseList}" itemValue="courseId" itemLabel="title"/>
        </div>

        <div style="text-align: center;">
            <button type="submit" class="submit-btn">Submit</button>
        </div>

        <div style="text-align: center; margin-top: 10px;">
            <a href="/StudentCourseRegistrationSystem_war/" class="submit-btn" style="background:#ff6b6b; text-decoration:none; display:inline-block; padding: 15px 30px; border-radius: 30px; font-size: 18px; font-weight: bold; color: white; cursor: pointer;">
                Back
            </a>
        </div>

    </form:form>
</div>
</body>
</html>
