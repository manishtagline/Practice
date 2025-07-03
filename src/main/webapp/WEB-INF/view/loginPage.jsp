<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <title>Login - Student Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

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


        .login-container {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 1rem;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            max-width: 400px;
            width: 100%;
            padding: 2.5rem 3rem;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .login-container h2 {
            font-weight: 700;
            margin-bottom: 2rem;
            color: #00c9ff;
            letter-spacing: 1.5px;
        }

        .form-label {
            color: #ddd;
        }

        .form-control {
            background-color: rgba(255, 255, 255, 0.07);
            color: #f1f1f1;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: border-color 0.3s ease, background-color 0.3s ease;
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
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            border-radius: 0.5rem;
            width: 100%;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(90deg, #92fe9d, #00c9ff);
            color: #000;
        }

        .alert {
            font-size: 0.9rem;
        }

        .form-text {
            margin-top: 1rem;
            color: #bbb;
            font-size: 0.9rem;
        }

        .form-text a {
            color: #00c9ff;
            text-decoration: none;
            font-weight: 600;
            cursor: pointer;
        }

        .form-text a:hover {
            text-decoration: underline;
        }

        /* Make "Click here" bold and colored */
        .link-highlight {
            color: #00c9ff;
            font-weight: 700;
        }

        /* Advanced Modal Styling */
        .modal-content {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            animation: slideIn 0.4s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-30%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header,
        .modal-body {
            border: none;
        }

        .modal-title {
            color: #00c9ff;
            font-weight: 600;
        }

        .modal-button {
            background: linear-gradient(90deg, #00c9ff, #92fe9d);
            color: #1f1c2c;
            border: none;
            font-weight: 600;
            padding: 0.6rem 1.5rem;
            border-radius: 0.5rem;
            margin: 0.5rem;
            transition: background 0.3s ease;
        }

        .modal-button:hover {
            background: linear-gradient(90deg, #92fe9d, #00c9ff);
            color: #000;
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>

<body>

<div class="login-container shadow">
    <h2>Student Exam Center</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty successMsg}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="login" method="post">
        <div class="mb-3 text-start">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required autofocus />
        </div>

        <div class="mb-4 text-start">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required />
        </div>

        <input type="hidden" id="zoneId" name="zoneId">

        <button type="submit" class="btn btn-primary">Login</button>

        <div class="form-text mt-4">
            Create New Account? <a class="link-highlight" data-bs-toggle="modal" data-bs-target="#registerModal">Click here</a>
        </div>
    </form>
</div>

<!-- Modal -->
<div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center">
            <div class="modal-header">
                <h5 class="modal-title text-center w-100" id="registerModalLabel">Register As</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Please choose your registration type:</p>
                <div class="d-flex justify-content-center">
                    <a href="${pageContext.request.contextPath}/baseUserRegistration?role=User" class="modal-button text-decoration-none">User</a>
                    <a href="${pageContext.request.contextPath}/baseUserRegistration?role=Teacher" class="modal-button text-decoration-none">Teacher</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const zoneId = Intl.DateTimeFormat().resolvedOptions().timeZone;
        document.getElementById('zoneId').value = zoneId;
    });
</script>

</body>

</html>
