package com.example.questionbanksite.service;

import com.example.questionbanksite.dto.BaseUserRegisterDto;
import com.example.questionbanksite.dto.TeacherDto;
import com.example.questionbanksite.entity.Subject;
import com.example.questionbanksite.entity.Teacher;
import com.example.questionbanksite.entity.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
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
    @Transactional(readOnly = true)
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

    @Override
    @Transactional(readOnly = true)
    public Teacher getTeacherByName(String username) {
        try{
            return entityManager.createQuery("SELECT t FROM Teacher t WHERE t.username = :username", Teacher.class)
                    .setParameter("username", username)
                    .getSingleResult();
        }catch (NoResultException e){
            return null;
        }
    }

    @Override
    @Transactional(readOnly = true)
    public Teacher getTeacherByEmail(String email) {
        try{
            return entityManager.createQuery("SELECT t FROM Teacher t WHERE t.email = :email", Teacher.class)
                    .setParameter("email", email)
                    .getSingleResult();
        }catch (NoResultException e){
            return null;
        }
    }

    @Override
    @Transactional(readOnly = true)
    public Teacher getTeacherById(Long teacherId) {
        try{
            return entityManager.createQuery("SELECT t FROM Teacher t WHERE t.id = :teacherId", Teacher.class)
                    .setParameter("teacherId", teacherId)
                    .getSingleResult();
        }catch (NoResultException e){
            return null;
        }
    }

    @Override
    @Transactional
    public void updateTeacher(Teacher teacher) {
        entityManager.merge(teacher);
    }


}
