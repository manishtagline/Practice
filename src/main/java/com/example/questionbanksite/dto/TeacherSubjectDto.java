package com.example.questionbanksite.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TeacherSubjectDto {

    private Long id;

    private String name;

    private int questionCount;

    private int addedQuestions;

    private int examCount;

}
