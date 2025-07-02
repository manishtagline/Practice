    package com.example.questionbanksite.service;


    import com.example.questionbanksite.dto.ExamDto;
    import com.example.questionbanksite.entity.Exam;
    import com.example.questionbanksite.entity.User;
    import com.example.questionbanksite.entity.UserResult;

    import java.time.LocalDateTime;
    import java.time.ZoneId;
    import java.time.ZonedDateTime;
    import java.util.List;
    import java.util.Map;

    public interface ExamService {

        List<ExamDto> getAllExam();

        Exam getExamById(Long examId);

        int createExamForSubject(Long subjectId, String description, Long targetTotalMarks, LocalDateTime enrolledStartDate, LocalDateTime enrolledEndDate,
                                 LocalDateTime examStartDate, LocalDateTime examEndDate, ZoneId zoneId);

        UserResult evaluateAndSaveResult(String username, Long examId, Map<String, String> answersMap);


    }
