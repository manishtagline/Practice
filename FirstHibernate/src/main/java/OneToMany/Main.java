package OneToMany;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        SessionFactory sessionFactory = new Configuration()
                .configure("hibernate.cfg.xml")
                .addAnnotatedClass(Category.class)
                .addAnnotatedClass(Product.class)
                .buildSessionFactory();


        Category category = new Category();
        category.setCategoryName("Electronics");

        Product p1 = new Product();
        p1.setProductName("Fan");
        p1.setCategory(category);

        Product p2 = new Product();
        p2.setProductName("Light");
        p2.setCategory(category);

        Product p3 = new Product();
        p3.setProductName("AC");
        p3.setCategory(category);

        List<Product> list = Arrays.asList(p1,p2,p2);

        category.setProducts(list);


        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();

        session.save(category);
        session.save(p1);
        session.save(p2);
        session.save(p3);

        tx.commit();
    }
}
