package com.example.questionbanksite.service;


import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.entity.UserResult;

import java.util.List;
import java.util.Map;

public interface ExamService {


    Exam saveExam(Exam exam);

    List<Exam> getAllExam();

    Exam getExamById(Long examId);

    Exam createExamForSubject(Long subjectId, String description, int targetTotalMarks);

    UserResult evaluateAndSaveResult(User user, Long examId, Map<String, String> answersMap);


}
