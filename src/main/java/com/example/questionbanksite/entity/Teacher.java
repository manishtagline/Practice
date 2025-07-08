package com.example.questionbanksite.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

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

    private Long zoneId;
    private String password;
    private String email;
    private String role;

   @ManyToMany(fetch = FetchType.EAGER)
   @JoinTable(name = "teachers_subjects",
           joinColumns = @JoinColumn(name = "teacher_id"),
           inverseJoinColumns = @JoinColumn(name = "subejct_id"))
   private List<Subject> subjects;

   @OneToMany(mappedBy = "teacher")
   private List<Exam> createdExam;


}
