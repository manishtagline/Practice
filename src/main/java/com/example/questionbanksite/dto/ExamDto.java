package com.example.questionbanksite.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ExamDto {

    private Long id;
    private String description;
    private Long totalMarks;
    private int totalNumberOfQuestion;
    private String subjectName;
    private String formattedDate;

}
