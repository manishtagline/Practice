package com.example.questionbanksite.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SubjectDto {

        private Long id;
        private String name;
        private int questionCount;
        private int examCount;

}
