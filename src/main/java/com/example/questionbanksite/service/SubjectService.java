package com.example.questionbanksite.service;


import com.example.questionbanksite.entity.Subject;

import java.util.List;

public interface SubjectService {

    List<Subject> saveSubject(List<Subject> subject);

    Subject getSubjectById(Long id);

    List<Subject> getAllSubjects();

    Subject updateSubject(Long id, Subject subject);

    void deleteSubject(Long id);

}
