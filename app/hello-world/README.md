# Hello World Clojure Project

A simple Clojure project that demonstrates a basic "Hello World" application with tests.

## Project Structure

```
hello-world/
├── deps.edn         # Project dependencies and configuration
├── src/
│   └── hello_world/
│       └── core.clj # Main application code
└── test/
    └── hello_world/
        └── core_test.clj # Test code
```

## Features

- Simple "Hello, World!" function
- Unit tests
- Command-line execution

## Requirements

- [Clojure](https://clojure.org/guides/getting_started) (1.11.1 or later)
- [Clojure CLI tools](https://clojure.org/guides/deps_and_cli)

## Running the Application

To run the application:

```bash
clojure -M:run
```

This will execute the main function and print "Hello, World!" to the console.

## Running Tests

To run the tests:

```bash
clojure -M:test
```

## Development

The project uses the standard Clojure project structure:

- `src/hello_world/core.clj` contains the main application code
- `test/hello_world/core_test.clj` contains the test code
- `deps.edn` contains the project dependencies and configuration

## License

This project is open source and available under the [MIT License](https://opensource.org/licenses/MIT).