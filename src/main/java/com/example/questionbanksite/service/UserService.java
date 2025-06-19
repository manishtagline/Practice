package com.example.questionbanksite.service;


import com.example.questionbanksite.entity.User;

import java.util.List;

public interface UserService {

    User saveUser(User user);

    List<User> getAllUser();

    User getUserByName(String username);

}
