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
            background: linear-gradient(135deg, #1f1c2c 0%, #3c3c5c 100%);
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            color: #00c9ff;
            text-align: center;
            -webkit-font-smoothing: antialiased;
        }

        .confirmation-card {
            background-color: #2e2e44;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0, 201, 255, 0.4);
            padding: 3rem 2rem;
            max-width: 500px;
            width: 100%;
            animation: slideUp 0.6s ease forwards;
            color: #a0d8ff;
            text-shadow: 0 0 8px #00c9ff88;
        }

        .confirmation-card h1 {
            font-weight: 700;
            font-size: 2.4rem;
            margin-bottom: 1rem;
            color: #00c9ff;
            text-shadow: 0 0 10px #00c9ffcc;
        }

        .confirmation-card h2 {
            font-weight: 600;
            font-size: 1.3rem;
            margin-bottom: 2rem;
            color: #7fcfff;
        }

        .btn-primary {
            background: linear-gradient(90deg, #00c9ff, #0077b6);
            border: none;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 30px;
            color: white;
            text-decoration: none;
            cursor: pointer;
            box-shadow: 0 0 15px #00c9ffaa;
            transition: background 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(90deg, #0077b6, #00c9ff);
            box-shadow: 0 0 25px #00c9ffee;
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
            color: #4a77a3;
            text-shadow: 0 0 5px #00c9ff55;
        }
    </style>
</head>
<body>

<div class="confirmation-card">
    <h1>✅ Exam Submitted Successfully!</h1>
    <h2>Result will be declared after the subject exam is ended.</h2>

    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Go to Home</a>
</div>

<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
