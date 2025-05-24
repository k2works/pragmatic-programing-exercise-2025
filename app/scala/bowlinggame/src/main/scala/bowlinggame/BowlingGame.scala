package bowlinggame

import scala.annotation.tailrec

object BowlingGame {
  def toFrames(rolls: List[Int]): List[List[Int]] = {
    @tailrec
    def loop(remainingRolls: List[Int], frames: List[List[Int]]): List[List[Int]] = {
      if (remainingRolls.isEmpty) {
        frames
      } else if (remainingRolls.head == 10) {
        // Strike: take 3 rolls (the strike plus the next two rolls)
        loop(remainingRolls.tail, frames :+ remainingRolls.take(3))
      } else if (remainingRolls.take(2).sum == 10) {
        // Spare: take 3 rolls (the spare plus the next roll)
        loop(remainingRolls.drop(2), frames :+ remainingRolls.take(3))
      } else {
        // Normal frame: take 2 rolls
        loop(remainingRolls.drop(2), frames :+ remainingRolls.take(2))
      }
    }
    
    loop(rolls, List())
  }
  
  def addFrame(score: Int, frame: List[Int]): Int = {
    score + frame.sum
  }
  
  def score(rolls: List[Int]): Int = {
    toFrames(rolls).take(10).foldLeft(0)(addFrame)
  }
  
  def main(args: Array[String]): Unit = {
    if (args.length > 0) {
      try {
        val rolls = args.map(_.toInt).toList
        val gameScore = score(rolls)
        println(s"Bowling score: $gameScore")
      } catch {
        case e: NumberFormatException =>
          println("Error: All arguments must be valid integers")
      }
    } else {
      println("Please provide roll scores as arguments")
    }
  }
}