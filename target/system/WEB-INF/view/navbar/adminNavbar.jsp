<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar">

    <!-- Centered Logo + Brand -->
    <div class="navbar-brand-container" onclick="location.href='adminPage'">
        <svg class="logo-svg" viewBox="0 0 64 64">
            <path d="M8 12h48v40H8z" stroke-linejoin="round"/>
            <line x1="8" y1="12" x2="56" y2="12"/>
            <line x1="32" y1="12" x2="32" y2="52"/>
        </svg>
        <span class="navbar-brand">Admin Panel</span>
    </div>

    <!-- Right side nav menu + username -->
    <div class="right-side">
        <div class="nav-menu">
            <!-- Home Icon -->
            <div class="nav-item" onclick="location.href='adminPage'">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 9l9-7 9 7"/>
                    <path d="M9 22V12H15V22"/>
                </svg> Home
            </div>

            <!-- Subjects -->
            <div class="nav-item" onclick="location.href='subjectList'">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                    <polyline points="17 8 12 3 7 8"/>
                    <line x1="12" y1="3" x2="12" y2="15"/>
                </svg> Subjects
            </div>

            <!-- Users -->
            <div class="nav-item" onclick="location.href='userList'">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M20 21v-2a4 4 0 0 0-3-3.87"/>
                    <path d="M4 21v-2a4 4 0 0 1 3-3.87"/>
                    <circle cx="12" cy="7" r="4"/>
                </svg> Users
            </div>

            <!-- Exams -->
            <div class="nav-item" onclick="location.href='examList'">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                    <line x1="16" y1="2" x2="16" y2="6"/>
                    <line x1="8" y1="2" x2="8" y2="6"/>
                    <line x1="3" y1="10" x2="21" y2="10"/>
                </svg> Exams
            </div>


            <!-- Faculty -->
            <div class="nav-item" onclick="location.href='teacherList'">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4z"/>
                    <path d="M6 20v-2c0-2.21 3.58-4 6-4s6 1.79 6 4v2"/>
                </svg> Faculty
            </div>

            <!-- Logout -->
            <div class="nav-item" onclick="showLogoutModal()">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M16 17l5-5-5-5"/>
                    <path d="M21 12H9"/>
                    <path d="M12 19H9a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h3"/>
                </svg> Logout
            </div>
        </div>
    </div>
</nav>

<!-- Logout Confirmation Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background: linear-gradient(to right, #1f1c2c, #928dab); color: #fff; border: none;">
            <div class="modal-header" style="border-bottom: 1px solid rgba(255,255,255,0.1);">
                <h5 class="modal-title" id="logoutModalLabel">🔒 Confirm Logout</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to log out from the admin dashboard?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="confirmLogout()">Yes, Logout</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle (with Popper) -->
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
