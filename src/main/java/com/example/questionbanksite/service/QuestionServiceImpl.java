package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.Question;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public void saveQuestion(List<Question> questions) {
        for (Question question : questions) {
            entityManager.persist(question);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<Question> getAllQuestion() {
        return entityManager.createQuery("SELECT q FROM Question q", Question.class).getResultList();
    }


}
