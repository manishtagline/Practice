package com.example.questionbanksite.service;

import com.example.questionbanksite.dto.ExamDto;
import com.example.questionbanksite.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@Service
public class ExamServiceImpl implements ExamService{

    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private UserService userService;

    @Override
    @Transactional(readOnly = true)
    public List<ExamDto> getAllExam() {
        List<Exam> exams = entityManager.createQuery("SELECT e FROM Exam e", Exam.class).getResultList();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

        return exams.stream()
                .map(
                        exam -> ExamDto.builder()
                                .id(exam.getId())
                                .description( exam.getDescription())
                                .totalMarks(exam.getTotalMarks())
                                .totalNumberOfQuestion(exam.getTotalNumberOfQuestion())
                                .subjectName(exam.getSubject().getName())
                                .formattedDate( exam.getDateCreated().format(formatter))
                                .enrolledStartDate(exam.getEnrolledStartDate() != null ? exam.getEnrolledStartDate().toLocalDateTime() : null)
                                .enrolledEndDate(exam.getEnrolledEndDate() != null ? exam.getEnrolledEndDate().toLocalDateTime() : null)
                                .examStartDate(exam.getExamStartDate() != null ? exam.getExamStartDate().toLocalDateTime() : null)
                                .examEndDate(exam.getExamEndDate() != null ? exam.getExamEndDate().toLocalDateTime() : null)
                                .build()
                )
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<ExamDto> getAllExamOfTeacher(Long teacherId) {
        List<Exam> exams = entityManager.createQuery("SELECT e FROM Exam e WHERE e.teacher.id = :teacherId ", Exam.class)
                .setParameter("teacherId", teacherId)
                .getResultList();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

        return exams.stream()
                .map(
                        exam -> ExamDto.builder()
                        .id(exam.getId())
                        .description(exam.getDescription())
                        .totalMarks(exam.getTotalMarks())
                        .totalNumberOfQuestion(exam.getTotalNumberOfQuestion())
                        .subjectName(exam.getSubject().getName())
                        .formattedDate(exam.getDateCreated().format(formatter))
                        .build()
                )
                .collect(Collectors.toList());
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
        user.getCompletedExams().add(exam);
        exam.getCompletedUsers().add(user);

        entityManager.merge(exam);
        entityManager.merge(user);

        return result;
    }
    @Override
    @Transactional
    public int createExamForSubject(Long subjectId, String description, Long targetTotalMarks, LocalDateTime enrolledStartDate, LocalDateTime enrolledEndDate,
                                    LocalDateTime examStartDate, LocalDateTime examEndDate, ZoneId zoneId) {

        ZonedDateTime enrolledStart = enrolledStartDate.atZone(zoneId).withZoneSameInstant(ZoneOffset.UTC);
        ZonedDateTime enrolledEnd = enrolledEndDate.atZone(zoneId).withZoneSameInstant(ZoneOffset.UTC);
        ZonedDateTime examStart = examStartDate.atZone(zoneId).withZoneSameInstant(ZoneOffset.UTC);
        ZonedDateTime examEnd = examEndDate.atZone(zoneId).withZoneSameInstant(ZoneOffset.UTC);

        ZonedDateTime now = ZonedDateTime.now(zoneId);

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
        exam.setEnrolledStartDate(enrolledStart);
        exam.setEnrolledEndDate(enrolledEnd);
        exam.setExamStartDate(examStart);
        exam.setExamEndDate(examEnd);
        exam.setDateCreated(now);
        exam.setCreatedByTeacher(false);
        exam.setCreatedByAdmin(true);

        entityManager.persist(exam);
        return 1;
    }

    @Override
    @Transactional
    public int createExamForSubjectByTeacher(Long teacherId, Long subjectId, String description, Long targetTotalMarks, LocalDateTime enrolledStartDate, LocalDateTime enrolledEndDate,
                                             LocalDateTime examStartDate, LocalDateTime examEndDate, ZoneId zoneId) {

        ZonedDateTime enrolledStart = enrolledStartDate.atZone(zoneId);
        ZonedDateTime enrolledEnd = enrolledEndDate.atZone(zoneId);
        ZonedDateTime examStart = examStartDate.atZone(zoneId);
        ZonedDateTime examEnd = examEndDate.atZone(zoneId);

        ZonedDateTime now = ZonedDateTime.now(zoneId);

        Subject subject = entityManager.find(Subject.class, subjectId);
        if (subject == null) {
            throw new IllegalArgumentException("Subject not found with ID: " + subjectId);
        }

        Teacher teacher = entityManager.find(Teacher.class, teacherId);
        if( teacher == null){
            throw new IllegalArgumentException("Teacher not found with Id:"+ teacherId);
        }

        TypedQuery<Question> query = entityManager.createQuery(
                "SELECT q FROM Question q WHERE q.subject.id = :subjectId", Question.class
        ).setParameter("subjectId", subjectId);

        List<Question> questionList = query.getResultList();

        if(questionList.isEmpty()){
            throw new RuntimeException("No question available for subject id:"+subjectId);
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
        exam.setTeacher(teacher);
        exam.setCreatedByTeacher(true);
        exam.setCreatedByAdmin(false);
        exam.setDescription(description);
        exam.setSubject(subject);
        exam.setQuestions(selectedQuestions);
        exam.setTotalNumberOfQuestion(numberOfQuestion);
        exam.setTotalMarks((long) accumulatedMarks);
        exam.setEnrolledStartDate(enrolledStart);
        exam.setEnrolledEndDate(enrolledEnd);
        exam.setExamStartDate(examStart);
        exam.setExamEndDate(examEnd);
        exam.setDateCreated(now);

        entityManager.persist(exam);
        return 1;
    }



    @Override
    @Transactional
    public String enrollUserInExam(String username, Long examId) {

        User user = entityManager.createQuery(
                "SELECT u FROM User u LEFT JOIN FETCH u.enrolledExams WHERE u.username = :username", User.class)
                .setParameter("username", username)
                .getSingleResult();

        Exam exam = entityManager.createQuery(
                "SELECT e FROM Exam e LEFT JOIN FETCH e.enrolledUsers WHERE e.id = :examId", Exam.class)
                .setParameter("examId", examId)
                .getSingleResult();


        // Already enrolled
        if (exam.getEnrolledUsers().contains(user)) {
            return "already_enrolled";
        }

        // Enroll the user
        exam.getEnrolledUsers().add(user);
        user.getEnrolledExams().add(exam);

        entityManager.merge(user);
        entityManager.merge(exam);

        return "success";
    }

    @Override
    @Transactional
    public boolean isUserEnrolledInExam(Long userId, Long examId) {
        Exam exam = getExamById(examId);
        return exam.getEnrolledUsers().stream().anyMatch(u -> u.getId().equals(userId));
    }

    @Transactional(readOnly = true)
    public boolean hasUserCompletedExam(Long userId, Long examId) {
        Exam exam = getExamById(examId);
        return exam.getCompletedUsers().stream().anyMatch(u -> u.getId().equals(userId));
    }


    @Override
    @Transactional(readOnly = true)
    public List<Exam> getTodayAndFutureExamsForUser(Long userId) {
        ZonedDateTime nowUtc = ZonedDateTime.now(ZoneOffset.UTC);

        TypedQuery<Exam> query = entityManager.createQuery(
                "SELECT e FROM Exam e JOIN e.enrolledUsers u " +
                        "WHERE u.id = :userId AND e.examEndDate >= :now " +
                        "ORDER BY e.examStartDate ASC", Exam.class);

        query.setParameter("userId", userId);
        query.setParameter("now", nowUtc);

        return query.getResultList();
    }


    @Override
    @Transactional(readOnly = true)
    public List<Exam> getTodayExamsForUser(Long userId) {
        ZonedDateTime nowUtc = ZonedDateTime.now(ZoneOffset.UTC);

        TypedQuery<Exam> query = entityManager.createQuery(
                "SELECT e FROM Exam e " +
                        "JOIN e.enrolledUsers u " +
                        "WHERE u.id = :userId " +
                        "AND e.examStartDate <= :now " +
                        "AND e.examEndDate >= :now " +
                        "AND :userId NOT IN (SELECT cu.id FROM e.completedUsers cu) " +
                        "ORDER BY e.examStartDate ASC", Exam.class
        );


        query.setParameter("userId", userId);
        query.setParameter("now", nowUtc);

        return query.getResultList();
    }

    @Override
    public List<ExamDto> getActiveExam(ZonedDateTime nowUserZone) {

        ZonedDateTime nowUtc = nowUserZone.withZoneSameInstant(ZoneOffset.UTC);

        List<Exam> exams = entityManager.createQuery(
                "SELECT e FROM Exam e WHERE e.enrolledEndDate IS NULL OR e.enrolledEndDate >= :now ORDER BY e.enrolledStartDate ASC", Exam.class)
                .setParameter("now", nowUtc)
                .getResultList();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

        return exams.stream()
                .map(exam -> ExamDto.builder()
                        .id(exam.getId())
                        .description(exam.getDescription())
                        .totalMarks(exam.getTotalMarks())
                        .totalNumberOfQuestion(exam.getTotalNumberOfQuestion())
                        .subjectName(exam.getSubject().getName())
                        .formattedDate(exam.getDateCreated().format(formatter))
                        .enrolledStartDate(exam.getEnrolledStartDate() != null ? exam.getEnrolledStartDate().toLocalDateTime() : null)
                        .enrolledEndDate(exam.getEnrolledEndDate() != null ? exam.getEnrolledEndDate().toLocalDateTime() : null)
                        .examStartDate(exam.getExamStartDate() != null ? exam.getExamStartDate().toLocalDateTime() : null)
                        .examEndDate(exam.getExamEndDate() != null ? exam.getExamEndDate().toLocalDateTime() : null)
                        .build())
                .collect(Collectors.toList());

    }


}
