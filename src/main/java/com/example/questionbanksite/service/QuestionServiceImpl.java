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
    public void saveQuestion(Question question) {
        entityManager.persist(question);
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
    public void softDeleteQuestion(Long id) {
        Question question = entityManager.find(Question.class, id);
        if (question != null) {
            question.setDeleted(true);
            entityManager.merge(question);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<Question> getQuestionBySubjectWithPagination(Long subjectId, int page, int size) {
        return entityManager.createQuery(
                "SELECT q FROM Question q WHERE q.subject.id = :subjectId AND q.deleted = false ORDER BY q.id",
                Question.class
        ).setParameter("subjectId", subjectId)
         .setFirstResult((page - 1) * size)
         .setMaxResults(size)
         .getResultList();
    }

    @Override
    public int countQuestionBySubject(Long subjectId) {
        Long count = entityManager.createQuery(
            "SELECT COUNT(q) FROM Question q WHERE q.subject.id = :subjectId AND q.deleted = false ",
                Long.class
        ).setParameter("subjectId",subjectId)
         .getSingleResult();
        return count.intValue();
    }

}
