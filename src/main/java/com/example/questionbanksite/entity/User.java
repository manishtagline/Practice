package com.example.questionbanksite.entity;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "user")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private String password;

    private String email;

    private String role;

    private Long zoneId;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<UserResult> results;

    //This field is completedExam, which is completed by the user.
    @ManyToMany(mappedBy = "completedUsers", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<Exam> completedExams;

    //This is show how many exam enrolled by user.
    @ManyToMany(mappedBy = "enrolledUsers", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<Exam> enrolledExams;

}