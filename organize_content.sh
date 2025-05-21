#!/bin/bash

# Create directory structure
mkdir -p 01_java_fundamentals 02_object_oriented 03_collections 04_exceptions 05_multithreading 06_java8_features 07_advanced_topics

# Move and rename files for multithreading section
mv java_multithreading.md 05_multithreading/thread_basics.md
mv threading_examples.md 05_multithreading/real_world_examples.md

# Move and rename files for Java 8+ features section
mv java8_features.md 06_java8_features/README.md

# Create additional necessary files for multithreading section
touch 05_multithreading/synchronization.md
touch 05_multithreading/thread_pools.md
touch 05_multithreading/concurrent_collections.md

# Create additional necessary files for Java 8+ features section
touch 06_java8_features/lambda_expressions.md
touch 06_java8_features/stream_api.md
touch 06_java8_features/optional_class.md
touch 06_java8_features/date_time_api.md
touch 06_java8_features/completable_future.md

# Create section READMEs
for dir in 01_java_fundamentals 02_object_oriented 03_collections 04_exceptions 07_advanced_topics; do
    touch "$dir/README.md"
done

echo "Content organization complete!" 