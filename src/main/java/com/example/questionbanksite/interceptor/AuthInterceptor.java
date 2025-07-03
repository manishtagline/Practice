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

        if(uri.equals(contextPath + "/") || uri.equals(contextPath + "/login") || uri.equals(contextPath + "/baseUserRegister")
            || uri.equals(contextPath + "/baseUserRegistration")){
            return true;
        }

        if(session == null){
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

        if ((uri.startsWith(contextPath + "/admin") || uri.startsWith(contextPath + "/subjectList")
                || uri.startsWith(contextPath + "/addSubjectPage") || uri.startsWith(contextPath + "/addExamPage")
                || uri.startsWith(contextPath + "/examList") || uri.startsWith(contextPath + "/userList")
                || uri.startsWith(contextPath + "/manageQuestions") || uri.startsWith(contextPath + "/addQuestionPage")
                || uri.startsWith(contextPath + "/editSubject") || uri.startsWith(contextPath + "/editQuestion")
                || uri.startsWith(contextPath + "/viewExamDetails") || uri.startsWith(contextPath + "/deleteSubject")
                || uri.startsWith(contextPath + "/deleteQuestion") || uri.startsWith(contextPath + "/updateSubject")
                || uri.startsWith(contextPath + "/updateQuestion")
        ) && role.equalsIgnoreCase("USER")) {
            session.setAttribute("error", "Unauthorized Access!");
            response.sendRedirect(contextPath + "/");
            return false;
        }

        if (role.equalsIgnoreCase("ADMIN")) {
            boolean blockedForAdmin = (
                    (uri.startsWith(contextPath + "/user") && !uri.equals(contextPath + "/userList")) ||
                            (uri.startsWith(contextPath + "/exam") && !uri.equals(contextPath + "/examList")) ||
                            uri.startsWith(contextPath + "/result") ||
                            uri.startsWith(contextPath + "/home") ||
                            uri.startsWith(contextPath + "/submitExam")
            );

            if (blockedForAdmin) {
                session.setAttribute("error", "Unauthorized Access!");
                response.sendRedirect(contextPath + "/");
                return false;
            }
        }

        return true;
    }
}
