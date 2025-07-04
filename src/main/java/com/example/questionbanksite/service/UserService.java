package com.example.questionbanksite.service;


import com.example.questionbanksite.dto.BaseUserRegisterDto;
import com.example.questionbanksite.dto.UserDetailsListDto;
import com.example.questionbanksite.entity.Subject;
import com.example.questionbanksite.entity.User;

import java.util.List;

public interface UserService {

    int saveUser(BaseUserRegisterDto baseUser);

    List<UserDetailsListDto> getAllUserDetails();

    User getUserByName(String username);

    User getUserById(Long id);

    User updateUser(Long id,User user);

    void deleteUser(Long id);

    User getUserByEmail(String email);

}
