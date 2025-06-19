package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.Exam;

import java.util.List;

public interface CreateExamService {

//    Exam createExamForSubject(Long subjectId, String description, int numberOfQuestions);

    Exam createExamForSubject(Long subjectId, String description, int targetTotalMarks);



}
