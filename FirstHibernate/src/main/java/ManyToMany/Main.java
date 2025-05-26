package ManyToMany;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;


public class Main {
    public static void main(String[] args) {
        SessionFactory sessionFactory = new Configuration()
                .configure("hibernate.cfg.xml")
                .addAnnotatedClass(Student.class)
                .addAnnotatedClass(Course.class)
                .buildSessionFactory();



        Student  s1 = new Student();
        s1.setStudentName("Manish");

        Student s2 = new Student();
        s2.setStudentName("Harry");

        Course c1 = new Course();
        c1.setCourseName("Java");

        Course c2 = new Course();
        c2.setCourseName("Python");

        s1.addCourse(c1);
        s1.addCourse(c2);

        s2.addCourse(c2);

        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();

        session.save(s1);
        session.save(s2);
        session.save(c1);
        session.save(c2);

        tx.commit();
    }
}
