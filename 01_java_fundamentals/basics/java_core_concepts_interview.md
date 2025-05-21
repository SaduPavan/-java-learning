# Core Java Concepts - Interview Guide

## 1. Object-Oriented Programming Concepts

### 1.1 Classes and Objects
```java
// Class definition
public class Employee {
    // Instance variables (attributes)
    private String name;
    private int id;
    private double salary;
    
    // Constructor
    public Employee(String name, int id, double salary) {
        this.name = name;
        this.id = id;
        this.salary = salary;
    }
    
    // Methods
    public void work() {
        System.out.println(name + " is working");
    }
    
    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}

// Object creation and usage
public class Main {
    public static void main(String[] args) {
        Employee emp = new Employee("John", 1001, 50000.0);
        emp.work();
    }
}
```

**Interview Questions:**
1. What is the difference between a class and an object?
   - Class is a blueprint/template
   - Object is an instance of a class
   - Class defines structure, object contains data

2. What is the difference between instance and static members?
   - Instance members belong to objects
   - Static members belong to class
   - Static members are shared among all objects

### 1.2 Inheritance
```java
// Parent class
public class Animal {
    protected String name;
    
    public Animal(String name) {
        this.name = name;
    }
    
    public void eat() {
        System.out.println(name + " is eating");
    }
}

// Child class
public class Dog extends Animal {
    private String breed;
    
    public Dog(String name, String breed) {
        super(name);
        this.breed = breed;
    }
    
    @Override
    public void eat() {
        System.out.println(name + " the " + breed + " is eating dog food");
    }
    
    public void bark() {
        System.out.println(name + " is barking");
    }
}
```

**Interview Questions:**
1. What is inheritance and why is it used?
   - Code reuse
   - Method overriding
   - Polymorphism
   - IS-A relationship

2. What is the difference between extends and implements?
   - extends: for class inheritance
   - implements: for interface implementation
   - Java supports single inheritance for classes

### 1.3 Polymorphism
```java
public class PolymorphismExample {
    public static void main(String[] args) {
        // Runtime polymorphism
        Animal animal1 = new Animal("Generic Animal");
        Animal animal2 = new Dog("Buddy", "Labrador");
        
        animal1.eat(); // Animal is eating
        animal2.eat(); // Buddy the Labrador is eating dog food
        
        // Compile-time polymorphism (Method Overloading)
        Calculator calc = new Calculator();
        System.out.println(calc.add(5, 3));      // 8
        System.out.println(calc.add(5, 3, 2));   // 10
    }
}

class Calculator {
    public int add(int a, int b) {
        return a + b;
    }
    
    public int add(int a, int b, int c) {
        return a + b + c;
    }
}
```

**Interview Questions:**
1. What is polymorphism and its types?
   - Runtime (Method Overriding)
   - Compile-time (Method Overloading)
   - Dynamic method dispatch

2. What is the difference between method overloading and overriding?
   - Overloading: Same name, different parameters
   - Overriding: Same signature in child class
   - Overriding needs inheritance

### 1.4 Encapsulation
```java
public class BankAccount {
    private double balance;
    private String accountNumber;
    
    public BankAccount(String accountNumber, double initialBalance) {
        this.accountNumber = accountNumber;
        this.balance = initialBalance;
    }
    
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    public boolean withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            return true;
        }
        return false;
    }
    
    public double getBalance() {
        return balance;
    }
}
```

**Interview Questions:**
1. What is encapsulation and why is it important?
   - Data hiding
   - Access control
   - Implementation details hiding
   - Better maintainability

2. What are access modifiers and their scope?
   - private: class level
   - default: package level
   - protected: package + child classes
   - public: everywhere

### 1.5 Abstraction
```java
// Abstract class
public abstract class Vehicle {
    protected String brand;
    
    public Vehicle(String brand) {
        this.brand = brand;
    }
    
    // Abstract method
    public abstract void start();
    
    // Concrete method
    public void stop() {
        System.out.println(brand + " is stopping");
    }
}

// Interface
public interface Drivable {
    void drive();
    void park();
}

// Concrete class
public class Car extends Vehicle implements Drivable {
    public Car(String brand) {
        super(brand);
    }
    
    @Override
    public void start() {
        System.out.println(brand + " car is starting");
    }
    
    @Override
    public void drive() {
        System.out.println(brand + " car is driving");
    }
    
    @Override
    public void park() {
        System.out.println(brand + " car is parking");
    }
}
```

**Interview Questions:**
1. What is abstraction and why is it used?
   - Hide implementation details
   - Show only essential features
   - Reduce complexity
   - Better code organization

2. What is the difference between abstract class and interface?
   - Abstract class: partial abstraction, can have concrete methods
   - Interface: complete abstraction, all methods abstract (before Java 8)
   - Multiple interface implementation possible

## 2. Data Types and Variables

### 2.1 Primitive Data Types
```java
public class PrimitiveTypes {
    public static void main(String[] args) {
        // Integer types
        byte b = 127;                    // 8-bit
        short s = 32767;                 // 16-bit
        int i = 2147483647;              // 32-bit
        long l = 9223372036854775807L;   // 64-bit
        
        // Floating-point types
        float f = 3.14f;                 // 32-bit
        double d = 3.14159265359;        // 64-bit
        
        // Character type
        char c = 'A';                    // 16-bit Unicode
        
        // Boolean type
        boolean bool = true;             // true/false
    }
}
```

**Interview Questions:**
1. What are the primitive data types in Java?
   - byte, short, int, long
   - float, double
   - char
   - boolean

2. What is the difference between float and double?
   - float: 32-bit, less precise
   - double: 64-bit, more precise
   - double is default for decimal numbers

### 2.2 Reference Data Types
```java
public class ReferenceTypes {
    public static void main(String[] args) {
        // String
        String str = "Hello";
        
        // Arrays
        int[] numbers = {1, 2, 3};
        String[] names = new String[3];
        
        // Custom class
        Employee emp = new Employee("John", 1001, 50000.0);
        
        // Wrapper classes
        Integer integerObj = 100;
        Double doubleObj = 3.14;
        Boolean booleanObj = true;
    }
}
```

**Interview Questions:**
1. What is the difference between primitive and reference types?
   - Primitive: store values directly
   - Reference: store memory addresses
   - Reference types can be null

2. What are wrapper classes and why are they used?
   - Convert primitives to objects
   - Required for collections
   - Provide utility methods

### 2.3 Type Casting
```java
public class TypeCasting {
    public static void main(String[] args) {
        // Implicit casting (Widening)
        int i = 100;
        long l = i;    // int to long
        double d = i;  // int to double
        
        // Explicit casting (Narrowing)
        double price = 9.99;
        int dollars = (int) price; // double to int
        
        // String to number
        String numberStr = "123";
        int number = Integer.parseInt(numberStr);
        
        // Number to String
        int num = 456;
        String str = String.valueOf(num);
    }
}
```

**Interview Questions:**
1. What is type casting and its types?
   - Implicit (Widening): automatic
   - Explicit (Narrowing): manual
   - Can cause data loss

2. What is autoboxing and unboxing?
   - Autoboxing: primitive to wrapper
   - Unboxing: wrapper to primitive
   - Automatic conversion

## 3. Control Flow Statements

### 3.1 If-else and Switch
```java
public class ControlFlow {
    public static void main(String[] args) {
        // If-else
        int age = 20;
        if (age >= 18) {
            System.out.println("Adult");
        } else {
            System.out.println("Minor");
        }
        
        // Switch (Java 12+)
        String day = "Monday";
        switch (day) {
            case "Monday" -> System.out.println("Start of week");
            case "Friday" -> System.out.println("End of week");
            default -> System.out.println("Middle of week");
        }
    }
}
```

**Interview Questions:**
1. What is the difference between if-else and switch?
   - if-else: any condition
   - switch: equality check
   - switch: more efficient for multiple conditions

2. What are the new features in switch statements (Java 12+)?
   - Arrow syntax
   - Multiple case labels
   - Switch expressions

### 3.2 Loops
```java
public class Loops {
    public static void main(String[] args) {
        // For loop
        for (int i = 0; i < 5; i++) {
            System.out.println(i);
        }
        
        // While loop
        int count = 0;
        while (count < 5) {
            System.out.println(count);
            count++;
        }
        
        // Do-while loop
        int num = 0;
        do {
            System.out.println(num);
            num++;
        } while (num < 5);
        
        // Enhanced for loop
        int[] numbers = {1, 2, 3, 4, 5};
        for (int n : numbers) {
            System.out.println(n);
        }
    }
}
```

**Interview Questions:**
1. What are the different types of loops in Java?
   - for: known iterations
   - while: unknown iterations
   - do-while: at least one iteration
   - enhanced for: collections/arrays

2. What is the difference between break and continue?
   - break: exits loop
   - continue: skips iteration
   - labeled break/continue

### 3.3 Exception Handling
```java
public class ExceptionHandling {
    public static void main(String[] args) {
        try {
            // Risky code
            int result = divide(10, 0);
            System.out.println(result);
        } catch (ArithmeticException e) {
            // Handle specific exception
            System.out.println("Cannot divide by zero");
        } catch (Exception e) {
            // Handle any exception
            System.out.println("An error occurred");
        } finally {
            // Always executed
            System.out.println("Cleanup code");
        }
        
        // Try-with-resources
        try (FileInputStream fis = new FileInputStream("file.txt")) {
            // Use resource
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public static int divide(int a, int b) throws ArithmeticException {
        if (b == 0) {
            throw new ArithmeticException("Division by zero");
        }
        return a / b;
    }
}
```

**Interview Questions:**
1. What is exception handling and why is it important?
   - Graceful error handling
   - Program stability
   - Resource cleanup
   - Better user experience

2. What is the difference between checked and unchecked exceptions?
   - Checked: must be handled
   - Unchecked: optional handling
   - RuntimeException hierarchy

3. What is try-with-resources?
   - Automatic resource management
   - Implements AutoCloseable
   - Better than finally block

Remember: Understanding these concepts thoroughly is crucial for Java interviews. Practice implementing these concepts and be prepared to explain them in detail. 