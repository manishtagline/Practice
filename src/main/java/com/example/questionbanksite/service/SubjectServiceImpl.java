package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.Subject;
import com.example.questionbanksite.entity.Teacher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import java.util.List;

@Service
public class SubjectServiceImpl implements SubjectService {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public int saveSubject(Subject subject) {
        entityManager.persist(subject);
        return 1;
    }

    @Override
    @Transactional(readOnly = true)
    public Subject getSubjectById(Long id) {
        try{
            return entityManager.createQuery("SELECT s FROM Subject s WHERE s.id = :id", Subject.class)
                    .setParameter("id", id)
                    .getSingleResult();
        }catch (NoResultException e){
            return null;
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<Subject> getAllSubjects() {
        return entityManager.createQuery("SELECT s FROM Subject s", Subject.class).getResultList();
    }


    @Override
    @Transactional
    public Subject updateSubject(Long id, Subject subject) {
        Subject existing = entityManager.find(Subject.class, id);
        if (existing != null) {
            existing.setName(subject.getName());
            existing.setQuestions(subject.getQuestions());
            existing.setExams(subject.getExams());
            return entityManager.merge(existing);
        }
        return null;
    }

    @Override
    @Transactional
    public void deleteSubject(Long id) {
        Subject subject = entityManager.find(Subject.class, id);
        if (subject != null) {
            entityManager.remove(subject);
        }
    }
}
