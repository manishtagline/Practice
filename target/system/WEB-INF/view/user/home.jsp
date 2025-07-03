<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Student Exam Center</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #1f1c2c, #928dab);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      margin: 0;
      color: #f1f1f1;
    }

    .navbar {
      background: rgba(31, 38, 135, 0.8);
      box-shadow: 0 4px 15px rgba(31, 38, 135, 0.6);
      height: 80px;
      padding: 0 2rem;
      position: relative;
      display: flex;
      align-items: center;
      justify-content: center;
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .navbar-brand-container {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%, -50%);
      display: flex;
      align-items: center;
      cursor: pointer;
      user-select: none;
    }

    .navbar-brand {
      font-weight: 700;
      font-size: 1.8rem;
      color: #00c9ff;
      letter-spacing: 2px;
      margin-left: 0.5rem;
      transition: color 0.3s ease;
      text-shadow: 0 0 8px #00c9ffaa;
    }

    .navbar-brand-container:hover .navbar-brand {
      color: #92fe9d;
      text-shadow: 0 0 12px #92fe9daa;
    }

    .logo-svg {
      width: 40px;
      height: 40px;
      stroke: #00c9ff;
      stroke-width: 2;
      fill: none;
      animation: logo-spin 3s linear infinite;
    }

    @keyframes logo-spin {
      from { transform: rotate(0deg); }
      to { transform: rotate(360deg); }
    }

    .username-badge {
      position: absolute;
      right: 2rem;
      top: 50%;
      transform: translateY(-50%);
      background: rgba(255, 255, 255, 0.1);
      color: #00c9ff;
      padding: 8px 20px;
      border-radius: 30px;
      font-weight: 600;
      font-size: 1.1rem;
      box-shadow: 0 3px 10px rgba(0, 201, 255, 0.4);
      animation: fadeInSlide 1.5s ease-out;
      user-select: none;
      letter-spacing: 0.03em;
      text-transform: capitalize;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      cursor: default;
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      border: 1px solid rgba(0, 201, 255, 0.3);
    }

    @keyframes fadeInSlide {
      from { opacity: 0; right: -100px; }
      to { opacity: 1; right: 2rem; }
    }

    .hero {
      flex-grow: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      padding: 4rem 1rem;
      text-align: center;
      max-width: 960px;
      margin: 0 auto;
    }

    .hero h1 {
      font-weight: 700;
      font-size: 3rem;
      margin-bottom: 1rem;
      color: #00c9ff;
      text-shadow: 0 0 10px #00c9ffbb;
    }

    .hero .welcome-user {
      font-size: 1.5rem;
      color: #92fe9d;
      background: rgba(255, 255, 255, 0.1);
      padding: 12px 30px;
      border-radius: 30px;
      font-weight: 600;
      margin-bottom: 2rem;
      box-shadow: 0 4px 10px rgba(146, 254, 157, 0.3);
      user-select: none;
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      border: 1px solid rgba(146, 254, 157, 0.4);
    }

    .hero p {
      color: #ccc;
      font-size: 1.1rem;
      user-select: none;
      text-shadow: 0 0 5px rgba(0,0,0,0.5);
    }

    .card-container {
      display: flex;
      gap: 2rem;
      flex-wrap: wrap;
      justify-content: center;
      margin-top: 2rem;
      max-width: 900px;
      width: 100%;
    }

    .card {
      flex: 1 1 280px;
      border-radius: 1rem;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      background: rgba(255, 255, 255, 0.07);
      box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 2rem 1.5rem;
      border: 1px solid rgba(255, 255, 255, 0.12);
      color: #e0e0ff;
      user-select: none;
    }

    .card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 40px rgba(0, 201, 255, 0.6);
      border-color: #00c9ff;
      background: rgba(255, 255, 255, 0.15);
    }

    .card-icon {
      width: 80px;
      height: 80px;
      margin-bottom: 1rem;
      stroke: #00c9ff;
      fill: none;
      animation: bounce 2s infinite ease-in-out;
    }

    @keyframes bounce {
      0%, 100% { transform: translateY(0); }
      50% { transform: translateY(-15px); }
    }

    .card-title {
      font-weight: 600;
      font-size: 1.3rem;
      margin-bottom: 0.75rem;
      color: #92fe9d;
    }

    .card-text {
      color: #bbb;
      font-size: 1rem;
      text-align: center;
    }

    footer {
      text-align: center;
      padding: 1rem;
      font-size: 0.9rem;
      background: rgba(31, 38, 135, 0.8);
      color: #00c9ff;
      box-shadow: 0 -4px 10px rgba(0, 201, 255, 0.3);
      user-select: none;
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      border-top: 1px solid rgba(255, 255, 255, 0.1);
    }

    @media (max-width: 576px) {
      .hero h1 { font-size: 2rem; }
      .card-container { flex-direction: column; gap: 1.5rem; }
      .username-badge {
        font-size: 1rem;
        padding: 6px 14px;
        right: 1rem;
      }
    }
  </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar">
  <div class="navbar-brand-container" onclick="location.href='home'" role="button" tabindex="0" aria-label="Go to Home">
    <svg class="logo-svg" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg" aria-label="Exam Center Logo" role="img">
      <path d="M8 12h48v40H8z" stroke-linejoin="round" />
      <line x1="8" y1="12" x2="56" y2="12" />
      <line x1="32" y1="12" x2="32" y2="52" />
    </svg>
    <span class="navbar-brand">Exam Center</span>
  </div>
  <div class="username-badge" aria-label="Logged in username">
    Welcome, ${username}
  </div>
</nav>

<!-- Hero Section -->
<section class="hero" role="main" aria-labelledby="main-title">
  <div class="welcome-user" aria-live="polite" aria-atomic="true">
    👋 Hello <strong>${username}</strong>, ready for your next challenge?
  </div>
  <h1 id="main-title">Welcome to the Student Exam Center</h1>
  <p>Your gateway to manage and take exams easily and securely.</p>

  <div class="card-container" role="list">
    <div class="card" onclick="location.href='exam'" role="listitem" tabindex="0" aria-label="Start Exam" onkeypress="if(event.key==='Enter'){location.href='exam'}">
      <svg class="card-icon" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" fill="none"
           stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
        <circle cx="12" cy="12" r="10" />
        <polygon points="10 8 16 12 10 16 10 8" />
      </svg>
      <h5 class="card-title">Start Exam</h5>
      <p class="card-text">Begin your scheduled exams with just a click.</p>
    </div>

    <div class="card" onclick="location.href='result'" role="listitem" tabindex="0" aria-label="View Results" onkeypress="if(event.key==='Enter'){location.href='result'}">
      <svg class="card-icon" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" fill="none"
           stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
        <path d="M12 20h9" />
        <path d="M12 4h9" />
        <path d="M3 12h18" />
        <circle cx="6" cy="12" r="3" />
        <circle cx="18" cy="12" r="3" />
      </svg>
      <h5 class="card-title">View Results</h5>
      <p class="card-text">Check your exam scores and performance history.</p>
    </div>

    <div class="card" role="listitem" tabindex="0" aria-label="Logout"
         onclick="showLogoutModal()" onkeypress="if(event.key==='Enter'){showLogoutModal()}">
      <svg class="card-icon" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" fill="none"
           stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
        <path d="M16 17l5-5-5-5" />
        <path d="M21 12H9" />
        <path d="M12 19H9a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h3" />
      </svg>
      <h5 class="card-title">Logout</h5>
      <p class="card-text">Securely sign out from your account.</p>
    </div>
  </div>
</section>

<!-- Footer -->
<footer>
  &copy; 2025 Student Exam Center. All rights reserved.
</footer>

<!-- Logout Confirmation Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="background: rgba(31, 38, 135, 0.9); border-radius: 1rem; border: 1px solid #00c9ff;">
      <div class="modal-header border-0">
        <h5 class="modal-title" id="logoutModalLabel" style="color: #92fe9d; font-weight: 700;">Confirm Logout</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="color: #e0e0ff; font-size: 1.1rem;">
        Are you sure you want to logout?
      </div>
      <div class="modal-footer border-0">
        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal" style="border-radius: 30px;">Cancel</button>
        <button type="button" id="confirmLogoutBtn" class="btn" style="background: #00c9ff; color: #1f1c2c; border-radius: 30px;">Logout</button>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

  function showLogoutModal() {
    const logoutModal = new bootstrap.Modal(document.getElementById('logoutModal'));
    logoutModal.show();
  }

  document.getElementById('confirmLogoutBtn').addEventListener('click', () => {
    location.href = 'logout';
  });
</script>

</body>
</html>
