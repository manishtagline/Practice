package com.example.questionbanksite.entity;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.List;

@Entity
@Table(name = "exam")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Exam {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String description;

    @Column(name = "total_marks")
    private Long totalMarks;

    private boolean isCreatedByAdmin;

    private boolean isCreatedByTeacher;

    private int totalNumberOfQuestion;

    @Column(name = "date_created", updatable = false)
    private ZonedDateTime dateCreated;

    @Column(name = "enrolledStartDate", updatable = false)
    private ZonedDateTime enrolledStartDate;

    @Column(name = "enrolledEndDate", updatable = false)
    private ZonedDateTime enrolledEndDate;

    @Column(name = "examStartDate", updatable = false)
    private ZonedDateTime examStartDate;

    @Column(name = "examEndDate", updatable = false)
    private ZonedDateTime examEndDate;

    @ManyToOne
    @JoinColumn(name = "subject_id")
    private Subject subject;

    @ManyToMany
    @JoinTable(name = "exam_questions",
            joinColumns = @JoinColumn(name = "exam_id"),
            inverseJoinColumns = @JoinColumn(name = "question_id"))
    private List<Question>  questions;

    @OneToMany(mappedBy = "exam")
    private List<UserResult> result;

    @ManyToOne
    @JoinColumn(name = "teacher_id")
    private Teacher teacher;

    //This field is completed user, who submit there exam.
    @ManyToMany
    @JoinTable(name = "exam_user",
            joinColumns = @JoinColumn(name = "exam_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id"))
    private List<User> completedUsers;

    //This show how many user enrolled the exam.
    @ManyToMany
    @JoinTable(name = "enrolled_exam_user",
            joinColumns = @JoinColumn(name = "exam_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id"))
    private List<User> enrolledUsers;
}
