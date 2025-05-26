package JpaCrud;


import javax.persistence.*;

public class Main {


    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("person_details");

    public static void main(String[] args) {
        //For inserting data
//        Main.addPerson("ABC","BA@gmail.com","mk");

        //For reading data
//        Main.readPerson(1);

        //For updating data
//        Main.updatePerson(2,"Hariom","om@gmail.com","Vadodara");

        //Fro deleting data
        Main.deletePerson(3);
    }

    public static void addPerson(String name, String email, String address){
        EntityManager manager = emf.createEntityManager();
        EntityTransaction tx = manager.getTransaction();
        tx.begin();
        Person1 p = new Person1(name,email,address);

        manager.persist(p);

        tx.commit();
    }

    public static void readPerson(int id){
        EntityManager manager = emf.createEntityManager();
        Person1 p = manager.find(Person1.class, id);

        System.out.println("Read" + p);
    }

    public static void updatePerson(int id, String newName, String newEmail, String newAddress){
        EntityManager manager = emf.createEntityManager();
        EntityTransaction tx = manager.getTransaction();
        tx.begin();

        Person1 p = manager.find(Person1.class, id);
        if(p!=null){
            p.setName(newName);
            p.setEmail(newEmail);
            p.setAddress(newAddress);
            System.out.println("Updated : "+p);
        }else{
            System.out.println("Person not found with id " + id);
        }

        tx.commit();
    }

    public static void deletePerson(int id){
        EntityManager manager = emf.createEntityManager();
        EntityTransaction tx = manager.getTransaction();
        tx.begin();
        Person1 person1 = manager.find(Person1.class, id);
        if(person1 !=null){
            manager.remove(person1);
            System.out.println("Deleted person with id " + id);
        }else{
            System.out.println("Person not found with id " + id);
        }

        tx.commit();
    }
}
