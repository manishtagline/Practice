package JpaCriteria;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("employee_salary");
        EntityManager manager = factory.createEntityManager();

        manager.getTransaction().begin();
        Employee emp1 = new Employee("Manish",456956);
        Employee emp2 = new Employee("ABC",76405);
        Employee emp3 = new Employee("XYZ",3692);
        Employee emp4 = new Employee("MNO",20058);
        Employee emp5 = new Employee("EFG",45621);
        manager.persist(emp1);
        manager.persist(emp2);
        manager.persist(emp3);
        manager.persist(emp4);
        manager.persist(emp5);
        manager.getTransaction().commit();

        CriteriaBuilder cb = manager.getCriteriaBuilder();
        CriteriaQuery<Employee> cq = cb.createQuery(Employee.class);
        Root<Employee> root = cq.from(Employee.class);

//        Predicate condition = cb.gt(root.<Number>get("salary"),30000);
//        cq.select(root).where(condition);

        Predicate statsWith = cb.like(root.<String>get("name"),"M%");
        cq.select(root).where(statsWith);

        List<Employee> list = manager.createQuery(cq).getResultList();

        for (Employee e : list) {
            System.out.println(e);
        }
    }
}
