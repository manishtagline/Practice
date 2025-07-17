package com.example.questionbanksite.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserExamSummaryDto {

    private int totalCorrectAnswers;

    private int totalWrongAnswers;

    private double overallPercentage;

    private int enrolledCount;

    private int completedCount;

    private int pendingCount;

}
