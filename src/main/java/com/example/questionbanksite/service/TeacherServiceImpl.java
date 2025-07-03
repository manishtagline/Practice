package com.example.questionbanksite.service;

import com.example.questionbanksite.dto.BaseUserRegisterDto;
import com.example.questionbanksite.dto.TeacherDto;
import com.example.questionbanksite.entity.Subject;
import com.example.questionbanksite.entity.Teacher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;
import java.util.stream.Collectors;

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

    @Override
    public List<TeacherDto> getAllTeachers() {
        List<Teacher> teachers = entityManager.createQuery("SELECT t FROM Teacher t", Teacher.class).getResultList();

        return teachers.stream().map(teacher -> {
            String subjectName = (teacher.getSubject() != null) ? teacher.getSubject().getName() : null;
            return new TeacherDto(
                    teacher.getId(),
                    teacher.getUsername(),
                    teacher.getEmail(),
                    teacher.getRole(),
                    subjectName
            );
        }).collect(Collectors.toList());
    }

}
