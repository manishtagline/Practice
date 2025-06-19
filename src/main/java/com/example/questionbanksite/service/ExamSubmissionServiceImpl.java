package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.Question;
import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.entity.UserResult;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;
import java.util.Map;

@Service
public class ExamSubmissionServiceImpl implements ExamSubmissionService{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public UserResult evaluateAndSaveResult(User user, Long examId, Map<String, String> answersMap) {

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
        return result;
    }

}
