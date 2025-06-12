package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.model.Person;

@Repository
@Transactional
public class PersonDaoImpl implements PersonDao {

	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void addorupdatePerson(Person person) {
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		session.saveOrUpdate(person);
		tx.commit();
	}

	@Override
	public List<Person> viewAllPerson() {
		Session session = sessionFactory.openSession();
		return session.createQuery("from Person").list();
	}

	@Override
	public Person getById(int id) {
		Session session = sessionFactory.openSession();
		return session.get(Person.class, id);
	}

	@Override
	public void deletePerson(int id) {
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		Person person = session.get(Person.class, id);
		session.delete(person);
		tx.commit();
	}
	

}
