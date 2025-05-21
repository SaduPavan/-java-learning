# Java Stream Operations Guide

## 1. Basic Stream Operations

### map() vs flatMap()
```java
// map() - transforms each element into a single new element
List<String> names = Arrays.asList("John", "Jane", "Bob");
List<Integer> nameLengths = names.stream()
    .map(String::length)  // Transform each name to its length
    .collect(Collectors.toList());
// Result: [4, 4, 3]

// flatMap() - transforms each element into multiple elements
List<List<String>> lists = Arrays.asList(
    Arrays.asList("a", "b"),
    Arrays.asList("c", "d")
);
List<String> flattened = lists.stream()
    .flatMap(List::stream)  // Flatten nested lists
    .collect(Collectors.toList());
// Result: [a, b, c, d]
```

### filter() vs findFirst() vs findAny()
```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6);

// filter() - selects elements matching a condition
List<Integer> evenNumbers = numbers.stream()
    .filter(n -> n % 2 == 0)
    .collect(Collectors.toList());
// Result: [2, 4, 6]

// findFirst() - gets the first element (ordered)
Optional<Integer> firstEven = numbers.stream()
    .filter(n -> n % 2 == 0)
    .findFirst();
// Result: Optional[2]

// findAny() - gets any element (better for parallel streams)
Optional<Integer> anyEven = numbers.stream()
    .filter(n -> n % 2 == 0)
    .findAny();
// Result: Optional[2] or any other even number
```

## 2. Collection Operations

### collect() with Different Collectors
```java
List<String> fruits = Arrays.asList("Apple", "Banana", "Orange", "Apple");

// toList() - collects to a List
List<String> list = fruits.stream()
    .collect(Collectors.toList());

// toSet() - collects to a Set (removes duplicates)
Set<String> set = fruits.stream()
    .collect(Collectors.toSet());
// Result: [Apple, Banana, Orange]

// toMap() - collects to a Map
Map<String, Integer> map = fruits.stream()
    .collect(Collectors.toMap(
        fruit -> fruit,           // key mapper
        fruit -> fruit.length(),  // value mapper
        (v1, v2) -> v1           // merge function for duplicates
    ));
// Result: {Apple=5, Banana=6, Orange=6}

// groupingBy() - groups elements by a classifier
Map<Integer, List<String>> groupedByLength = fruits.stream()
    .collect(Collectors.groupingBy(String::length));
// Result: {5=[Apple, Apple], 6=[Banana, Orange]}

// partitioningBy() - splits into two groups based on a predicate
Map<Boolean, List<String>> partitioned = fruits.stream()
    .collect(Collectors.partitioningBy(s -> s.length() > 5));
// Result: {false=[Apple, Apple], true=[Banana, Orange]}
```

## 3. Reduction Operations

### reduce() vs collect()
```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

// reduce() - combines elements into a single result
Optional<Integer> sum = numbers.stream()
    .reduce(Integer::sum);
// Result: Optional[15]

// collect() with reducing - more flexible reduction
Integer sum2 = numbers.stream()
    .collect(Collectors.reducing(0, Integer::sum));
// Result: 15

// Custom reduction
String concatenated = numbers.stream()
    .map(String::valueOf)
    .collect(Collectors.joining(", "));
// Result: "1, 2, 3, 4, 5"
```

## 4. Specialized Operations

### distinct() vs filter()
```java
List<String> names = Arrays.asList("John", "John", "Jane", "Bob", "Jane");

// distinct() - removes duplicates
List<String> uniqueNames = names.stream()
    .distinct()
    .collect(Collectors.toList());
// Result: [John, Jane, Bob]

// filter() with custom logic
List<String> customFiltered = names.stream()
    .filter(name -> name.length() > 3)
    .collect(Collectors.toList());
// Result: [John, John, Jane, Jane]
```

### sorted() vs comparing()
```java
List<Person> people = Arrays.asList(
    new Person("John", 30),
    new Person("Jane", 25),
    new Person("Bob", 35)
);

// sorted() with natural ordering
List<Person> sortedByName = people.stream()
    .sorted(Comparator.comparing(Person::getName))
    .collect(Collectors.toList());

// sorted() with multiple comparators
List<Person> sortedByAgeThenName = people.stream()
    .sorted(Comparator.comparing(Person::getAge)
        .thenComparing(Person::getName))
    .collect(Collectors.toList());
```

## 5. When to Use Each Operation

### map()
- When you need to transform each element into a single new element
- When the transformation is one-to-one
- Example: Converting strings to their lengths

### flatMap()
- When you need to transform each element into multiple elements
- When dealing with nested collections
- Example: Flattening lists of lists

### filter()
- When you need to select elements based on a condition
- When you want to remove unwanted elements
- Example: Finding even numbers

### collect()
- When you need to gather results into a collection
- When you need to perform complex grouping or partitioning
- Example: Creating maps or grouping elements

### reduce()
- When you need to combine elements into a single result
- When performing operations like sum, product, or concatenation
- Example: Calculating total sum

### distinct()
- When you need to remove duplicates
- When order doesn't matter
- Example: Getting unique values

### sorted()
- When you need to order elements
- When you need custom sorting logic
- Example: Sorting by multiple fields

## 6. Best Practices

1. **Choose the Right Operation:**
   - Use `map()` for one-to-one transformations
   - Use `flatMap()` for one-to-many transformations
   - Use `filter()` for selecting elements
   - Use `collect()` for gathering results

2. **Performance Considerations:**
   - Use `findAny()` instead of `findFirst()` in parallel streams
   - Use `distinct()` before `sorted()` for better performance
   - Use `limit()` early in the stream to reduce processing

3. **Readability:**
   - Chain operations in a logical order
   - Use method references when possible
   - Break complex streams into multiple steps

4. **Error Handling:**
   - Use `Optional` for operations that might not return a value
   - Handle null values appropriately
   - Use `filter()` to remove null values before processing

## 7. Common Use Cases

### Data Transformation
```java
// Transform list of names to uppercase
List<String> upperNames = names.stream()
    .map(String::toUpperCase)
    .collect(Collectors.toList());
```

### Data Filtering
```java
// Filter and transform in one stream
List<String> longUpperNames = names.stream()
    .filter(name -> name.length() > 3)
    .map(String::toUpperCase)
    .collect(Collectors.toList());
```

### Data Aggregation
```java
// Group and count
Map<String, Long> nameCounts = names.stream()
    .collect(Collectors.groupingBy(
        Function.identity(),
        Collectors.counting()
    ));
```

### Data Validation
```java
// Validate and collect valid elements
List<String> validNames = names.stream()
    .filter(name -> name != null && !name.isEmpty())
    .collect(Collectors.toList());
``` 