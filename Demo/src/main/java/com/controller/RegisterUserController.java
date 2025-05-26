package com.controller;

import com.dao.UserDao;
import com.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterUserController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String password = req.getParameter("password");

        User user = new User(name,phone,email,address,password);

        UserDao dao = new UserDao();

        int n =  dao.insertUser(user);

        if(n >0){
            req.setAttribute("success","User successfully register...");
            req.getRequestDispatcher("message.jsp").forward(req,resp);
        }else{
            req.setAttribute("fail","Something went wrong!!!!");
            req.getRequestDispatcher("message.jsp").forward(req,resp);
        }

    }
}
