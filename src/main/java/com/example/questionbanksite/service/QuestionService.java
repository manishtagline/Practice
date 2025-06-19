package com.example.questionbanksite.service;



import com.example.questionbanksite.entity.Question;

import java.util.List;

public interface QuestionService {

    void saveQuestion(List<Question> question);

    List<Question> getAllQuestion();



}
