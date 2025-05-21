# Java Fundamentals and Data Types - Detailed Guide with Examples

## 1. Java Architecture and JVM

### JVM Architecture
```java
// JVM Components:
// 1. Class Loader
// 2. Runtime Data Areas
// 3. Execution Engine
// 4. Native Method Interface

// Example of how JVM loads and executes a class
public class JVMExample {
    public static void main(String[] args) {
        System.out.println("Hello from JVM!");
    }
}
```

## 2. Object-Oriented Programming Concepts

### Classes and Objects
```java
// Class definition
public class Person {
    // Instance variables (attributes)
    private String name;
    private int age;
    
    // Constructor
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    // Methods
    public void introduce() {
        System.out.println("Hi, I'm " + name + " and I'm " + age + " years old.");
    }
}

// Creating and using objects
public class Main {
    public static void main(String[] args) {
        Person person1 = new Person("John", 25);
        person1.introduce(); // Output: Hi, I'm John and I'm 25 years old.
    }
}
```

### Inheritance
```java
// Parent class
public class Animal {
    protected String name;
    
    public Animal(String name) {
        this.name = name;
    }
    
    public void makeSound() {
        System.out.println("Some sound");
    }
}

// Child class
public class Dog extends Animal {
    public Dog(String name) {
        super(name);
    }
    
    @Override
    public void makeSound() {
        System.out.println("Woof!");
    }
}
```

### Polymorphism
```java
public class PolymorphismExample {
    public static void main(String[] args) {
        Animal animal1 = new Animal("Generic Animal");
        Animal animal2 = new Dog("Buddy");
        
        animal1.makeSound(); // Output: Some sound
        animal2.makeSound(); // Output: Woof!
    }
}
```

### Encapsulation
```java
public class BankAccount {
    private double balance;
    
    public BankAccount(double initialBalance) {
        this.balance = initialBalance;
    }
    
    // Getter
    public double getBalance() {
        return balance;
    }
    
    // Setter with validation
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
}
```

### Abstraction
```java
// Abstract class
public abstract class Shape {
    protected String color;
    
    public Shape(String color) {
        this.color = color;
    }
    
    // Abstract method
    public abstract double getArea();
    
    // Concrete method
    public String getColor() {
        return color;
    }
}

// Concrete class
public class Circle extends Shape {
    private double radius;
    
    public Circle(String color, double radius) {
        super(color);
        this.radius = radius;
    }
    
    @Override
    public double getArea() {
        return Math.PI * radius * radius;
    }
}
```

## 3. Data Types and Variables

### Primitive Data Types
```java
public class PrimitiveTypes {
    public static void main(String[] args) {
        // Integer types
        byte byteNum = 127;                    // 8-bit, range: -128 to 127
        short shortNum = 32767;                // 16-bit, range: -32,768 to 32,767
        int intNum = 2147483647;               // 32-bit, range: -2^31 to 2^31-1
        long longNum = 9223372036854775807L;   // 64-bit, range: -2^63 to 2^63-1
        
        // Floating-point types
        float floatNum = 3.14f;                // 32-bit
        double doubleNum = 3.14159265359;      // 64-bit
        
        // Character type
        char charValue = 'A';                  // 16-bit Unicode
        
        // Boolean type
        boolean boolValue = true;              // true or false
    }
}
```

### Reference Data Types
```java
public class ReferenceTypes {
    public static void main(String[] args) {
        // String
        String text = "Hello, World!";
        
        // Arrays
        int[] numbers = {1, 2, 3, 4, 5};
        String[] names = new String[3];
        
        // Custom class
        Person person = new Person("Alice", 30);
        
        // Wrapper classes
        Integer integerObj = 100;
        Double doubleObj = 3.14;
        Boolean booleanObj = true;
    }
}
```

### Type Casting
```java
public class TypeCasting {
    public static void main(String[] args) {
        // Implicit casting (Widening)
        int intNum = 100;
        long longNum = intNum;    // int to long
        double doubleNum = intNum; // int to double
        
        // Explicit casting (Narrowing)
        double price = 9.99;
        int dollars = (int) price; // double to int (truncates decimal)
        
        // String to number
        String numberStr = "123";
        int number = Integer.parseInt(numberStr);
        
        // Number to String
        int num = 456;
        String str = String.valueOf(num);
    }
}
```

### Arrays
```java
public class ArrayExamples {
    public static void main(String[] args) {
        // Single-dimensional array
        int[] numbers = {1, 2, 3, 4, 5};
        
        // Multi-dimensional array
        int[][] matrix = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        
        // Array operations
        System.out.println("Length: " + numbers.length);
        System.out.println("First element: " + numbers[0]);
        
        // Array iteration
        for (int num : numbers) {
            System.out.println(num);
        }
        
        // Array methods
        Arrays.sort(numbers);
        int index = Arrays.binarySearch(numbers, 3);
    }
}
```

### String Handling
```java
public class StringExamples {
    public static void main(String[] args) {
        // String creation
        String str1 = "Hello";
        String str2 = new String("World");
        
        // String concatenation
        String result = str1 + " " + str2;
        
        // String methods
        System.out.println("Length: " + result.length());
        System.out.println("Uppercase: " + result.toUpperCase());
        System.out.println("Lowercase: " + result.toLowerCase());
        System.out.println("Substring: " + result.substring(0, 5));
        System.out.println("Contains 'World': " + result.contains("World"));
        
        // String comparison
        String s1 = "Hello";
        String s2 = "Hello";
        String s3 = new String("Hello");
        
        System.out.println(s1 == s2);      // true (string pool)
        System.out.println(s1 == s3);      // false (different objects)
        System.out.println(s1.equals(s3)); // true (content comparison)
    }
}
```

### StringBuilder and StringBuffer
```java
public class StringBufferBuilder {
    public static void main(String[] args) {
        // StringBuilder (not thread-safe, faster)
        StringBuilder sb = new StringBuilder();
        sb.append("Hello");
        sb.append(" ");
        sb.append("World");
        System.out.println(sb.toString());
        
        // StringBuffer (thread-safe, slower)
        StringBuffer sbf = new StringBuffer();
        sbf.append("Hello");
        sbf.append(" ");
        sbf.append("World");
        System.out.println(sbf.toString());
        
        // Common methods
        sb.reverse();
        sb.insert(5, " Beautiful ");
        sb.delete(5, 15);
        sb.replace(0, 5, "Hi");
    }
}
```

## Best Practices

1. **Variable Naming**
   - Use meaningful names
   - Follow camelCase convention
   - Constants should be UPPER_CASE

2. **Type Safety**
   - Always use appropriate data types
   - Be careful with type casting
   - Use wrapper classes when needed

3. **String Handling**
   - Use StringBuilder for multiple string concatenations
   - Use StringBuffer in multi-threaded environments
   - Be aware of string immutability

4. **Object-Oriented Design**
   - Follow SOLID principles
   - Use proper access modifiers
   - Implement proper encapsulation
   - Use inheritance and polymorphism appropriately

Remember to practice these concepts by writing your own code examples and experimenting with different scenarios. Understanding these fundamentals is crucial for Java development and interviews. 