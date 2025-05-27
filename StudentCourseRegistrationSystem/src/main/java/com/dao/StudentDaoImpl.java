package com.dao;

import com.model.Course;
import com.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public class StudentDaoImpl implements StudentDao{

    @Autowired
    private HibernateTemplate hibernateTemplate;

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    @Transactional
    @Override
    public void addStudent(Student student) {
        hibernateTemplate.persist(student);
    }

    @Transactional(readOnly = true)
    @Override
    public Student getStudentById(int id) {
        return hibernateTemplate.get(Student.class, id);
    }

    @Transactional
    @Override
    public void deleteStudent(int id) {
        Student s = hibernateTemplate.get(Student.class, id);
        hibernateTemplate.delete(s);
    }

    @Transactional
    @Override
    public void updateStudent(Student student) {
        hibernateTemplate.update(student);
    }

    @Transactional(readOnly = true)
    @Override
    public List<Course> getAllCourse() {
        return hibernateTemplate.loadAll(Course.class);
    }

    @Transactional(readOnly = true)
    @Override
    public List<Student> getAllStudent() {
        return hibernateTemplate.loadAll(Student.class);
    }

    @Override
    public Course courseById(int id) {
        return hibernateTemplate.get(Course.class, id);
    }
}
