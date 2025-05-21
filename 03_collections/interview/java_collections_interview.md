# Java Collections and String Handling - Interview Guide

## 1. Arrays in Java

### Basic Array Concepts
```java
public class ArrayExamples {
    public static void main(String[] args) {
        // Array declaration and initialization
        int[] numbers = {1, 2, 3, 4, 5};
        String[] names = new String[3];
        
        // Multi-dimensional arrays
        int[][] matrix = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        
        // Array operations
        System.out.println("Length: " + numbers.length);
        System.out.println("First element: " + numbers[0]);
        System.out.println("Last element: " + numbers[numbers.length - 1]);
    }
}
```

### Common Array Operations
```java
public class ArrayOperations {
    // Find maximum element
    public static int findMax(int[] arr) {
        if (arr == null || arr.length == 0) {
            throw new IllegalArgumentException("Array is empty or null");
        }
        int max = arr[0];
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > max) {
                max = arr[i];
            }
        }
        return max;
    }
    
    // Reverse array
    public static void reverseArray(int[] arr) {
        int left = 0;
        int right = arr.length - 1;
        while (left < right) {
            // Swap elements
            int temp = arr[left];
            arr[left] = arr[right];
            arr[right] = temp;
            left++;
            right--;
        }
    }
    
    // Find duplicate elements
    public static List<Integer> findDuplicates(int[] arr) {
        List<Integer> duplicates = new ArrayList<>();
        Set<Integer> seen = new HashSet<>();
        
        for (int num : arr) {
            if (!seen.add(num)) {
                duplicates.add(num);
            }
        }
        return duplicates;
    }
}
```

**Interview Questions and Answers:**

1. **Q: What is the difference between Array and ArrayList?**
   ```java
   // Array: Fixed size, primitive types allowed
   int[] numbers = new int[5];
   
   // ArrayList: Dynamic size, only objects
   ArrayList<Integer> list = new ArrayList<>();
   ```
   - Arrays have fixed size, ArrayList is dynamic
   - Arrays can store primitives, ArrayList only objects
   - Arrays are faster for basic operations
   - ArrayList provides more utility methods

2. **Q: How do you find the second largest element in an array?**
   ```java
   public static int findSecondLargest(int[] arr) {
       if (arr == null || arr.length < 2) {
           throw new IllegalArgumentException("Invalid array");
       }
       
       int largest = Integer.MIN_VALUE;
       int secondLargest = Integer.MIN_VALUE;
       
       for (int num : arr) {
           if (num > largest) {
               secondLargest = largest;
               largest = num;
           } else if (num > secondLargest && num != largest) {
               secondLargest = num;
           }
       }
       return secondLargest;
   }
   ```

## 2. Strings in Java

### String Basics
```java
public class StringExamples {
    public static void main(String[] args) {
        // String creation
        String str1 = "Hello";
        String str2 = new String("Hello");
        
        // String methods
        System.out.println("Length: " + str1.length());
        System.out.println("Uppercase: " + str1.toUpperCase());
        System.out.println("Lowercase: " + str1.toLowerCase());
        System.out.println("Substring: " + str1.substring(0, 2));
        
        // String comparison
        System.out.println("Equals: " + str1.equals(str2));
        System.out.println("== : " + (str1 == str2));
    }
}
```

### Common String Operations
```java
public class StringOperations {
    // Check if string is palindrome
    public static boolean isPalindrome(String str) {
        if (str == null) return false;
        str = str.toLowerCase().replaceAll("[^a-z0-9]", "");
        int left = 0;
        int right = str.length() - 1;
        
        while (left < right) {
            if (str.charAt(left) != str.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
    
    // Count word frequency
    public static Map<String, Integer> countWordFrequency(String text) {
        Map<String, Integer> frequency = new HashMap<>();
        String[] words = text.toLowerCase().split("\\s+");
        
        for (String word : words) {
            frequency.put(word, frequency.getOrDefault(word, 0) + 1);
        }
        return frequency;
    }
}
```

**Interview Questions and Answers:**

1. **Q: Why are Strings immutable in Java?**
   - Security: Strings are used in sensitive operations
   - Thread safety: Can be shared between threads
   - Caching: String pool optimization
   - Class loading: Used in class loading mechanism

2. **Q: What is the difference between String, StringBuilder, and StringBuffer?**
   ```java
   // String: Immutable
   String str = "Hello";
   str = str + " World"; // Creates new object
   
   // StringBuilder: Mutable, not thread-safe
   StringBuilder sb = new StringBuilder("Hello");
   sb.append(" World"); // Modifies same object
   
   // StringBuffer: Mutable, thread-safe
   StringBuffer sbf = new StringBuffer("Hello");
   sbf.append(" World"); // Modifies same object, synchronized
   ```

## 3. StringBuilder and StringBuffer

### StringBuilder Examples
```java
public class StringBuilderExamples {
    public static void main(String[] args) {
        // Basic operations
        StringBuilder sb = new StringBuilder();
        sb.append("Hello");
        sb.append(" ");
        sb.append("World");
        
        // Chain methods
        StringBuilder result = new StringBuilder()
            .append("Hello")
            .append(" ")
            .append("World")
            .reverse();
            
        // Performance comparison
        long startTime = System.currentTimeMillis();
        StringBuilder performanceTest = new StringBuilder();
        for (int i = 0; i < 100000; i++) {
            performanceTest.append(i);
        }
        long endTime = System.currentTimeMillis();
        System.out.println("Time taken: " + (endTime - startTime) + "ms");
    }
}
```

### StringBuffer Examples
```java
public class StringBufferExamples {
    public static void main(String[] args) {
        // Thread-safe operations
        StringBuffer sbf = new StringBuffer();
        
        // Multiple threads can safely append
        Thread t1 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                sbf.append("A");
            }
        });
        
        Thread t2 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                sbf.append("B");
            }
        });
        
        t1.start();
        t2.start();
    }
}
```

**Interview Questions and Answers:**

1. **Q: When should you use StringBuilder vs StringBuffer?**
   - Use StringBuilder when:
     - Single-threaded environment
     - Better performance needed
     - No thread safety required
   - Use StringBuffer when:
     - Multi-threaded environment
     - Thread safety is required
     - Performance is not critical

2. **Q: How do you reverse a string without using StringBuilder?**
   ```java
   public static String reverseString(String str) {
       if (str == null) return null;
       char[] chars = str.toCharArray();
       int left = 0;
       int right = chars.length - 1;
       
       while (left < right) {
           char temp = chars[left];
           chars[left] = chars[right];
           chars[right] = temp;
           left++;
           right--;
       }
       return new String(chars);
   }
   ```

## Performance Comparison

```java
public class PerformanceComparison {
    public static void main(String[] args) {
        // String concatenation
        long start1 = System.currentTimeMillis();
        String result1 = "";
        for (int i = 0; i < 10000; i++) {
            result1 += i;
        }
        long end1 = System.currentTimeMillis();
        
        // StringBuilder
        long start2 = System.currentTimeMillis();
        StringBuilder result2 = new StringBuilder();
        for (int i = 0; i < 10000; i++) {
            result2.append(i);
        }
        long end2 = System.currentTimeMillis();
        
        // StringBuffer
        long start3 = System.currentTimeMillis();
        StringBuffer result3 = new StringBuffer();
        for (int i = 0; i < 10000; i++) {
            result3.append(i);
        }
        long end3 = System.currentTimeMillis();
        
        System.out.println("String time: " + (end1 - start1) + "ms");
        System.out.println("StringBuilder time: " + (end2 - start2) + "ms");
        System.out.println("StringBuffer time: " + (end3 - start3) + "ms");
    }
}
```

**Key Points for Interviews:**

1. **Arrays:**
   - Fixed size, direct access
   - Can store primitives
   - Multi-dimensional support
   - Zero-based indexing

2. **Strings:**
   - Immutable
   - String pool optimization
   - Thread-safe
   - Memory efficient for constants

3. **StringBuilder:**
   - Mutable
   - Not thread-safe
   - Better performance
   - Method chaining

4. **StringBuffer:**
   - Mutable
   - Thread-safe
   - Synchronized methods
   - Slightly slower than StringBuilder

Remember: In interviews, always explain the trade-offs and use cases for each option. Be prepared to discuss performance implications and thread safety considerations. 