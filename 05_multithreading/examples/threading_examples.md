# Real-World Threading Examples in Java

## 1. Web Server Handling Multiple Requests
```java
public class WebServer {
    private final ExecutorService threadPool = Executors.newFixedThreadPool(10);
    
    public void handleRequest(Socket clientSocket) {
        threadPool.submit(() -> {
            try {
                // Handle client request
                processRequest(clientSocket);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
    
    private void processRequest(Socket clientSocket) throws IOException {
        // Process HTTP request
        // Send response
    }
}
```

## 2. File Processing with Multiple Threads
```java
public class FileProcessor {
    private final ExecutorService executor = Executors.newFixedThreadPool(4);
    
    public void processLargeFile(String filePath) {
        List<String> chunks = splitFileIntoChunks(filePath);
        
        List<Future<String>> results = new ArrayList<>();
        for (String chunk : chunks) {
            Future<String> future = executor.submit(() -> processChunk(chunk));
            results.add(future);
        }
        
        // Collect results
        for (Future<String> result : results) {
            try {
                String processedData = result.get();
                // Handle processed data
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
```

## 3. Background Tasks in GUI Applications
```java
public class GUIApplication {
    private final ExecutorService backgroundExecutor = Executors.newSingleThreadExecutor();
    
    public void performLongTask() {
        // Show loading indicator
        showLoadingIndicator();
        
        backgroundExecutor.submit(() -> {
            try {
                // Perform time-consuming task
                String result = processData();
                
                // Update UI on the EDT
                SwingUtilities.invokeLater(() -> {
                    updateUI(result);
                    hideLoadingIndicator();
                });
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }
}
```

## 4. Producer-Consumer Pattern
```java
public class ProducerConsumer {
    private final BlockingQueue<Item> queue = new LinkedBlockingQueue<>(10);
    
    class Producer implements Runnable {
        public void run() {
            try {
                while (true) {
                    Item item = produceItem();
                    queue.put(item); // Blocks if queue is full
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
    
    class Consumer implements Runnable {
        public void run() {
            try {
                while (true) {
                    Item item = queue.take(); // Blocks if queue is empty
                    processItem(item);
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
}
```

## 5. Parallel Data Processing
```java
public class ParallelDataProcessor {
    private final ExecutorService executor = Executors.newFixedThreadPool(
        Runtime.getRuntime().availableProcessors()
    );
    
    public List<Result> processData(List<Data> dataList) {
        return dataList.parallelStream()
            .map(data -> {
                try {
                    return executor.submit(() -> processDataItem(data)).get();
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            })
            .collect(Collectors.toList());
    }
}
```

## 6. Caching with ConcurrentHashMap
```java
public class CacheManager {
    private final ConcurrentHashMap<String, Object> cache = new ConcurrentHashMap<>();
    
    public Object getValue(String key) {
        return cache.computeIfAbsent(key, this::loadValue);
    }
    
    private Object loadValue(String key) {
        // Load value from database or external service
        return null; // Replace with actual implementation
    }
}
```

## 7. Scheduled Tasks
```java
public class ScheduledTaskManager {
    private final ScheduledExecutorService scheduler = 
        Executors.newScheduledThreadPool(1);
    
    public void schedulePeriodicTask() {
        scheduler.scheduleAtFixedRate(
            () -> {
                try {
                    performPeriodicTask();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            },
            0,      // initial delay
            1,      // period
            TimeUnit.HOURS
        );
    }
}
```

## 8. Thread-Safe Counter with AtomicInteger
```java
public class ThreadSafeCounter {
    private final AtomicInteger counter = new AtomicInteger(0);
    
    public void increment() {
        counter.incrementAndGet();
    }
    
    public int getCount() {
        return counter.get();
    }
}
```

## 9. Resource Pool Management
```java
public class ResourcePool<T> {
    private final BlockingQueue<T> pool;
    
    public ResourcePool(List<T> resources) {
        this.pool = new LinkedBlockingQueue<>(resources);
    }
    
    public T acquire() throws InterruptedException {
        return pool.take();
    }
    
    public void release(T resource) {
        pool.offer(resource);
    }
}
```

## 10. Parallel Image Processing
```java
public class ImageProcessor {
    private final ExecutorService executor = Executors.newFixedThreadPool(4);
    
    public void processImages(List<Image> images) {
        List<Future<ProcessedImage>> futures = images.stream()
            .map(image -> executor.submit(() -> processImage(image)))
            .collect(Collectors.toList());
            
        for (Future<ProcessedImage> future : futures) {
            try {
                ProcessedImage result = future.get();
                // Handle processed image
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
```

## Best Practices for These Examples

1. **Resource Management**
   - Always shut down thread pools when done
   - Use try-with-resources for auto-closing
   - Handle exceptions properly

2. **Performance Considerations**
   - Choose appropriate thread pool size
   - Monitor thread pool usage
   - Use appropriate data structures

3. **Error Handling**
   - Implement proper exception handling
   - Use try-catch blocks appropriately
   - Log errors for debugging

4. **Thread Safety**
   - Use thread-safe collections
   - Implement proper synchronization
   - Avoid shared mutable state

## Conclusion

These examples demonstrate common use cases for threading in Java applications. Remember to:
- Choose the right threading approach for your use case
- Handle resources and exceptions properly
- Monitor performance and adjust thread pool sizes
- Use appropriate thread-safe data structures
- Implement proper synchronization mechanisms 