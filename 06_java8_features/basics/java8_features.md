# Java 8+ Features Guide

## 1. Lambda Expressions
Lambda expressions provide a concise way to write anonymous functions.

### Basic Syntax
```java
// Old way
Runnable oldWay = new Runnable() {
    public void run() {
        System.out.println("Hello");
    }
};

// Lambda way
Runnable newWay = () -> System.out.println("Hello");
```

### Different Forms
```java
// No parameters
() -> System.out.println("Hello");

// Single parameter
x -> x * 2;

// Multiple parameters
(x, y) -> x + y;

// With type declarations
(int x, int y) -> x + y;

// With multiple statements
(x, y) -> {
    int sum = x + y;
    return sum;
};
```

## 2. Stream API
The Stream API provides a functional approach to process collections of data.

### Basic Stream Operations
```java
List<String> names = Arrays.asList("John", "Alice", "Bob", "Charlie");

// Filter
List<String> filtered = names.stream()
    .filter(name -> name.startsWith("A"))
    .collect(Collectors.toList());

// Map
List<Integer> lengths = names.stream()
    .map(String::length)
    .collect(Collectors.toList());

// Reduce
int totalLength = names.stream()
    .mapToInt(String::length)
    .sum();

// Sort
List<String> sorted = names.stream()
    .sorted()
    .collect(Collectors.toList());
```

### Parallel Streams
```java
List<String> names = Arrays.asList("John", "Alice", "Bob", "Charlie");

// Parallel processing
List<String> processed = names.parallelStream()
    .map(String::toUpperCase)
    .collect(Collectors.toList());
```

## 3. Optional Class
Optional helps avoid NullPointerException by providing a container for values that might be null.

```java
// Creating Optional
Optional<String> optional = Optional.of("Hello");
Optional<String> empty = Optional.empty();
Optional<String> nullable = Optional.ofNullable(null);

// Using Optional
String value = optional.orElse("Default");
optional.ifPresent(System.out::println);

// Chaining
String result = optional
    .map(String::toUpperCase)
    .orElse("Default");
```

## 4. Default Methods
Default methods allow interfaces to have method implementations.

```java
interface Vehicle {
    void start();
    
    default void stop() {
        System.out.println("Vehicle stopping");
    }
}

class Car implements Vehicle {
    public void start() {
        System.out.println("Car starting");
    }
    // stop() method is inherited from Vehicle
}
```

## 5. Functional Interfaces
Interfaces with a single abstract method.

### Common Functional Interfaces
```java
// Predicate
Predicate<String> isEmpty = String::isEmpty;

// Function
Function<String, Integer> length = String::length;

// Consumer
Consumer<String> printer = System.out::println;

// Supplier
Supplier<String> generator = () -> "Hello";

// BiFunction
BiFunction<String, String, String> concat = String::concat;
```

## 6. Date and Time API
New date and time API for better date handling.

```java
// Current date and time
LocalDateTime now = LocalDateTime.now();
LocalDate today = LocalDate.now();
LocalTime time = LocalTime.now();

// Creating specific dates
LocalDate date = LocalDate.of(2024, 3, 15);
LocalTime specificTime = LocalTime.of(14, 30);

// Date arithmetic
LocalDate tomorrow = today.plusDays(1);
LocalDateTime nextWeek = now.plusWeeks(1);

// Formatting
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
String formatted = today.format(formatter);
```

## 7. CompletableFuture
For asynchronous programming.

```java
CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
    // Simulate long running task
    Thread.sleep(1000);
    return "Result";
});

// Chaining
CompletableFuture<String> result = future
    .thenApply(String::toUpperCase)
    .thenApply(s -> "Processed: " + s);

// Handling multiple futures
CompletableFuture<String> future1 = CompletableFuture.supplyAsync(() -> "Hello");
CompletableFuture<String> future2 = CompletableFuture.supplyAsync(() -> "World");

CompletableFuture<String> combined = future1
    .thenCombine(future2, (s1, s2) -> s1 + " " + s2);
```

## 8. Module System (Java 9+)
Better encapsulation and dependency management.

```java
// module-info.java
module com.example.app {
    requires java.base;
    requires java.sql;
    exports com.example.app.api;
}
```

## 9. Records (Java 16+)
Concise way to create immutable data classes.

```java
// Old way
public class Person {
    private final String name;
    private final int age;
    
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    // Getters, equals, hashCode, toString
}

// New way with records
public record Person(String name, int age) {}
```

## 10. Pattern Matching (Java 16+)
Simplifies type checking and casting.

```java
// Old way
if (obj instanceof String) {
    String s = (String) obj;
    System.out.println(s.length());
}

// New way
if (obj instanceof String s) {
    System.out.println(s.length());
}
```

## 11. Sealed Classes (Java 17+)
Restrict which classes can extend a class or implement an interface.

```java
public sealed class Shape 
    permits Circle, Rectangle, Square {
    // Common shape code
}

public final class Circle extends Shape {
    // Circle implementation
}

public final class Rectangle extends Shape {
    // Rectangle implementation
}

public final class Square extends Shape {
    // Square implementation
}
```

## Best Practices

1. **Lambda Expressions**
   - Keep lambdas short and focused
   - Use method references when possible
   - Avoid side effects in lambdas

2. **Stream API**
   - Use parallel streams for large datasets
   - Chain operations efficiently
   - Use appropriate collectors

3. **Optional**
   - Use Optional for return types that might be null
   - Avoid Optional for fields or parameters
   - Use orElse() instead of get()

4. **CompletableFuture**
   - Handle exceptions properly
   - Use appropriate thread pools
   - Chain operations for better readability

5. **Date and Time API**
   - Use appropriate types (LocalDate, LocalTime, LocalDateTime)
   - Use immutable date objects
   - Handle time zones properly

## Common Use Cases

1. **Data Processing**
```java
List<Person> people = // ... get people
List<String> names = people.stream()
    .filter(p -> p.getAge() > 18)
    .map(Person::getName)
    .collect(Collectors.toList());
```

2. **Asynchronous Operations**
```java
CompletableFuture<List<String>> future = CompletableFuture
    .supplyAsync(() -> fetchData())
    .thenApply(this::processData)
    .thenApply(this::formatData);
```

3. **Null Safety**
```java
Optional<User> user = findUser(id);
String name = user
    .map(User::getName)
    .orElse("Unknown");
```

4. **Date Manipulation**
```java
LocalDate date = LocalDate.now()
    .plusDays(1)
    .with(TemporalAdjusters.next(DayOfWeek.MONDAY));
```

## Conclusion

Java 8+ features provide powerful tools for modern Java development. They enable:
- More concise and readable code
- Better functional programming support
- Improved null safety
- Modern date and time handling
- Better asynchronous programming
- Enhanced type safety

Remember to:
- Choose the right feature for your use case
- Follow best practices
- Consider backward compatibility
- Keep code readable and maintainable 