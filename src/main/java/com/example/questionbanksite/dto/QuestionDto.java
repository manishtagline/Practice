package com.example.questionbanksite.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QuestionDto {

    private Long id;
    private String questiondDesc;
    private List<String> options;
    private String correctAnswer;
    private Integer marks;
    private String complexity;
    private String subjectName;

}
