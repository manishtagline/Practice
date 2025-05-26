package com.jpaTemplate;

import com.jpaTemplate.config.AppConfig;
import com.jpaTemplate.dao.PersonDao;
import com.jpaTemplate.entity.Person;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class Main {
    public static void main(String[] args) {
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        PersonDao dao = context.getBean(PersonDao.class);

        dao.save(new Person("Harvey","Texas"));
    }
}
