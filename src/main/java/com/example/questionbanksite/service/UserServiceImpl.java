package com.example.questionbanksite.service;


import com.example.questionbanksite.dto.UserDetailsListDto;
import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.entity.UserResult;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public User saveUser(User user) {
        entityManager.persist(user);
        return user;
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getAllUser() {
        return entityManager.createQuery("SELECT u FROM User u WHERE u.role = 'User'", User.class).getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<UserDetailsListDto> getAllUserDetails() {
        // Step 1: Load users with exams and subject
        List<User> userList = entityManager.createQuery(
                "SELECT DISTINCT u FROM User u " +
                        "WHERE u.role = 'User'", User.class)
                .getResultList();

        return userList.stream().map(user -> {
            Set<String> examNames = user.getExams().stream()
                    .map(Exam::getDescription)
                    .collect(Collectors.toSet());


            Integer totalExams = user.getExams().size();

            List<Integer> scores = user.getResults().stream()
                    .map(UserResult::getTotalScore)
                    .collect(Collectors.toList());

            Double averageScore = scores.isEmpty() ? null :
                    scores.stream().mapToInt(Integer::intValue).average().orElse(0.0);

            Double highestScore = scores.isEmpty() ? null :
                    (double) scores.stream().mapToInt(Integer::intValue).max().orElse(0);

            Double lowestScore = scores.isEmpty() ? null :
                    (double) scores.stream().mapToInt(Integer::intValue).min().orElse(0);

            return UserDetailsListDto.builder()
                    .userId(user.getId())
                    .username(user.getUsername())
                    .enrolledSubjects(examNames)
                    .totalExams(totalExams)
                    .averageScore(averageScore)
                    .highestScore(highestScore)
                    .lowestScore(lowestScore)
                    .build();
        }).collect(Collectors.toList());
    }




    @Override
    @Transactional(readOnly = true)
    public User getUserByName(String username) {
        try {
            return entityManager.createQuery(
                    "SELECT u FROM User u WHERE u.username = :username", User.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    @Transactional(readOnly = true)
    public User getUserById(Long id) {
        return entityManager.find(User.class, id);
    }

    @Override
    @Transactional
    public User updateUser(Long id, User updatedUser) {
        User existingUser = entityManager.find(User.class, id);
        if (existingUser != null) {
            existingUser.setUsername(updatedUser.getUsername());
            existingUser.setPassword(updatedUser.getPassword());

            entityManager.merge(existingUser);
        }
        return existingUser;
    }

    @Override
    @Transactional
    public void deleteUser(Long id) {
        User user = entityManager.find(User.class, id);
        if (user != null) {
            entityManager.remove(user);
        }
    }
}
