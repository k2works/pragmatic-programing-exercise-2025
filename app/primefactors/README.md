# Prime Factors

A simple Clojure library that calculates the prime factors of a given number.

## Description

This project implements a function that decomposes a number into its prime factors. Prime factorization is the process of determining which prime numbers multiply together to form a given number.

For example:
- The prime factors of 12 are 2, 2, and 3 (2 × 2 × 3 = 12)
- The prime factors of 100 are 2, 2, 5, and 5 (2 × 2 × 5 × 5 = 100)

## Installation

This project uses the Clojure CLI tools with deps.edn for dependency management.

1. Make sure you have [Clojure CLI tools](https://clojure.org/guides/getting_started) installed
2. Clone this repository
3. Navigate to the project directory

## Usage

To use the prime-factors function in your code:

```clojure
(require '[primefactors.core :refer [prime-factors]])

(prime-factors 1)  ; => []
(prime-factors 2)  ; => [2]
(prime-factors 12) ; => [2 2 3]
(prime-factors 100) ; => [2 2 5 5]
```

## Algorithm

The prime factorization algorithm used in this project:

1. Start with the smallest prime number (2) as the potential divisor
2. Check if the number is divisible by the current divisor
   - If yes, add the divisor to the list of factors and divide the number by the divisor
   - If no, increment the divisor by 1
3. Repeat until the divisor is greater than the remaining number

This implementation returns the prime factors in ascending order.

## Testing

This project uses [speclj](https://github.com/slagyr/speclj) for testing. To run the tests:

```bash
clojure -M:spec
```

The tests verify that the prime-factors function correctly decomposes various numbers into their prime factors.

## Project Structure

```
.
├── deps.edn                      # Project dependencies and configuration
├── README.md                     # This file
├── src
│   └── primefactors
│       └── core.clj              # Core functionality
└── spec
    └── primefactors
        └── core_spec.clj         # Tests
```