package inheritence;
import javax.persistence.*;

//🔰 1. Table Per Hierarchy (Single Table Strategy)
//@Entity
//@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
//@DiscriminatorColumn(name = "type", discriminatorType = DiscriminatorType.STRING)
//public class Vehicle {
//
//    @Id
//    private int id;
//    private String name;
//
//}
//
//@Entity
//@DiscriminatorValue("CAR")
//class Car extends Vehicle{
//    private int speed;
//}
//
//@Entity
//@DiscriminatorValue("BIKE")
//class Bike extends Vehicle{
//    private String model;
//}

//🔰 2. Table Per Concrete Class (Table Per Class Strategy)

//@Entity
//@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
//public class Vehicle{
//    @Id
//    private int id;
//    private String name;
//}
//
//@Entity
//class Car extends Vehicle{
//    private int speed;
//}
//
//@Entity
//class Bike extends Vehicle{
//    private String model;
//}


//🔰 3. Table Per Subclass (Joined Strategy)
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Vehicle {
    @Id
    private int id;
    private String name;
}

@Entity
class Car extends Vehicle {
    private int speed;
}

@Entity
class Bike extends Vehicle {
    private String model;
}
