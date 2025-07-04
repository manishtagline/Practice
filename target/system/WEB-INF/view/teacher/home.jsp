<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Teacher Dashboard - Exam Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

    <style>
        html, body {
            height: 100%;
            margin: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            color: #f0f0f0;
            display: flex;
            flex-direction: column;
        }

        main {
            flex: 1;
            padding: 2rem;
            z-index: 2;
        }

        .welcome-user {
            font-size: 1.4rem;
            color: #ffffff;
            background: rgba(255, 255, 255, 0.1);
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 600;
            margin: 0 auto 1.5rem auto;
            max-width: fit-content;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            text-align: center;
        }

        h1 {
            text-align: center;
            color: #ffffff;
            margin-bottom: 1rem;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 2rem;
            max-width: 1000px;
            margin: auto;
        }

        .card {
            background: #3c3c3c;
            padding: 2rem 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0,0,0,0.4);
            transition: 0.3s;
            flex: 1 1 280px;
            text-align: center;
            cursor: pointer;
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.6);
            background-color: #505050;
        }

        .card-icon {
            width: 80px;
            height: 80px;
            margin-bottom: 1rem;
            stroke: #00c9ff;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #00c9ff;
            margin-bottom: 0.5rem;
        }

        .card-text {
            color: #ccc;
        }

        footer {
            background-color: #1a1a2e;
            color: #ccc;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .card-container {
                flex-direction: column;
                gap: 1.5rem;
            }
        }
        /* Custom Modal Styling */
        .modal-content.custom-modal {
            background: #2a2a40;
            color: #f0f0f0;
            border: 1px solid #444;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.6);
        }

        .modal-header.custom-header {
            background: #38385a;
            border-bottom: 1px solid #555;
            color: #00c9ff;
        }

        .modal-footer .btn-danger {
            background-color: #ff4d4d;
            border: none;
        }

        .modal-footer .btn-danger:hover {
            background-color: #e60000;
        }

        .modal-footer .btn-secondary {
            background-color: #444;
            border: none;
        }

        .modal-footer .btn-secondary:hover {
            background-color: #666;
        }

    </style>

</head>

<body>

<!-- Navbar -->
<jsp:include page="/WEB-INF/view/navbar/teacherNavbar.jsp"/>

<main>
    <div class="welcome-user">👋 Welcome <strong>${teacher}</strong>, manage your classes and exams!</div>

    <h1>Teacher Dashboard</h1>
    <p class="text-center text-light mb-4">Manage your assigned subjects, exams, and students efficiently.</p>

    <div class="card-container">

        <!-- View Subjects -->
        <div class="card" onclick="location.href='teacherSubjectList'">
            <svg class="card-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                <polyline points="17 8 12 3 7 8"/>
                <line x1="12" y1="3" x2="12" y2="15"/>
            </svg>
            <h5 class="card-title">My Subjects</h5>
            <p class="card-text">View subjects assigned to you.</p>
        </div>

        <!-- My Students -->
        <div class="card" onclick="location.href='teacherStudentList'">
            <svg class="card-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 21v-2a4 4 0 0 0-3-3.87"/>
                <path d="M4 21v-2a4 4 0 0 1 3-3.87"/>
                <circle cx="12" cy="7" r="4"/>
            </svg>
            <h5 class="card-title">My Students</h5>
            <p class="card-text">View students enrolled in your subjects.</p>
        </div>

        <!-- Manage Exams -->
        <div class="card" onclick="location.href='teacherExamList'">
            <svg class="card-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                <line x1="16" y1="2" x2="16" y2="6"/>
                <line x1="8" y1="2" x2="8" y2="6"/>
                <line x1="3" y1="10" x2="21" y2="10"/>
            </svg>
            <h5 class="card-title">Manage Exams</h5>
            <p class="card-text">Create and grade exams for your classes.</p>
        </div>

        <!-- Profile -->
        <div class="card" onclick="location.href='teacherProfile'">
            <svg class="card-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="12" cy="7" r="4"/>
                <path d="M5.5 21h13a2 2 0 0 0-13 0z"/>
            </svg>
            <h5 class="card-title">My Profile</h5>
            <p class="card-text">Update your profile information.</p>
        </div>

        <!-- Logout -->
        <div class="card" onclick="showLogoutModal()">
            <svg class="card-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M16 17l5-5-5-5"/>
                <path d="M21 12H9"/>
                <path d="M12 19H9a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h3"/>
            </svg>
            <h5 class="card-title">Logout</h5>
            <p class="card-text">Sign out securely from your account.</p>
        </div>
    </div>
</main>

<!-- Logout Confirmation Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content custom-modal">
            <div class="modal-header custom-header">
                <h5 class="modal-title" id="logoutModalLabel">🔒 Confirm Logout</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to log out from your dashboard?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="confirmLogout()">Yes, Logout</button>
            </div>
        </div>
    </div>
</div>

<footer>
    &copy; 2025 Teacher Panel | Exam Center. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function showLogoutModal() {
        const modal = new bootstrap.Modal(document.getElementById('logoutModal'));
        modal.show();
    }

    function confirmLogout() {
        window.location.href = 'logout';
    }
</script>

</body>
</html>
