<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .navbar {
        position: relative; /* Set to match teacher navbar */
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 80px;
        padding: 0 2rem;
        background: linear-gradient(to right, #1f1c2c, #928dab);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.6);
        z-index: 10;
    }

    .navbar-brand-container {
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        align-items: center;
        cursor: pointer;
    }

    .logo-svg {
        width: 36px;
        height: 36px;
        stroke: #00c9ff;
        stroke-width: 2;
        fill: none;
        animation: spin 4s linear infinite;
    }

    .navbar-brand {
        font-weight: 700;
        font-size: 1.5rem;
        color: #fefefe;
        margin-left: 0.5rem;
        letter-spacing: 1px;
    }

    @keyframes spin {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }

    .right-side {
        position: absolute;
        right: 2rem;
        display: flex;
        align-items: center;
        gap: 1.5rem;
    }

    .nav-menu {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .nav-item {
        color: #f0f0f5;
        text-align: center;
        cursor: pointer;
        text-decoration: none;
        transition: transform 0.2s, background-color 0.3s;
        padding: 10px 12px;
        border-radius: 8px;
        white-space: nowrap;
        font-weight: 500;
    }

    .nav-item:hover {
        background-color: rgba(255, 255, 255, 0.15);
        transform: translateY(-2px);
    }

    .nav-icon {
        width: 20px;
        height: 20px;
        margin-right: 6px;
        vertical-align: middle;
        stroke: #00c9ff;
    }

    @media (max-width: 768px) {
        .nav-menu {
            flex-direction: column;
            gap: 12px;
        }
    }
</style>

<!-- Student Navbar -->
<nav class="navbar">
    <!-- Logo + Brand Centered -->
    <div class="navbar-brand-container" onclick="location.href='${pageContext.request.contextPath}/student/dashboard'">
        <svg class="logo-svg" viewBox="0 0 64 64">
            <circle cx="32" cy="32" r="28" stroke-linejoin="round"/>
            <line x1="20" y1="32" x2="44" y2="32"/>
            <line x1="32" y1="20" x2="32" y2="44"/>
        </svg>
        <span class="navbar-brand">Student Portal</span>
    </div>

    <!-- Right-side Menu -->
    <div class="right-side">
        <div class="nav-menu">

            <!-- Dashboard -->
            <div class="nav-item" onclick="location.href='home'">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 12l2-2 4 4 8-8 4 4v6H3z"/>
                </svg> Dashboard
            </div>

            <!-- Start Exam -->
            <div class="nav-item" onclick="location.href='exam'">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"/>
                    <polygon points="10 8 16 12 10 16 10 8"/>
                </svg> Start Exam
            </div>

            <!-- Results -->
            <div class="nav-item" onclick="location.href='result'">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 4h16v16H4z"/>
                    <polyline points="8 12 10.5 14.5 16 9"/>
                </svg> Results
            </div>

            <!-- Profile -->
            <div class="nav-item" onclick="location.href='${pageContext.request.contextPath}/profile'">
                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="7" r="4"/>
                    <path d="M5.5 21h13a2 2 0 0 0-13 0z"/>
                </svg> Profile
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

<!-- Logout Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background: linear-gradient(to right, #1f1c2c, #928dab); color: #fff; border: none;">
            <div class="modal-header" style="border-bottom: 1px solid rgba(255,255,255,0.1);">
                <h5 class="modal-title" id="logoutModalLabel">🔒 Confirm Logout</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to logout from your student account?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="confirmLogout()">Yes, Logout</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function showLogoutModal() {
        const modal = new bootstrap.Modal(document.getElementById('logoutModal'));
        modal.show();
    }

    function confirmLogout() {
        window.location.href = '${pageContext.request.contextPath}/logout';
    }
</script>
