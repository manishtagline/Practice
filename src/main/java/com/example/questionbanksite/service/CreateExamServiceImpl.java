package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.Question;
import com.example.questionbanksite.entity.Subject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class CreateExamServiceImpl  implements CreateExamService{

    @PersistenceContext
    private EntityManager entityManager;


    @Override
    @Transactional
    public Exam createExamForSubject(Long subjectId, String description, int targetTotalMarks) {
        Subject subject = entityManager.find(Subject.class, subjectId);
        if (subject == null) {
            throw new IllegalArgumentException("Subject not found with ID: " + subjectId);
        }

        TypedQuery<Question> query = entityManager.createQuery(
                "SELECT q FROM Question q WHERE q.subject.id = :subjectId", Question.class);
        query.setParameter("subjectId", subjectId);
        List<Question> questionList = query.getResultList();

        if (questionList.isEmpty()) {
            throw new RuntimeException("No questions available for subject ID: " + subjectId);
        }

        Collections.shuffle(questionList);

        int accumulatedMarks = 0;
        List<Question> selectedQuestions = new ArrayList<>();

        for (Question q : questionList) {
            if (accumulatedMarks + q.getMarks() <= targetTotalMarks) {
                selectedQuestions.add(q);
                accumulatedMarks += q.getMarks();
            }
            if (accumulatedMarks == targetTotalMarks) {
                break;
            }
        }

        if (accumulatedMarks == 0) {
            throw new RuntimeException("No questions could fit into the target total marks: " + targetTotalMarks);
        }

        int numberOfQuestion = selectedQuestions.size();

        Exam exam = new Exam();
        exam.setDescription(description);
        exam.setSubject(subject);
        exam.setQuestions(selectedQuestions);
        exam.setTotalNumberOfQuestion(numberOfQuestion);
        exam.setTotalMarks((long) accumulatedMarks);

        entityManager.persist(exam);
        return exam;
    }

}
