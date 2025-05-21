# Java Collections Framework - Interview Guide

## 1. List Interface and Implementations

### ArrayList vs LinkedList vs Vector
```java
public class ListComparison {
    public static void main(String[] args) {
        // ArrayList: Dynamic array, fast random access
        ArrayList<String> arrayList = new ArrayList<>();
        arrayList.add("A"); // O(1) amortized
        arrayList.get(0);   // O(1)
        arrayList.add(0, "B"); // O(n) - shifts elements
        
        // LinkedList: Doubly linked list, fast insertions/deletions
        LinkedList<String> linkedList = new LinkedList<>();
        linkedList.add("A");    // O(1)
        linkedList.get(0);      // O(n)
        linkedList.addFirst("B"); // O(1)
        
        // Vector: Thread-safe ArrayList
        Vector<String> vector = new Vector<>();
        vector.add("A"); // Synchronized, thread-safe
    }
}
```

**When to Use Each:**
1. **ArrayList:**
   - Frequent random access
   - Less frequent insertions/deletions
   - Single-threaded environment
   - Example: Reading data from database

2. **LinkedList:**
   - Frequent insertions/deletions
   - Less frequent random access
   - Need for Queue/Deque operations
   - Example: Implementing undo/redo functionality

3. **Vector:**
   - Thread-safe operations needed
   - Legacy code compatibility
   - Example: Multi-threaded data processing

## 2. Set Interface and Implementations

### HashSet vs TreeSet vs LinkedHashSet
```java
public class SetComparison {
    public static void main(String[] args) {
        // HashSet: Unordered, O(1) operations
        HashSet<String> hashSet = new HashSet<>();
        hashSet.add("A"); // O(1)
        hashSet.contains("A"); // O(1)
        
        // TreeSet: Sorted, O(log n) operations
        TreeSet<String> treeSet = new TreeSet<>();
        treeSet.add("A"); // O(log n)
        treeSet.first(); // O(log n)
        
        // LinkedHashSet: Maintains insertion order
        LinkedHashSet<String> linkedHashSet = new LinkedHashSet<>();
        linkedHashSet.add("A"); // O(1)
        // Maintains order of insertion
    }
}
```

**When to Use Each:**
1. **HashSet:**
   - Need unique elements
   - Order doesn't matter
   - Fast operations
   - Example: Finding unique words in text

2. **TreeSet:**
   - Need sorted elements
   - Range operations
   - Example: Maintaining sorted leaderboard

3. **LinkedHashSet:**
   - Need unique elements
   - Maintain insertion order
   - Example: Cache with LRU policy

## 3. Map Interface and Implementations

### HashMap Implementation (Detailed)
```java
public class HashMapImplementation {
    // Simplified HashMap structure
    static class Node<K,V> {
        final K key;
        V value;
        Node<K,V> next;
        int hash;
        
        Node(int hash, K key, V value, Node<K,V> next) {
            this.hash = hash;
            this.key = key;
            this.value = value;
            this.next = next;
        }
    }
    
    // Key components of HashMap
    static class HashMap<K,V> {
        Node<K,V>[] table;        // Array of buckets
        int size;                 // Number of key-value mappings
        float loadFactor;         // Load factor threshold
        int threshold;            // Next size threshold
        
        // Constructor
        public HashMap(int initialCapacity, float loadFactor) {
            this.loadFactor = loadFactor;
            this.threshold = (int)(initialCapacity * loadFactor);
            this.table = new Node[initialCapacity];
        }
        
        // Hash function
        static final int hash(Object key) {
            int h;
            return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
        }
        
        // Put operation
        public V put(K key, V value) {
            int hash = hash(key);
            int index = (table.length - 1) & hash;
            
            // Check if key already exists
            for (Node<K,V> e = table[index]; e != null; e = e.next) {
                if (e.hash == hash && (e.key == key || key.equals(e.key))) {
                    V oldValue = e.value;
                    e.value = value;
                    return oldValue;
                }
            }
            
            // Add new node
            addNode(hash, key, value, index);
            return null;
        }
        
        // Get operation
        public V get(Object key) {
            int hash = hash(key);
            int index = (table.length - 1) & hash;
            
            for (Node<K,V> e = table[index]; e != null; e = e.next) {
                if (e.hash == hash && (e.key == key || key.equals(e.key))) {
                    return e.value;
                }
            }
            return null;
        }
    }
}
```

**HashMap Key Concepts:**
1. **Internal Structure:**
   - Array of buckets (Node<K,V>[])
   - Each bucket is a linked list
   - Default initial capacity: 16
   - Default load factor: 0.75

2. **Hash Function:**
   - Uses key's hashCode()
   - Applies additional hash function to reduce collisions
   - Handles null keys

3. **Collision Resolution:**
   - Separate chaining (linked list)
   - Converts to tree when list length > 8
   - Converts back to list when tree nodes < 6

4. **Resizing:**
   - When size > threshold
   - Doubles capacity
   - Rehashes all elements

### HashMap vs TreeMap vs LinkedHashMap
```java
public class MapComparison {
    public static void main(String[] args) {
        // HashMap: Unordered, O(1) operations
        HashMap<String, Integer> hashMap = new HashMap<>();
        hashMap.put("A", 1); // O(1)
        hashMap.get("A");    // O(1)
        
        // TreeMap: Sorted, O(log n) operations
        TreeMap<String, Integer> treeMap = new TreeMap<>();
        treeMap.put("A", 1); // O(log n)
        treeMap.firstKey();  // O(log n)
        
        // LinkedHashMap: Maintains insertion order
        LinkedHashMap<String, Integer> linkedHashMap = new LinkedHashMap<>();
        linkedHashMap.put("A", 1); // O(1)
        // Maintains order of insertion
    }
}
```

**When to Use Each:**
1. **HashMap:**
   - General purpose mapping
   - Order doesn't matter
   - Fast operations
   - Example: Cache implementation

2. **TreeMap:**
   - Need sorted keys
   - Range operations
   - Example: Dictionary with alphabetical order

3. **LinkedHashMap:**
   - Need insertion order
   - LRU cache implementation
   - Example: Browser history

## 4. Queue Interface and Implementations

### PriorityQueue vs ArrayDeque
```java
public class QueueComparison {
    public static void main(String[] args) {
        // PriorityQueue: Heap-based, sorted
        PriorityQueue<Integer> priorityQueue = new PriorityQueue<>();
        priorityQueue.offer(5); // O(log n)
        priorityQueue.poll();   // O(log n)
        
        // ArrayDeque: Array-based, double-ended
        ArrayDeque<Integer> arrayDeque = new ArrayDeque<>();
        arrayDeque.offer(5);    // O(1)
        arrayDeque.poll();      // O(1)
        arrayDeque.offerFirst(3); // O(1)
    }
}
```

**When to Use Each:**
1. **PriorityQueue:**
   - Need sorted elements
   - Task scheduling
   - Example: Process scheduling

2. **ArrayDeque:**
   - Need double-ended operations
   - Stack/Queue operations
   - Example: Sliding window algorithm

## 5. Common Interview Questions

1. **Q: How does HashMap handle collisions?**
   - Uses separate chaining
   - Converts to tree when list length > 8
   - Uses linked list for small buckets
   - Rehashes during resizing

2. **Q: What is the difference between HashMap and Hashtable?**
   - HashMap is not synchronized, Hashtable is
   - HashMap allows null keys/values, Hashtable doesn't
   - HashMap is faster in single-threaded environment
   - Hashtable is legacy class

3. **Q: How do you make HashMap thread-safe?**
   ```java
   // Using Collections.synchronizedMap
   Map<String, Integer> syncMap = Collections.synchronizedMap(new HashMap<>());
   
   // Using ConcurrentHashMap
   ConcurrentHashMap<String, Integer> concurrentMap = new ConcurrentHashMap<>();
   ```

4. **Q: What is the difference between Comparable and Comparator?**
   ```java
   // Comparable: Natural ordering
   class Person implements Comparable<Person> {
       @Override
       public int compareTo(Person other) {
           return this.name.compareTo(other.name);
       }
   }
   
   // Comparator: Custom ordering
   Comparator<Person> ageComparator = (p1, p2) -> p1.age - p2.age;
   ```

## 6. Best Practices

1. **Choosing the Right Collection:**
   - Consider access patterns
   - Consider thread safety
   - Consider ordering requirements
   - Consider performance characteristics

2. **HashMap Optimization:**
   - Set appropriate initial capacity
   - Use good hashCode() implementation
   - Consider load factor
   - Use ConcurrentHashMap for thread safety

3. **Collection Operations:**
   - Use bulk operations when possible
   - Consider using streams for complex operations
   - Use appropriate iteration methods
   - Handle null values properly

Remember: In interviews, always explain the trade-offs and use cases for each collection type. Be prepared to discuss implementation details, especially for HashMap. 