package hello

object HelloWorldTest {
  def main(args: Array[String]): Unit = {
    // Test 1: Verify the message is correct
    val expectedMessage = "Hello, World!"
    val actualMessage = HelloWorld.message
    
    if (actualMessage == expectedMessage) {
      println("Test passed: Message is correct")
    } else {
      println(s"Test failed: Expected '$expectedMessage' but got '$actualMessage'")
    }
    
    // Test 2: Verify main method runs without errors
    try {
      HelloWorld.main(Array())
      println("Test passed: Main method executed without errors")
    } catch {
      case e: Exception => 
        println(s"Test failed: Main method threw an exception: ${e.getMessage}")
    }
    
    println("All tests completed")
  }
}