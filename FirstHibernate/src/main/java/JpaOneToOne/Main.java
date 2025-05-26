package JpaOneToOne;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class Main {
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("person_passport");
        EntityManager em = factory.createEntityManager();

        Person person = new Person();
        person.setName("Manish");
        person.setAddress("Bharuch");

        Passport passport = new Passport();
        passport.setPassportNumber("AN54634752");

        person.setPassport(passport);

        em.getTransaction().begin();
        em.persist(person);
        em.persist(passport);
        em.getTransaction().commit();

    }
}
