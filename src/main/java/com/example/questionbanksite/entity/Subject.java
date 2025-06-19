        package com.example.questionbanksite.entity;

        import lombok.AllArgsConstructor;
        import lombok.Getter;
        import lombok.NoArgsConstructor;
        import lombok.Setter;

        import javax.persistence.*;
        import java.util.List;

        @Entity
        @Table(name = "subject_table")
        @Getter
        @Setter
        @NoArgsConstructor
        @AllArgsConstructor
        public class Subject {

            @Id
            @GeneratedValue(strategy = GenerationType.IDENTITY)
            private Long id;

            private String name;

            @OneToMany(mappedBy = "subject", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
            private List<Question> questions;

            @OneToMany(mappedBy = "subject", fetch = FetchType.LAZY)
            private List<Exam> exams;

        }
