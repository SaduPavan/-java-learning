#!/bin/bash

# Create main directory structure
mkdir -p 01_java_fundamentals/{basics,architecture,examples}
mkdir -p 02_object_oriented/{concepts,examples,interview}
mkdir -p 03_collections/{framework,operations,interview}
mkdir -p 04_exceptions/{basics,advanced,examples}
mkdir -p 05_multithreading/{basics,advanced,examples}
mkdir -p 06_java8_features/{basics,advanced,examples}
mkdir -p 07_advanced_topics/{jit,architecture,plugins}

# Move and organize Java Fundamentals content
mv java_fundamentals_examples.md 01_java_fundamentals/examples/
mv java_architecture_explanation.md 01_java_fundamentals/architecture/
mv java_core_concepts_interview.md 01_java_fundamentals/basics/

# Move and organize OOP content
mv banking_oop_concepts.md 02_object_oriented/examples/
mv java_core_concepts_interview.md 02_object_oriented/interview/

# Move and organize Collections content
mv java_collections_framework.md 03_collections/framework/
mv java_collections_interview.md 03_collections/interview/
mv java_stream_operations_guide.md 03_collections/operations/

# Move and organize Multithreading content
mv java_multithreading.md 05_multithreading/basics/
mv threading_examples.md 05_multithreading/examples/

# Move and organize Java 8+ Features content
mv java8_features.md 06_java8_features/basics/

# Move and organize Advanced Topics content
mv jit_compiler_explanation.md 07_advanced_topics/jit/
mv intellij_plugins.md 07_advanced_topics/plugins/

# Create section READMEs
for section in */; do
    touch "${section}README.md"
done

# Create main README.md if it doesn't exist
if [ ! -f README.md ]; then
    touch README.md
fi

echo "Content organization complete!" 