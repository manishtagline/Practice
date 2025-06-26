package com.example.questionbanksite.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserDetailsListDto {

    private Long userId;
    private String username;
    private Set<String> enrolledSubjects;
    private Integer totalExams;
    private Double averageScore;
    private Double highestScore;
    private Double lowestScore;

}
