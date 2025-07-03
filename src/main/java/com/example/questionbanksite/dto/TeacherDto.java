package com.example.questionbanksite.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TeacherDto {

    private Long id;
    private String username;
    private String email;
    private String role;
    private String subjectName;

}
