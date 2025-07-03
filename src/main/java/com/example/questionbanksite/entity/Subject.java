        package com.example.questionbanksite.entity;

        import lombok.AllArgsConstructor;
        import lombok.Getter;
        import lombok.NoArgsConstructor;
        import lombok.Setter;
        import org.hibernate.annotations.Fetch;
        import org.hibernate.annotations.FetchMode;
        import org.hibernate.annotations.Where;

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
            @Fetch(FetchMode.SUBSELECT)
            @Where(clause = "deleted = false")
            private List<Question> questions;

            @OneToMany(mappedBy = "subject", fetch = FetchType.LAZY)
            @Fetch(FetchMode.SUBSELECT)
            private List<Exam> exams;

            @OneToMany(mappedBy = "subject", fetch = FetchType.LAZY)
            @Fetch(FetchMode.SUBSELECT)
            private List<Teacher> teachers;


        }
