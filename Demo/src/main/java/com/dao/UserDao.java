package com.dao;

import com.entity.User;
import jakarta.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import java.util.List;

public class UserDao {

    SessionFactory session = null;

    public UserDao() {
        session = new Configuration()
                .configure("hibernate.cfg.xml")
                .addAnnotatedClass(User.class)
                .buildSessionFactory();
    }

    public int insertUser(User user){
        int num = 0;
        Transaction tx = null;
        try{
            Session s = session.openSession();
            tx = s.beginTransaction();
            s.persist(user);

            num = 1;
            tx.commit();
            s.close();
        }catch (Exception e){
            tx.rollback();
        }
        return num;
    }

    public List<User> viewAllUser(){
        Session s = session.openSession();
        Transaction tx = s.beginTransaction();
        List<User> list = s.createQuery("from User", User.class).list();
        tx.commit();
        s.close();
        return list;
    }

    public int deleteUser(int id){
        int num = 0;
        try {
            Session s = session.openSession();
            Transaction tx = s.beginTransaction();
            User t = s.get(User.class, id);
            s.delete(t);
            tx.commit();
            num =1;
        }catch (Exception e){
            System.out.println(e);
        }
        return num;
    }

}
