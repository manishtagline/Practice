package com.example.questionbanksite.service;

import com.example.questionbanksite.entity.UserResult;

import java.util.List;

public interface UserResultService {

    List<UserResult> getResultsByUserId(Long userId);

    UserResult getResultDetailsById(Long resultId);

}
