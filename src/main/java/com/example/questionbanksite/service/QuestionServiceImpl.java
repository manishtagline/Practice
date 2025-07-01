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
    public List<Question> getFilteredAndSortedQuestions(Long subjectId, String complexity, String sortBy, int page, int size) {
        StringBuilder queryBuilder = new StringBuilder("SELECT q FROM Question q WHERE q.subject.id = :subjectId AND q.deleted = false");

        if (complexity != null && !complexity.isEmpty()) {
            queryBuilder.append(" AND q.complexity = :complexity");
        }

        if (sortBy != null) {
            switch (sortBy) {
                case "marks":
                case "complexity":
                    queryBuilder.append(" ORDER BY q.").append(sortBy);
                    break;
                default:
                    queryBuilder.append(" ORDER BY q.id");
            }
        } else {
            queryBuilder.append(" ORDER BY q.id");
        }

        var query = entityManager.createQuery(queryBuilder.toString(), Question.class);
        query.setParameter("subjectId", subjectId);

        if (complexity != null && !complexity.isEmpty()) {
            query.setParameter("complexity", complexity);
        }

        query.setFirstResult((page - 1) * size);
        query.setMaxResults(size);

        return query.getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public int countFilteredQuestions(Long subjectId, String complexity) {
        StringBuilder queryBuilder = new StringBuilder("SELECT COUNT(q) FROM Question q WHERE q.subject.id = :subjectId AND q.deleted = false");

        if (complexity != null && !complexity.isEmpty()) {
            queryBuilder.append(" AND q.complexity = :complexity");
        }

        var query = entityManager.createQuery(queryBuilder.toString(), Long.class);
        query.setParameter("subjectId", subjectId);

        if (complexity != null && !complexity.isEmpty()) {
            query.setParameter("complexity", complexity);
        }

        return query.getSingleResult().intValue();
    }


}
