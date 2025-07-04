<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
  .navbarTeacher {
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(to right, #1f1c2c, #928dab);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.6);
    padding: 0 2rem;
    height: 80px;
    z-index: 10;
  }

  .navbarTeacher-brand-container {
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
    animation: logo-spin 4s linear infinite;
  }

  .navbarTeacher-brand {
    font-weight: 700;
    font-size: 1.5rem;
    color: #ffffff;
    margin-left: 0.5rem;
  }

  @keyframes logo-spin {
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
    gap: 5px;
    align-items: center;
  }

  .nav-item {
    color: #f0f0f5;
    cursor: pointer;
    padding: 8px 12px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    gap: 6px;
    font-weight: 500;
    transition: background-color 0.3s ease, transform 0.2s ease;
  }

  .nav-item:hover {
    background-color: rgba(255, 255, 255, 0.15);
    transform: translateY(-2px);
  }

  .nav-icon {
    width: 20px;
    height: 20px;
    stroke: #00c9ff;
  }

  .username-badge {
    background: #00c9ff;
    color: #1f1c2c;
    padding: 8px 16px;
    border-radius: 30px;
    font-weight: 600;
    font-size: 1rem;
    user-select: none;
  }

  @media (max-width: 768px) {
    .nav-menu {
      gap: 8px;
      flex-wrap: wrap;
    }
  }
</style>

<nav class="navbarTeacher">
  <!-- Center Logo and Brand -->
  <div class="navbarTeacher-brand-container" onclick="location.href='teacherDashboard'">
    <svg class="logo-svg" viewBox="0 0 64 64" stroke-linejoin="round">
      <rect x="12" y="12" width="40" height="40" rx="8" ry="8" />
      <line x1="12" y1="12" x2="52" y2="52"/>
      <line x1="12" y1="52" x2="52" y2="12"/>
    </svg>
    <span class="navbarTeacher-brand">Teacher Panel</span>
  </div>

  <!-- Right Navigation -->
  <div class="right-side">
    <div class="nav-menu">

      <div class="nav-item" onclick="location.href='teacherDashboard'">
        <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
             stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M3 9l9-7 9 7"/>
          <path d="M9 22V12H15V22"/>
        </svg>
        Dashboard
      </div>

      <div class="nav-item" onclick="location.href='teacherSubjectList'">
        <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
             stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
          <polyline points="17 8 12 3 7 8"/>
          <line x1="12" y1="3" x2="12" y2="15"/>
        </svg>
        Subjects
      </div>

      <div class="nav-item" onclick="location.href='teacherStudentList'">
        <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
             stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M20 21v-2a4 4 0 0 0-3-3.87"/>
          <path d="M4 21v-2a4 4 0 0 1 3-3.87"/>
          <circle cx="12" cy="7" r="4"/>
        </svg>
        Students
      </div>

      <div class="nav-item" onclick="location.href='teacherExamList'">
        <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
             stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
          <line x1="16" y1="2" x2="16" y2="6"/>
          <line x1="8" y1="2" x2="8" y2="6"/>
          <line x1="3" y1="10" x2="21" y2="10"/>
        </svg>
        Exams
      </div>

      <div class="nav-item" onclick="location.href='teacherProfile'">
        <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
             stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="7" r="4"/>
          <path d="M5.5 21h13a2 2 0 0 0-13 0z"/>
        </svg>
        Profile
      </div>

      <div class="nav-item" onclick="showLogoutModal()">
        <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
             stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M16 17l5-5-5-5"/>
          <path d="M21 12H9"/>
          <path d="M12 19H9a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h3"/>
        </svg>
        Logout
      </div>

    </div>
  </div>
</nav>

<!-- Logout Modal (included with navbar) -->
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

<script>
  function showLogoutModal() {
    const modal = new bootstrap.Modal(document.getElementById('logoutModal'));
    modal.show();
  }

  function confirmLogout() {
    window.location.href = 'logout';
  }
</script>
