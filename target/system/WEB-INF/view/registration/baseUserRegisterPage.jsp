<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <title>User Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Toastify CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1f1c2c, #928dab);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            color: #f1f1f1;
        }

        .header-title {
            font-weight: 700;
            margin-bottom: 2rem;
            color: #00c9ff;
            letter-spacing: 1.5px;
        }

        .register-container {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 1rem;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(8px);
            max-width: 500px;
            width: 100%;
            padding: 2.5rem 3rem;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .form-label {
            color: #ddd;
        }

        .form-control {
            background-color: rgba(255, 255, 255, 0.07);
            color: #fff;
        }

        .form-control::placeholder {
            color: #aaa;
        }

        .form-control:focus {
            border-color: #00c9ff;
            background-color: rgba(255, 255, 255, 0.12);
            outline: none;
            box-shadow: 0 0 8px rgba(0, 201, 255, 0.4);
        }

        .btn-primary {
            background: linear-gradient(90deg, #00c9ff, #92fe9d);
            color: #1f1c2c;
            font-weight: 600;
            border: none;
            border-radius: 0.5rem;
            width: 100%;
            padding: 0.75rem;
            margin-top: 1rem;
        }

        .text-danger {
            font-size: 0.85rem;
            margin-top: 0.25rem;
            display: block;
        }

        .btn-back {
            margin-top: 1rem;
            background: transparent;
            border: 2px solid #00c9ff;
            color: #00c9ff;
            font-weight: 600;
            border-radius: 0.5rem;
            padding: 0.5rem 1.5rem;
            cursor: pointer;
            transition: background 0.3s ease, color 0.3s ease;
            width: 100%;
        }

        .btn-back:hover {
            background: #00c9ff;
            color: #1f1c2c;
        }
    </style>
</head>

<body>

<div class="register-container">
    <h2 class="header-title">${role} Registration</h2>

    <!-- Registration Form -->
    <form:form method="post" action="baseUserRegister" modelAttribute="user">

        <div class="mb-3 text-start">
            <label for="username" class="form-label">Username</label>
            <form:input path="username" cssClass="form-control" placeholder="Enter username" />
            <form:errors path="username" cssClass="text-danger" />
        </div>

        <div class="mb-3 text-start">
            <label for="email" class="form-label">Email</label>
            <form:input path="email" cssClass="form-control" placeholder="Enter email" />
            <form:errors path="email" cssClass="text-danger" />
        </div>

        <div class="mb-3 text-start">
            <label for="password" class="form-label">Password</label>
            <form:password path="password" cssClass="form-control" placeholder="Enter password" />
            <form:errors path="password" cssClass="text-danger" />
        </div>

        <div class="mb-3 text-start">
            <label for="confirmPassword" class="form-label">Confirm Password</label>
            <form:password path="confirmPassword" cssClass="form-control" placeholder="Re-enter password" />
            <form:errors path="confirmPassword" cssClass="text-danger" />
        </div>

        <form:hidden path="role" />

        <button type="submit" class="btn btn-primary">Register</button>
    </form:form>

    <!-- Back to login button -->
    <button class="btn-back" onclick="window.location.href='${pageContext.request.contextPath}/'">Back to Login</button>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const successMsg = "${successMsg}";
        const errorMsg = "${errorMsg}";

        if (successMsg && successMsg.trim() !== "") {
            Toastify({
                text: successMsg,
                duration: 2000,
                gravity: "top",
                position: "right",
                close: true,
                stopOnFocus: false,
                style: {
                    background: "linear-gradient(to right, #00b09b, #96c93d)",
                }
            }).showToast();
        }

        if (errorMsg && errorMsg.trim() !== "") {
            Toastify({
                text: errorMsg,
                duration: 2000,
                gravity: "top",
                position: "right",
                close: true,
                stopOnFocus: false,
                style: {
                    background: "linear-gradient(to right, #ff416c, #ff4b2b)",
                }
            }).showToast();
        }
    });
</script>

</body>
</html>
