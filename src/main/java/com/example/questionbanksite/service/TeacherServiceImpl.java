package com.example.questionbanksite.service;

import com.example.questionbanksite.dto.BaseUserRegisterDto;
import com.example.questionbanksite.entity.Teacher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Service
public class TeacherServiceImpl implements TeacherService{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public int saveTeacher(BaseUserRegisterDto baseTeacher) {
        Teacher teacher = new Teacher();
        teacher.setUsername(baseTeacher.getUsername());
        teacher.setPassword(baseTeacher.getPassword());
        teacher.setEmail(baseTeacher.getEmail());
        teacher.setRole(baseTeacher.getRole());

        entityManager.persist(teacher);
        return 1;
    }

}
