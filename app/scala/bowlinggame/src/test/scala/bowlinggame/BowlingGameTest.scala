package bowlinggame

object BowlingGameTest {
  def main(args: Array[String]): Unit = {
    var testsPassed = 0
    var testsFailed = 0
    
    // Helper function to run a test case
    def testCase(description: String, expected: Int, actual: Int): Unit = {
      if (actual == expected) {
        println(s"Test passed: $description")
        testsPassed += 1
      } else {
        println(s"Test failed: $description")
        println(s"  Expected: $expected")
        println(s"  Actual:   $actual")
        testsFailed += 1
      }
    }
    
    // Test cases from the Clojure implementation
    testCase("should score 0 for a gutter game", 
             0, 
             BowlingGame.score(List.fill(20)(0)))
             
    testCase("should score 24 for spare", 
             24, 
             BowlingGame.score(List(5, 5, 7) ++ List.fill(17)(0)))
             
    testCase("should score 20 for all ones", 
             20, 
             BowlingGame.score(List.fill(20)(1)))
             
    testCase("should score 20 for strike", 
             20, 
             BowlingGame.score(List(10, 2, 3) ++ List.fill(16)(0)))
             
    testCase("should score 300 for perfect game", 
             300, 
             BowlingGame.score(List.fill(12)(10)))
    
    // Additional test cases
    testCase("should score 16 for spares in last frame", 
             16, 
             BowlingGame.score(List.fill(18)(0) ++ List(5, 5, 6)))
             
    testCase("should score 26 for strike in last frame", 
             26, 
             BowlingGame.score(List.fill(18)(0) ++ List(10, 8, 8)))
    
    // Summary
    println("\nTest summary:")
    println(s"  Passed: $testsPassed")
    println(s"  Failed: $testsFailed")
    println(s"  Total:  ${testsPassed + testsFailed}")
    
    if (testsFailed > 0) {
      System.exit(1)
    }
  }
}