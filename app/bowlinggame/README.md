# Bowling Game Score Calculator

A Clojure implementation of a bowling game score calculator. This project demonstrates functional programming principles and test-driven development in Clojure.

## Overview

This application implements the scoring rules for a standard ten-pin bowling game. The implementation handles:

- Basic scoring
- Spares (knocking down all 10 pins in two rolls)
- Strikes (knocking down all 10 pins in one roll)
- Bonus rolls for the 10th frame

## Installation

Make sure you have [Clojure](https://clojure.org/guides/getting_started) and the Clojure CLI tools installed.

Clone this repository and navigate to the project directory:

```bash
git clone <repository-url>
cd bowlinggame
```

## Usage

The core functionality is provided by the `bowlinggame.core` namespace. Here's how to use it:

```clojure
(require '[bowlinggame.core :refer :all])

;; Create a new game
(def game (new-game))

;; Roll some pins
(def game-with-rolls 
  (-> game
      (roll 10)    ;; Strike
      (roll 7)
      (roll 2)
      ;; ... more rolls
      ))

;; Calculate the score
(score game-with-rolls)
```

## Running Tests

This project uses [speclj](https://github.com/slagyr/speclj) for testing. To run the tests:

```bash
clojure -M:spec
```

The project also supports Clojure's built-in test framework:

```bash
clojure -M:test
```

## Implementation Details

The implementation follows a functional approach:

- `new-game`: Creates a new game state with empty rolls
- `roll`: Records a roll in the game, adding the number of pins knocked down
- `score`: Calculates the total score for a bowling game

Helper functions handle special cases like strikes and spares:

- `is-spare?`: Checks if a frame is a spare
- `is-strike?`: Checks if a frame is a strike
- `spare-bonus`: Calculates the bonus for a spare
- `strike-bonus`: Calculates the bonus for a strike

## Bowling Scoring Rules

In bowling:
- A game consists of 10 frames
- In each frame, the player has two opportunities to knock down 10 pins
- The score for a frame is the total number of pins knocked down, plus bonuses for strikes and spares
- A spare is when the player knocks down all 10 pins in two tries. The bonus is the value of the next roll
- A strike is when the player knocks down all 10 pins on the first try. The bonus is the value of the next two rolls
- In the 10th frame, a player who rolls a spare or strike is allowed to roll extra balls to complete the frame (up to 3 rolls total)

## License

This project is available under the [MIT License](LICENSE).