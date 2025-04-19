package org.example.fibonacci;

public class Fibonacci {
    FibonacciCalculator algorithm;

    public Fibonacci(FibonacciCalculator algorithm) {
        this.algorithm = algorithm;
    }

    public long exec(long number) {
        if (number < 0) {
            throw new IllegalArgumentException("入力値は0以上である必要があります");
        }
        // 92を超える場合は事前にチェック（既知の制限値）
        if (number > 92) {
            throw new FibonacciOverflowException("入力値が大きすぎます：long型の範囲を超えるフィボナッチ数になります（最大92まで）");
        }
        return algorithm.exec(number);
    }
}
