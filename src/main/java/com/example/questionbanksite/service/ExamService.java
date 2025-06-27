package com.example.questionbanksite.service;


import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.entity.UserResult;

import java.util.List;
import java.util.Map;

public interface ExamService {

    List<Exam> getAllExam();

    Exam getExamById(Long examId);

    int createExamForSubject(Long subjectId, String description, Long targetTotalMarks);

    UserResult evaluateAndSaveResult(String username, Long examId, Map<String, String> answersMap);


}
