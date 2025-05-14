package primefactors

object PrimeFactorsTest {
  def main(args: Array[String]): Unit = {
    var testsPassed = 0
    var testsFailed = 0
    
    // Helper function to run a test case
    def testCase(description: String, expected: List[Int], actual: List[Int]): Unit = {
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
    testCase("returns [] for 1", List(), PrimeFactors.primeFactorsOf(1))
    testCase("returns [2] for 2", List(2), PrimeFactors.primeFactorsOf(2))
    testCase("returns [3] for 3", List(3), PrimeFactors.primeFactorsOf(3))
    testCase("returns [2, 2] for 4", List(2, 2), PrimeFactors.primeFactorsOf(4))
    testCase("returns [5] for 5", List(5), PrimeFactors.primeFactorsOf(5))
    testCase("returns [2, 3] for 6", List(2, 3), PrimeFactors.primeFactorsOf(6))
    testCase("returns [7] for 7", List(7), PrimeFactors.primeFactorsOf(7))
    testCase("returns [2, 2, 2] for 8", List(2, 2, 2), PrimeFactors.primeFactorsOf(8))
    testCase("returns [3, 3] for 9", List(3, 3), PrimeFactors.primeFactorsOf(9))
    testCase("returns [5, 5] for 25", List(5, 5), PrimeFactors.primeFactorsOf(25))
    
    // Additional test cases
    testCase("returns [2, 2, 5, 5] for 100", List(2, 2, 5, 5), PrimeFactors.primeFactorsOf(100))
    testCase("returns [11, 13] for 143", List(11, 13), PrimeFactors.primeFactorsOf(143))
    
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