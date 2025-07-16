package com.example.questionbanksite.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Teacher {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;

    private String zoneId;
    private String password;
    private String email;
    private String role;

   @ManyToMany(fetch = FetchType.EAGER)
   @JoinTable(name = "teachers_subjects",
           joinColumns = @JoinColumn(name = "teacher_id"),
           inverseJoinColumns = @JoinColumn(name = "subject_id"))
   private List<Subject> subjects;

   @OneToMany(mappedBy = "teacher")
   private List<Exam> createdExam;

   @OneToMany(mappedBy = "teacher", fetch = FetchType.LAZY)
   @Fetch(FetchMode.SUBSELECT)
   private List<Question> questions;

}
