package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.entity.UserResult;

import java.util.Map;

public interface ExamSubmissionService {

    UserResult evaluateAndSaveResult(User user, Long examId, Map<String, String> answersMap);

}
