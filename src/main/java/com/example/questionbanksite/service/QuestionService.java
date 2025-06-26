package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.Question;

import java.util.List;

public interface QuestionService {

    void saveQuestion(Question question);

    Question getQuestionById(Long id);

    Question updateQuestion(Long id, Question question);

    void softDeleteQuestion(Long id);

    List<Question> getQuestionBySubjectWithPagination(Long subjectId, int page, int size);

    int countQuestionBySubject(Long subjectId);

}
