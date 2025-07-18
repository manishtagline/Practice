<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upcoming Exams Calendar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- FullCalendar -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.18/index.global.min.js'></script>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1f1c2c, #928dab);
            color: #f0f0f0;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        main {
            padding: 2rem;
            max-width: 1000px;
            margin: 0 auto;
            position: relative;
        }

        /* Back button in top right */
        .back-button-container {
            position: absolute;
            top: 1rem;
            right: 0;
        }

        .back-button-container .btn {
            font-weight: 600;
            color: #00c9ff;
            border-color: #00c9ff;
            transition: background-color 0.3s, color 0.3s;
        }

        .back-button-container .btn:hover {
            background-color: #00c9ff;
            color: #1f1c2c;
        }

        h1 {
            text-align: center;
            margin-bottom: 2rem;
            color: #00c9ff;
            text-shadow: 0 0 10px #00c9ff88;
        }

        #calendar {
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.3);
        }

        .fc-event-title {
            font-weight: bold;
            color: #333;
        }

        footer {
            background-color: #1a1a2e;
            color: #ccc;
            text-align: center;
            padding: 1rem;
            margin-top: 2rem;
        }
    </style>
</head>
<body>

<!-- Navbar (Optional) -->
<jsp:include page="/WEB-INF/view/navbar/userNavbar.jsp"/>

<main>
    <!-- Back Button top right -->
    <div class="back-button-container">
        <button onclick="history.back()" class="btn btn-outline-info">
            ← Back to Dashboard
        </button>
    </div>

    <h1>📅 Upcoming Exams</h1>
    <div id="calendar"></div>
</main>

<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');
        const event = JSON.parse('${calendarEvents}');

        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            height: 'auto',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: event
        });

        calendar.render();
    });
</script>
</body>
</html>
