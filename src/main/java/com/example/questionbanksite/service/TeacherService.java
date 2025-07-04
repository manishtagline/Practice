package com.example.questionbanksite.service;

import com.example.questionbanksite.dto.BaseUserRegisterDto;
import com.example.questionbanksite.dto.TeacherDto;
import com.example.questionbanksite.entity.Teacher;
import com.example.questionbanksite.entity.UserResult;

import java.util.List;

public interface TeacherService {

    int saveTeacher(BaseUserRegisterDto baseTeacher);

    List<TeacherDto> getAllTeachers();

    Teacher getTeacherByName(String username);

    Teacher getTeacherByEmail(String email);

    Teacher getTeacherById(Long teacherId);

    void updateTeacher(Teacher teacher);
}
