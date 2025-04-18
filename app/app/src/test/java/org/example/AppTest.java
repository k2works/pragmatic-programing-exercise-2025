package org.example;

import org.junit.jupiter.api.DisplayName;
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
        assertEquals(expected, Fibonacci.calc(input));
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
}

class Fibonacci {
    private static final Map<Integer, Integer> cache = new HashMap<>();
    
    public static int calc(int number) {
        // 既に計算済みの値であればキャッシュから返す
        if (cache.containsKey(number)) {
            return cache.get(number);
        }
        
        // ベースケース
        if (number == 0) return 0;
        if (number == 1) return 1;
        
        // 再帰的に計算し、結果をキャッシュに保存
        int result = calc(number - 1) + calc(number - 2);
        cache.put(number, result);
        
        return result;
    }
}
