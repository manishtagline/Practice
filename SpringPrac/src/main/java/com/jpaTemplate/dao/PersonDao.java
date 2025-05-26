package com.jpaTemplate.dao;

import com.jpaTemplate.entity.Person;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class PersonDao {

    @PersistenceContext
    private EntityManager manager;

    @Transactional
    public void save(Person person) {
        manager.persist(person);
    }

    public Person findById(Long id) {
        return manager.find(Person.class, id);
    }

    @Transactional
    public void update(Person person) {
        manager.merge(person);
    }

    @Transactional
    public void delete(Long id) {
        Person person = manager.find(Person.class, id);
        if (person != null) {
            manager.remove(person);
        }
    }

    public List<Person> findAll() {
        return manager.createQuery("FROM Person", Person.class).getResultList();
    }

}
