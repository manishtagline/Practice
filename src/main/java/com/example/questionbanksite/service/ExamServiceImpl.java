package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;


@Service
public class ExamServiceImpl implements ExamService{

    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private UserService userService;

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

    @Override
    @Transactional
    public UserResult evaluateAndSaveResult(String username, Long examId, Map<String, String> answersMap) {
        User user = userService.getUserByName(username);

        Exam exam = entityManager.find(Exam.class, examId);
        if (exam == null) {
            throw new IllegalArgumentException("Invalid exam ID: " + examId);
        }

        List<Question> questionList = exam.getQuestions();
        int totalScore = 0;

        StringBuilder answerLog = new StringBuilder();

        for (Question question : questionList) {
            String userAnswer = answersMap.get("answers[" + question.getId() + "]");
            if (userAnswer != null && userAnswer.equalsIgnoreCase(question.getCorrectAnswer())) {
                totalScore += question.getMarks();
            }

            answerLog.append("Q").append(question.getId()).append(": ").append(userAnswer).append(" | ");
        }

        double percentage = (exam.getTotalMarks() > 0)
                ? ((double) totalScore / exam.getTotalMarks()) * 100
                : 0;

        UserResult result = new UserResult();
        result.setUser(user);
        result.setExam(exam);
        result.setTotalScore(totalScore);
        result.setPercentage(percentage);
        result.setAnswer(answerLog.toString());

        entityManager.persist(result);
        user.getExams().add(exam);
        exam.getUsers().add(user);

        entityManager.merge(exam);
        entityManager.merge(user);

        return result;
    }

}
