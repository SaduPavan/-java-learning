# Java Multithreading and Concurrency Guide

## 1. Thread Lifecycle
A thread in Java goes through various states during its lifecycle:

1. **New**: Thread is created but not yet started
2. **Runnable**: Thread is ready to run and is waiting for CPU
3. **Running**: Thread is executing
4. **Blocked/Waiting**: Thread is waiting for I/O or another thread
5. **Terminated**: Thread has completed its execution

```java
// Example of thread lifecycle
Thread thread = new Thread(() -> {
    System.out.println("Thread is running");
});
// New state
thread.start(); // Runnable state
// Thread executes and moves to Terminated state
```

## 2. Creating Threads
There are two main ways to create threads in Java:

### Method 1: Extending Thread class
```java
class MyThread extends Thread {
    public void run() {
        System.out.println("Thread running");
    }
}

MyThread thread = new MyThread();
thread.start();
```

### Method 2: Implementing Runnable interface
```java
class MyRunnable implements Runnable {
    public void run() {
        System.out.println("Thread running");
    }
}

Thread thread = new Thread(new MyRunnable());
thread.start();
```

## 3. Thread Synchronization
Synchronization prevents multiple threads from accessing shared resources simultaneously.

### Using synchronized keyword
```java
class Counter {
    private int count = 0;
    
    public synchronized void increment() {
        count++;
    }
    
    public synchronized int getCount() {
        return count;
    }
}
```

### Using synchronized blocks
```java
class Counter {
    private int count = 0;
    private Object lock = new Object();
    
    public void increment() {
        synchronized(lock) {
            count++;
        }
    }
}
```

## 4. Deadlock
Deadlock occurs when two or more threads are blocked forever, waiting for each other.

```java
// Example of potential deadlock
class DeadlockExample {
    private final Object lock1 = new Object();
    private final Object lock2 = new Object();
    
    public void method1() {
        synchronized(lock1) {
            synchronized(lock2) {
                // Critical section
            }
        }
    }
    
    public void method2() {
        synchronized(lock2) {
            synchronized(lock1) {
                // Critical section
            }
        }
    }
}
```

## 5. Thread Pool
Thread pools manage a pool of worker threads to execute tasks efficiently.

```java
// Creating a thread pool
ExecutorService executor = Executors.newFixedThreadPool(5);

// Submitting tasks
executor.submit(() -> {
    System.out.println("Task executed by thread pool");
});

// Shutting down
executor.shutdown();
```

## 6. Executor Framework
The Executor framework provides a higher-level replacement for working with threads.

### Types of Executors:
1. **FixedThreadPool**: Fixed number of threads
2. **CachedThreadPool**: Creates new threads as needed
3. **SingleThreadExecutor**: Single worker thread
4. **ScheduledThreadPool**: For scheduled tasks

```java
// Fixed thread pool example
ExecutorService executor = Executors.newFixedThreadPool(3);
for (int i = 0; i < 5; i++) {
    executor.submit(() -> {
        System.out.println("Task " + i + " executed");
    });
}
```

## 7. Callable and Future
Callable and Future allow threads to return values and handle exceptions.

```java
Callable<Integer> task = () -> {
    // Some computation
    return 42;
};

Future<Integer> future = executor.submit(task);
Integer result = future.get(); // Waits for result
```

## 8. Concurrent Collections
Thread-safe collections from java.util.concurrent package:

1. **ConcurrentHashMap**: Thread-safe HashMap
2. **CopyOnWriteArrayList**: Thread-safe ArrayList
3. **BlockingQueue**: Thread-safe queue implementations

```java
// ConcurrentHashMap example
ConcurrentHashMap<String, Integer> map = new ConcurrentHashMap<>();
map.put("key", 1);
```

## 9. Atomic Classes
Atomic classes provide thread-safe operations on single variables.

```java
// AtomicInteger example
AtomicInteger counter = new AtomicInteger(0);
counter.incrementAndGet(); // Thread-safe increment
```

## 10. Volatile Keyword
The volatile keyword ensures visibility of changes to variables across threads.

```java
class SharedObject {
    private volatile boolean flag = false;
    
    public void setFlag() {
        flag = true;
    }
    
    public boolean isFlag() {
        return flag;
    }
}
```

## 11. ThreadLocal
ThreadLocal provides thread-local variables.

```java
class ThreadLocalExample {
    private static ThreadLocal<Integer> threadLocal = new ThreadLocal<>();
    
    public void setValue(int value) {
        threadLocal.set(value);
    }
    
    public int getValue() {
        return threadLocal.get();
    }
}
```

## Best Practices

1. **Avoid Thread Creation**: Use thread pools instead of creating threads manually
2. **Synchronization**: Use the most granular synchronization possible
3. **Deadlock Prevention**: Always acquire locks in the same order
4. **Resource Management**: Properly close resources in finally blocks
5. **Exception Handling**: Handle exceptions in thread execution
6. **Thread Safety**: Use thread-safe collections when needed
7. **Performance**: Monitor thread pool sizes and adjust as needed

## Common Pitfalls

1. **Race Conditions**: Always synchronize access to shared resources
2. **Deadlocks**: Be careful with multiple lock acquisition
3. **Thread Leaks**: Always shut down thread pools
4. **Memory Leaks**: Be careful with ThreadLocal usage
5. **Over-synchronization**: Don't synchronize unnecessarily

## Conclusion

Understanding multithreading and concurrency is crucial for building efficient Java applications. Always consider thread safety, proper resource management, and performance implications when working with multiple threads. 