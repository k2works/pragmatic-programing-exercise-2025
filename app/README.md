# Pragmatic Programming Exercise 2025

A simple Clojure project with a "Hello World" function and tests.

## Project Structure

- `src/app/core.clj`: Contains the main application code with a `hello-world` function
- `test/app/core_test.clj`: Contains tests for the `hello-world` function
- `deps.edn`: Project configuration with dependencies

## Running the Application

To run the application:

```bash
clojure -M -m app.core
```

This will print "Hello, World!" to the console.

## Running the Tests

To run the tests:

```bash
clojure -M:test
```

This will run all tests in the project.

## Requirements

- [Clojure CLI tools](https://clojure.org/guides/install_clojure)