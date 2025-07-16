    package com.example.questionbanksite.service;

    import com.example.questionbanksite.dto.*;
    import com.example.questionbanksite.entity.Question;
    import com.example.questionbanksite.entity.Subject;
    import com.example.questionbanksite.entity.Teacher;
    import com.example.questionbanksite.entity.User;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.stereotype.Service;
    import org.springframework.transaction.annotation.Transactional;

    import javax.persistence.EntityManager;
    import javax.persistence.NoResultException;
    import javax.persistence.PersistenceContext;
    import java.util.ArrayList;
    import java.util.Collections;
    import java.util.List;
    import java.util.stream.Collectors;

    @Service
    public class TeacherServiceImpl implements TeacherService{

        @Autowired
        private TeacherService teacherService;

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
                String subjectName = "";
                if(teacher.getSubjects() != null && !teacher.getSubjects().isEmpty()){
                    subjectName = teacher.getSubjects().stream()
                            .map(Subject::getName)
                            .collect(Collectors.joining(", "));
                }
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

        @Override
        @Transactional(readOnly = true)
        public long countQuestionAddedByTeacher(Long teacherId) {
            return entityManager.createQuery("SELECT COUNT(q) FROM Question q WHERE q.teacher.id = :teacherId AND q.deleted = false ", Long.class)
                    .setParameter("teacherId", teacherId)
                    .getSingleResult();
        }

        @Override
        public List<QuestionDto> getQuestionOfTeacher(Long teacherId) {
            List<Question> questions = entityManager.createQuery("SELECT q FROM Question q WHERE q.teacher.id = :teacherId AND q.deleted = false",
                    Question.class)
                    .setParameter("teacherId", teacherId)
                    .getResultList();
            return questions.stream()
                    .map(q -> new QuestionDto(
                            q.getId(),
                            q.getQuestiondDesc(),
                            q.getOptions().stream().toList(),
                            q.getCorrectAnswer(),
                            q.getMarks(),
                            q.getComplexity(),
                            q.getSubject().getName()
                    ))
                    .collect(Collectors.toList());
        }

        @Override
        @Transactional(readOnly = true)
        public List<TeacherSubjectDto> getSubjectStatsForTeacher(String teacherName) {

            Teacher teacher = teacherService.getTeacherByName(teacherName);

            List<TeacherSubjectDto> teacherDto = new ArrayList<>();

            for(Subject subject : teacher.getSubjects()){

                int questionsCount = subject.getQuestions().size();

                int addedQuestions = (int) teacher.getQuestions().stream()
                        .filter(q -> q.getSubject().getId().equals(subject.getId()))
                        .count();

                int examCount = (int) teacher.getCreatedExam().stream()
                        .filter(q -> q.getSubject().getId().equals(subject.getId()))
                        .count();

                TeacherSubjectDto dto = TeacherSubjectDto.builder()
                        .id(subject.getId())
                        .name(subject.getName())
                        .questionCount(questionsCount)
                        .addedQuestions(addedQuestions)
                        .examCount(examCount)
                        .build();

                teacherDto.add(dto);
            }

            return teacherDto;
        }

        @Override
        @Transactional
        public Teacher updateTeacherZoneId(Long id, Teacher teacher) {
            Teacher existingTeacher = entityManager.find(Teacher.class, id);
            if (existingTeacher != null) {
                existingTeacher.setUsername(teacher.getUsername());
                existingTeacher.setPassword(teacher.getPassword());
                existingTeacher.setZoneId(teacher.getZoneId());

                entityManager.merge(existingTeacher);
            }
            return existingTeacher;
        }


    }
