package com.example.questionbanksite.service;


import com.example.questionbanksite.entity.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import java.util.List;

@Service
public class UserServiceImpl implements UserService{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public User saveUser(User user) {
        entityManager.persist(user);
        return user;
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getAllUser() {
        return entityManager.createQuery("SELECT u FROM User u", User.class).getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public User getUserByName(String username) {
        try {
            return entityManager.createQuery(
                    "SELECT u FROM User u WHERE u.username = :username", User.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
