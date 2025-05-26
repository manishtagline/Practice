package com.controller;

import com.dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/delete")
public class DeleteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int uid = Integer.parseInt(req.getParameter("uid"));

        UserDao dao = new UserDao();
        int i = dao.deleteUser(uid);

        if(i >0){
            req.setAttribute("success","User deleted successfully...");
            req.getRequestDispatcher("message.jsp").forward(req,resp);
        }else{
            req.setAttribute("fail","Something went wrong!!!!");
            req.getRequestDispatcher("message.jsp").forward(req,resp);
        }

    }
}
