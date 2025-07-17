package com.example.questionbanksite.service;

import com.example.questionbanksite.dto.UserExamSummaryDto;
import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.UserResult;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Override
    @Transactional(readOnly = true)
    public UserExamSummaryDto getUserExamSummary(Long userId) {
        UserExamSummaryDto stats = new UserExamSummaryDto();

        Long enrolledCount = entityManager.createQuery(
                "SELECT COUNT(e) FROM Exam e JOIN e.enrolledUsers u WHERE u.id = :userId", Long.class)
                .setParameter("userId", userId)
                .getSingleResult();

        Long completedCount = entityManager.createQuery(
                "SELECT COUNT(e) FROM Exam e JOIN e.completedUsers u WHERE u.id = :userId", Long.class)
                .setParameter("userId", userId)
                .getSingleResult();

        int pendingCount = completedCount.intValue() - enrolledCount.intValue();

        stats.setEnrolledCount(enrolledCount.intValue());
        stats.setCompletedCount(completedCount.intValue());
        stats.setPendingCount(pendingCount);

        List<UserResult> results = entityManager.createQuery(
                "SELECT r FROM UserResult r WHERE r.user.id = :userId", UserResult.class)
                .setParameter("userId", userId)
                .getResultList();

        int totalCorrect = 0;
        int totalWrong = 0;
        double totalPercentSum = 0.0;
        int countResultsWithPercent = 0;

        for (UserResult ur : results) {

            Exam exam = entityManager.createQuery(
                    "SELECT e FROM Exam e JOIN FETCH e.questions WHERE e.id = :examId", Exam.class)
                    .setParameter("examId", ur.getExam().getId())
                    .getResultStream().findFirst().orElse(null);

            if (exam == null) continue;

            Map<Long, String> userAnswers = parseAnswerString(ur.getAnswer());

            for (var q : exam.getQuestions()) {
                String correctAnswer = q.getCorrectAnswer();
                String userAnswer = userAnswers.get(q.getId());
                if (userAnswer == null || userAnswer.trim().isEmpty()) continue;

                if (userAnswer.equalsIgnoreCase(correctAnswer)) totalCorrect++;
                else totalWrong++;
            }

            if (ur.getPercentage() > 0) {
                totalPercentSum += ur.getPercentage();
                countResultsWithPercent++;
            }
        }

        stats.setTotalCorrectAnswers(totalCorrect);
        stats.setTotalWrongAnswers(totalWrong);
        stats.setOverallPercentage(countResultsWithPercent == 0 ? 0.0 : totalPercentSum / countResultsWithPercent);

        return stats;
    }

    private Map<Long, String> parseAnswerString(String answerString) {
        Map<Long, String> map = new HashMap<>();

        if(answerString == null || answerString.isEmpty()) return map;

        String[] pairs = answerString.split("\\|");

        for(String pair : pairs ){
            int colonIndex = pair.indexOf(":");
            int qIndex = pair.indexOf("Q");

            if (qIndex >= 0 && colonIndex > qIndex) {
                try {
                    String questionIdStr = pair.substring(qIndex + 1, colonIndex).trim();
                    Long questionId = Long.parseLong(questionIdStr);
                    String answer = pair.substring(colonIndex + 1).trim();
                    map.put(questionId, answer);
                } catch (NumberFormatException e) {
                    // ignore malformed data
                }
            }
        }
        return map;
    }



}
