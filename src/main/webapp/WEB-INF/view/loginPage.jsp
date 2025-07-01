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
            background: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        .login-container {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 8px 25px rgba(74, 71, 163, 0.2);
            max-width: 400px;
            width: 100%;
            padding: 2.5rem 3rem;
            text-align: center;
        }

        .login-container h2 {
            font-weight: 700;
            margin-bottom: 2rem;
            color: #4a47a3;
            letter-spacing: 1.5px;
        }

        .form-control {
            border-radius: 0.5rem;
            border: 1.5px solid #4a47a3;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #6a67ce;
            box-shadow: 0 0 8px rgba(106, 103, 206, 0.3);
            outline: none;
        }

        .btn-primary {
            background: linear-gradient(90deg, #4a47a3, #6a67ce);
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            border-radius: 0.5rem;
            width: 100%;
            transition: background 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(90deg, #6a67ce, #4a47a3);
        }

        .form-text {
            margin-top: 1rem;
            color: #555;
            font-size: 0.9rem;
        }

        .form-text a {
            color: #4a47a3;
            text-decoration: none;
            font-weight: 600;
        }

        .form-text a:hover {
            text-decoration: underline;
        }

        /* Responsive */
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
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="login" method="post">
        <div class="mb-3 text-start">
            <label for="username" class="form-label">Username</label>
            <input
                    type="text"
                    class="form-control"
                    id="username"
                    name="username"
                    placeholder="Enter your username"
                    required
                    autofocus
            />
        </div>

        <div class="mb-4 text-start">
            <label for="password" class="form-label">Password</label>
            <input
                    type="password"
                    class="form-control"
                    id="password"
                    name="password"
                    placeholder="Enter your password"
                    required
            />
        </div>

        <button type="submit" class="btn btn-primary">Login</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
