<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit Subject - Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        html, body { height: 100%; margin: 0; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            display: flex;
            flex-direction: column;
        }
        .background-animation {
            position: fixed; top: 0; left: 0;
            width: 100%; height: 100%;
            z-index: 0; overflow: hidden; opacity: 0.2;
        }
        .navbar {
            background: linear-gradient(to right, #4a00e0, #8e2de2);
            padding: 1rem 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            color: white; font-size: 1.5rem; font-weight: 600;
            z-index: 10; text-align: center;
            display: flex; justify-content: center; align-items: center;
        }
        main {
            flex: 1; z-index: 2;
            padding: 3rem 2rem;
            display: flex; align-items: center; justify-content: center;
        }
        .form-container {
            background-color: #2a2a3c;
            padding: 2.5rem;
            border-radius: 20px;
            max-width: 500px; width: 100%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
        }
        .form-container h2 {
            color: white; font-weight: 700;
            margin-bottom: 1.5rem; text-align: center;
        }
        label { color: #ccc; margin-bottom: 0.5rem; }
        input.form-control {
            background-color: #3e3e5e;
            color: white; border: 1px solid #555;
        }
        input.form-control:focus {
            background-color: #3e3e5e;
            border-color: #8e2de2;
            box-shadow: 0 0 0 0.2rem rgba(142, 45, 226, 0.25);
        }
        .btn-submit {
            background-color: #00c9ff;
            color: white; font-weight: 600;
            padding: 10px 20px;
            border: none; border-radius: 30px;
            transition: all 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #0096c7;
            box-shadow: 0 6px 18px rgba(0, 201, 255, 0.45);
        }
        footer {
            background-color: #1a1a2e;
            color: #ccc;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
            z-index: 2;
        }
        @media (max-width: 576px) {
            .form-container { padding: 1.5rem; }
        }
    </style>
</head>

<body>

<div class="background-animation">
    <svg viewBox="0 0 1440 320" preserveAspectRatio="none" style="width:100%; height:100%;">
        <path fill="#ffffff" fill-opacity="0.3"
              d="M0,96L48,128C96,160,192,224,288,245.3C384,267,480,245,576,218.7C672,192,768,160,864,154.7C960,149,1056,171,1152,160C1248,149,1344,107,1392,85.3L1440,64L1440,320L0,320Z">
        </path>
    </svg>
</div>

<div class="navbar">✏️ Edit Subject</div>

<main>
    <div class="form-container">
        <h2>Edit Subject</h2>

        <form action="${pageContext.request.contextPath}/updateSubject" method="post">
            <!-- Hidden ID field -->
            <input type="hidden" name="id" value="${subject.id}" />

            <div class="mb-3">
                <label for="subjectName" class="form-label">Subject Name</label>
                <input type="text" class="form-control" id="subjectName" name="name" value="${subject.name}" required />
            </div>

            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-submit">Update Subject</button>
            </div>
        </form>
    </div>
</main>

<footer>
    &copy; 2025 Admin Panel | Exam Center. All rights reserved.
</footer>

</body>
</html>
