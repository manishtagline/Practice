package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.UserResult;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Service
public class UserResultServiceImpl implements UserResultService{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public List<UserResult> getResultsByUserId(Long userId) {
        String jpql = "SELECT r FROM UserResult r WHERE r.user.id = :userId";
        TypedQuery<UserResult> query = entityManager.createQuery(jpql, UserResult.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }


    @Override
    @Transactional(readOnly = true)
    public UserResult getResultDetailsById(Long resultId) {
        String jpql = "SELECT r FROM UserResult r " +
                "LEFT JOIN FETCH r.exam e " +
                "LEFT JOIN FETCH e.questions " +
                "WHERE r.id = :resultId";
        TypedQuery<UserResult> query = entityManager.createQuery(jpql, UserResult.class);
        query.setParameter("resultId", resultId);
        return query.getResultStream().findFirst().orElse(null);
    }


}
