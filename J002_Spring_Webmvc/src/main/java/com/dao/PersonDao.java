package com.dao;

import java.util.List;

import com.model.Person;

public interface PersonDao {

	public void addorupdatePerson(Person person);
	public List<Person> viewAllPerson();
	public Person getById(int id);
	public void deletePerson(int id);
	
}
