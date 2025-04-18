package org.example;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.params.provider.Arguments.arguments;

class AppTest {
    
    @DisplayName("Fibonacciの計算テスト")
    @ParameterizedTest(name = "{0}を渡したら{1}を返す")
    @MethodSource("fibonacciTestCases")
    void testFibonacciCalculation(int input, int expected) {
        Fibonacci command = new Fibonacci(FibonacciRecursive::exec);
        assertEquals(expected,command.exec(input));
    }
    
    static Stream<Arguments> fibonacciTestCases() {
        return Stream.of(
            arguments(0, 0),
            arguments(1, 1),
            arguments(2, 1),
            arguments(3, 2),
            arguments(4, 3),
            arguments(5, 5)
        );
    }

    @DisplayName("大きな数字_再起処理による実装")
    @Test void test_Large_Number() {
        Fibonacci command = new Fibonacci(FibonacciLoop::exec);
        assertEquals(102_334_155, command.exec(40));
    }

    @DisplayName("大きな数字_ループ処理による実装")
    @Test void test_Large_Number_By_Loop() {
        Fibonacci command = new Fibonacci(FibonacciLoop::exec);
        assertEquals(102_334_155, command.exec(40));
    }

    @DisplayName("大きな数字_一般項による実装")
    @Test void test_Large_Number_By_General() {
        Fibonacci command = new Fibonacci(FibonacciGeneralTerm::exec);
        assertEquals(102_334_155, command.exec(40));
    }
}

interface FibonacciCalculator {
    int exec(int number);
}

class Fibonacci {
    FibonacciCalculator algorithm;

    public Fibonacci(FibonacciCalculator algorithm) {
        this.algorithm = algorithm;
    }

    public int exec(int number) {
        return algorithm.exec(number);
    }
}

class FibonacciRecursive {
    private static final Map<Integer, Integer> cache = new HashMap<>();

    public static int exec(int number) {
        // 既に計算済みの値であればキャッシュから返す
        if (cache.containsKey(number)) {
            return cache.get(number);
        }

        // ベースケース
        if (number == 0) return 0;
        if (number == 1) return 1;

        // 再帰的に計算し、結果をキャッシュに保存
        int result = exec(number - 1) + exec(number - 2);
        cache.put(number, result);

        return result;
    }
}

class FibonacciLoop {
    public static int exec(int number) {
        int a = 0;
        int b = 1;
        int c = 0;
        for (int i = 0; i < number; i++) {
            int temp = a + b;
            a = b;
            b = temp;
        }
        return a;
    }
}

class FibonacciGeneralTerm {
    public static int exec(int number) {
        double sqrt5 = Math.sqrt(5);
        double phi = (1 + sqrt5) / 2;
        return (int) Math.round(Math.pow(phi, number) / sqrt5);
    }
}