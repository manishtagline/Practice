package com.example.questionbanksite.service;


import com.example.questionbanksite.entity.Exam;

import java.util.List;

public interface ExamService {


    Exam saveExam(Exam exam);

    List<Exam> getAllExam();

    Exam getExamById(Long examId);

}
