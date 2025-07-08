package com.example.questionbanksite.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthInterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();

        // Public endpoints — no login needed
        if (uri.equals(contextPath + "/") ||
                uri.equals(contextPath + "/logout") ||
                uri.equals(contextPath + "/login") ||
                uri.equals(contextPath + "/baseUserRegister") ||
                uri.equals(contextPath + "/baseUserRegistration")) {
            return true;
        }

        if (session == null) {
            response.sendRedirect(contextPath + "/");
            return false;
        }

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || role == null) {
            session.setAttribute("error", "Please, Login first!!!");
            response.sendRedirect(contextPath + "/");
            return false;
        }

        // TEACHER must have a teacher attribute in session
        if (role.equalsIgnoreCase("TEACHER") && session.getAttribute("teacher") == null) {
            session.setAttribute("error", "Please, Login first!!!");
            response.sendRedirect(contextPath + "/");
            return false;
        }

        // Define role-specific URL prefixes
        boolean isAdminUrl = uri.startsWith(contextPath + "/admin") ;

        boolean isUserUrl = uri.startsWith(contextPath + "/user") ||
                uri.startsWith(contextPath + "/exam") ||
                uri.startsWith(contextPath + "/result") ||
                uri.startsWith(contextPath + "/home") ||
                uri.startsWith(contextPath + "/submitExam");

        boolean isTeacherUrl = uri.startsWith(contextPath + "/teacher");

        // Restrict access based on role
        switch (role.toUpperCase()) {
            case "ADMIN":
                if (isUserUrl || isTeacherUrl) {
                    session.setAttribute("error", "Unauthorized Access!");
                    response.sendRedirect(contextPath + "/");
                    return false;
                }
                break;

            case "USER":
                if (isAdminUrl || isTeacherUrl) {
                    session.setAttribute("error", "Unauthorized Access!");
                    response.sendRedirect(contextPath + "/");
                    return false;
                }
                break;

            case "TEACHER":
                if (isAdminUrl || isUserUrl) {
                    session.setAttribute("error", "Unauthorized Access!");
                    response.sendRedirect(contextPath + "/");
                    return false;
                }
                break;

            default:
                session.setAttribute("error", "Unknown role!");
                response.sendRedirect(contextPath + "/");
                return false;
        }

        return true;
    }
}
