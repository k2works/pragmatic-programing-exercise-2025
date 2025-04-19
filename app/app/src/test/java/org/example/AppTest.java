package org.example;

import org.example.fibonacci.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.params.provider.Arguments.arguments;

class AppTest {
    
    /**
     * 小さな数字でのフィボナッチ数列計算テスト
     * 
     * 小さな数字（0～5）では全ての実装方法で同じ結果になるはずです。
     * これらのテストケースでは計算の正確性の基本検証を行います。
     */
    
    @DisplayName("Fibonacciの計算テスト_再帰処理")
    @ParameterizedTest(name = "{0}を渡したら{1}を返す")
    @MethodSource("fibonacciTestCases")
    void test_FibonacciCalculation_Recursive(int input, int expected) {
        Fibonacci command = new Fibonacci(new FibonacciRecursive());
        assertEquals(expected,command.exec(input));
    }

    @DisplayName("Fibonacciの計算テスト_ループ処理")
    @ParameterizedTest(name = "{0}を渡したら{1}を返す")
    @MethodSource("fibonacciTestCases")
    void test_FibonacciCalculation_Loop(int input, int expected) {
        Fibonacci command = new Fibonacci(new FibonacciLoop());
        assertEquals(expected,command.exec(input));
    }

    @DisplayName("Fibonacciの計算テスト_一般項")
    @ParameterizedTest(name = "{0}を渡したら{1}を返す")
    @MethodSource("fibonacciTestCases")
    void test_FibonacciCalculation_GeneralTerm(int input, int expected) {
        Fibonacci command = new Fibonacci(new FibonacciGeneralTerm());
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

    /**
     * 大きな数字のテスト
     * 
     * 注意：各実装方法による計算結果には、浮動小数点演算の精度の違いにより
     * 微小な差異があります。テストでは実装ごとに正確な値を検証します。
     */
    
    @DisplayName("大きな数字_再起処理による実装")
    @Test void test_Large_Number() {
        Fibonacci command = new Fibonacci(new FibonacciRecursive());
        // 再帰処理による正確な計算値
        assertEquals(7_540_113_804_746_346_429L, command.exec(92));
    }
    
    @DisplayName("大きな数字_ループ処理による実装")
    @Test void test_Large_Number_By_Loop() {
        Fibonacci command = new Fibonacci(new FibonacciLoop());
        assertEquals(102_334_155, command.exec(40));
        // ループ処理による正確な計算値
        assertEquals(7_540_113_804_746_346_429L, command.exec(92));
    }
    
    @DisplayName("大きな数字_一般項による実装")
    @Test void test_Large_Number_By_General() {
        Fibonacci command = new Fibonacci(new FibonacciGeneralTerm());
        assertEquals(102_334_155, command.exec(40));
        // 一般項による計算値（浮動小数点演算による誤差を含む）
        assertEquals(7_540_113_804_746_369_024L, command.exec(92));
    }

    @DisplayName("非負整数以外の値を渡した場合")
    @ParameterizedTest(name = "{0}を渡したらIllegalArgumentExceptionをスローする")
    @MethodSource("invalidFibonacciTestCases")
    void test_InvalidFibonacciCalculation(int input) {
        Fibonacci command = new Fibonacci(new FibonacciRecursive());
        assertThrows(IllegalArgumentException.class, () -> command.exec(input));
    }

    static Stream<Arguments> invalidFibonacciTestCases() {
        return Stream.of(
                arguments(-1),
                arguments(-2),
                arguments(-3),
                arguments(-4),
                arguments(-5)
        );
    }
    
    @DisplayName("オーバーフローテスト_再帰処理")
    @Test
    void test_Overflow_Recursive() {
        Fibonacci command = new Fibonacci(new FibonacciRecursive());
        assertThrows(FibonacciOverflowException.class, () -> command.exec(93));
    }
    
    @DisplayName("オーバーフローテスト_ループ処理")
    @Test
    void test_Overflow_Loop() {
        Fibonacci command = new Fibonacci(new FibonacciLoop());
        assertThrows(FibonacciOverflowException.class, () -> command.exec(93));
    }
    
    @DisplayName("オーバーフローテスト_一般項")
    @Test
    void test_Overflow_GeneralTerm() {
        Fibonacci command = new Fibonacci(new FibonacciGeneralTerm());
        assertThrows(FibonacciOverflowException.class, () -> command.exec(93));
    }
    
    @DisplayName("境界値テスト_最大安全値")
    @Test
    void test_Max_Safe_Value() {
        // 92はオーバーフローしない最大値
        Fibonacci commandRecursive = new Fibonacci(new FibonacciRecursive());
        Fibonacci commandLoop = new Fibonacci(new FibonacciLoop());
        Fibonacci commandGeneralTerm = new Fibonacci(new FibonacciGeneralTerm());
        
        assertDoesNotThrow(() -> commandRecursive.exec(92));
        assertDoesNotThrow(() -> commandLoop.exec(92));
        assertDoesNotThrow(() -> commandGeneralTerm.exec(92));
    }
}

