    package com.example.questionbanksite.entity;

    import lombok.AllArgsConstructor;
    import lombok.Getter;
    import lombok.NoArgsConstructor;
    import lombok.Setter;

    import javax.persistence.*;
    import java.util.List;
    import java.util.Set;

    @Entity
    @Table(name = "question")
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public class Question {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;

        private String questiondDesc;

        @ElementCollection(fetch = FetchType.EAGER)
        private Set<String> options;

        @Column(name = "deleted")
        private boolean deleted = false;

        private int marks;

        @Column(name = "correct_answer")
        private String correctAnswer;

        private String complexity;

        @ManyToOne
        @JoinColumn(name = "subject_id")
        private Subject subject;

        @ManyToMany(mappedBy = "questions")
        private List<Exam> exams;

        @ManyToOne
        @JoinColumn(name = "teacherId")
        private Teacher teacher;

    }
