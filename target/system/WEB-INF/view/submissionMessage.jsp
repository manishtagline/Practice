<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Exam Submission Confirmation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            color: #4a47a3;
            text-align: center;
        }

        .confirmation-card {
            background-color: white;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(74, 71, 163, 0.15);
            padding: 3rem 2rem;
            max-width: 500px;
            width: 100%;
            animation: slideUp 0.6s ease forwards;
        }

        .confirmation-card h1 {
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #4a47a3;
        }

        .confirmation-card p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
        }

        .btn-primary {
            background: linear-gradient(90deg, #4a47a3, #6a67ce);
            border: none;
            padding: 0.75rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 30px;
            color: white;
            text-decoration: none;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(90deg, #6a67ce, #4a47a3);
            text-decoration: none;
            color: white;
        }

        @keyframes slideUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        footer {
            margin-top: auto;
            padding: 1rem;
            font-size: 0.9rem;
            color: #4a47a3;
        }
    </style>
</head>
<body>

<div class="confirmation-card">
    <h1>✅ Exam Submitted Successfully!</h1>

    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Go to Home</a>
</div>

<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
