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
    @Override
    @Transactional(readOnly = true)
    public Question getQuestionById(Long id) {
        return entityManager.find(Question.class, id);
    }

    @Override
    @Transactional
    public Question updateQuestion(Long id, Question updatedQuestion) {
        Question existingQuestion = entityManager.find(Question.class, id);
        if (existingQuestion != null) {
            existingQuestion.setQuestiondDesc(updatedQuestion.getQuestiondDesc());
            existingQuestion.setOptions(updatedQuestion.getOptions());
            existingQuestion.setMarks(updatedQuestion.getMarks());
            existingQuestion.setCorrectAnswer(updatedQuestion.getCorrectAnswer());
            existingQuestion.setComplexity(updatedQuestion.getComplexity());
            existingQuestion.setSubject(updatedQuestion.getSubject());

            entityManager.merge(existingQuestion);
        }
        return existingQuestion;
    }

    @Override
    @Transactional
    public void deleteQuestion(Long id) {
        Question question = entityManager.find(Question.class, id);
        if (question != null) {
            entityManager.remove(question);
        }
    }

}
