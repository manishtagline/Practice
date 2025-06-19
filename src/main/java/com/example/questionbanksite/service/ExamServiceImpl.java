package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.Exam;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;


@Service
public class ExamServiceImpl implements ExamService{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public Exam saveExam(Exam exam) {
        entityManager.persist(exam);
        return exam;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Exam> getAllExam() {
        return entityManager.createQuery("SELECT e FROM Exam e", Exam.class).getResultList();
    }


    @Override
    @Transactional(readOnly = true)
    public Exam getExamById(Long examId) {
        TypedQuery<Exam> query = entityManager.createQuery(
                "SELECT e FROM Exam e LEFT JOIN FETCH e.questions WHERE e.id = :examId", Exam.class);
        query.setParameter("examId", examId);
        return query.getResultStream().findFirst().orElse(null);
    }

}
