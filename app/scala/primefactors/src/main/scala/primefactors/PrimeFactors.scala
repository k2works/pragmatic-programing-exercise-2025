package primefactors

import scala.annotation.tailrec

object PrimeFactors {
  def primeFactorsOf(n: Int): List[Int] = {
    @tailrec
    def loop(n: Int, divisor: Int, factors: List[Int]): List[Int] = {
      if (n <= 1) {
        factors
      } else if (n % divisor == 0) {
        loop(n / divisor, divisor, factors :+ divisor)
      } else {
        loop(n, divisor + 1, factors)
      }
    }
    
    loop(n, 2, List())
  }
  
  def main(args: Array[String]): Unit = {
    if (args.length > 0) {
      try {
        val number = args(0).toInt
        val factors = primeFactorsOf(number)
        println(s"Prime factors of $number: ${factors.mkString(", ")}")
      } catch {
        case e: NumberFormatException =>
          println(s"Error: '${args(0)}' is not a valid integer")
      }
    } else {
      println("Please provide a number as an argument")
    }
  }
}