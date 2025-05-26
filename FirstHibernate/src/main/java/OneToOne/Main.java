package OneToOne;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class Main {
    public static void main(String[] args) {
        SessionFactory sessionFactory = new Configuration()
                .configure("hibernate.cfg.xml")
                .addAnnotatedClass(Question.class)
                .addAnnotatedClass(Answer.class)
                .buildSessionFactory();

        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();

        Question q = new Question();
        q.setQuestionTitle("What is python?");

        Answer a = new Answer();
        a.setAnswerTitle("Python is popular programming language.");

        q.setAnswer(a);
        a.setQuestion(q);
        session.save(q);

        tx.commit();

    }
}
