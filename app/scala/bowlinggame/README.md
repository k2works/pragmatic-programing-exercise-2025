# Bowling Game in Scala

This is a Scala implementation of the Bowling Game kata, based on the Clojure implementation.

## Project Structure

```
bowlinggame/
├── src/
│   ├── main/
│   │   └── scala/
│   │       └── bowlinggame/
│   │           └── BowlingGame.scala
│   └── test/
│       └── scala/
│           └── bowlinggame/
│               └── BowlingGameTest.scala
└── build.sbt
```

## Implementation

The implementation consists of three main functions:

1. `toFrames`: Converts a list of rolls into frames, handling:
   - Strike (10 pins): Takes 3 rolls (the strike plus the next two rolls)
   - Spare (10 pins in 2 rolls): Takes 3 rolls (the spare plus the next roll)
   - Normal frame: Takes 2 rolls

2. `addFrame`: Adds the score of a frame to the total score

3. `score`: Calculates the total score by taking the first 10 frames and summing their scores

## Running the Tests

To run the tests, use the following command:

```
sbt "Test / runMain bowlinggame.BowlingGameTest"
```

## Running the Application

To run the application, use the following command:

```
sbt "runMain bowlinggame.BowlingGame <roll1> <roll2> ... <rollN>"
```

Where `<roll1>`, `<roll2>`, etc. are the scores for each roll.