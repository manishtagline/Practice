package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.Question;

import java.util.List;

public interface QuestionService {

    void saveQuestion(Question question);

    Question getQuestionById(Long id);

    Question updateQuestion(Long id, Question question);

    void softDeleteQuestion(Long id);

    List<Question> getFilteredAndSortedQuestions(Long subjectId, String complexity, String sortBy, int page, int size);

    int countFilteredQuestions(Long subjectId, String complexity);


}
