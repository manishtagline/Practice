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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/userPageCss/showUpcomingExam.css"/>

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

    <!-- Legend for colors -->
    <div class="d-flex justify-content-center mb-3" style="gap: 1.5rem; font-weight: 600;">
        <div class="d-flex align-items-center" style="gap: 0.5rem;">
            <span style="display: inline-block; width: 20px; height: 20px; background-color: #28a745; border-radius: 4px;"></span>
            <span>Not Given (Enrolled but not submitted)</span>
        </div>
        <div class="d-flex align-items-center" style="gap: 0.5rem;">
            <span style="display: inline-block; width: 20px; height: 20px; background-color: #6c757d; border-radius: 4px;"></span>
            <span>Given (Submitted)</span>
        </div>
    </div>

    <div id="calendar"></div>
</main>

<footer>
    &copy; 2025 Student Exam Center. All rights reserved.
</footer>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');
        const events = JSON.parse('${calendarEvents}');

        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            height: 'auto',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: events,
            eventDidMount: function(info) {
                // info.event.extendedProps contains extra properties like 'submitted'
                if (info.event.extendedProps.submitted) {
                    // Submitted exams - grey color
                    info.el.style.backgroundColor = '#6c757d'; // Bootstrap grey
                    info.el.style.borderColor = '#6c757d';
                    info.el.style.color = '#ffffff';
                } else {
                    // Enrolled but not submitted - green color
                    info.el.style.backgroundColor = '#28a745'; // Bootstrap green
                    info.el.style.borderColor = '#28a745';
                    info.el.style.color = '#ffffff';
                }
            }
        });

        calendar.render();
    });
</script></body>
</html>
