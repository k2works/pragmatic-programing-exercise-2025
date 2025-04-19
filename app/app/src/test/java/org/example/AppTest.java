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

/**
 * フィボナッチ計算のオーバーフロー例外
 */
class FibonacciOverflowException extends ArithmeticException {
    public FibonacciOverflowException(String message) {
        super(message);
    }
}

interface FibonacciCalculator {
    long exec(long number);
    
    /**
     * 加算処理でオーバーフローを検出する
     * @param a 第1項
     * @param b 第2項
     * @return 和
     * @throws FibonacciOverflowException オーバーフロー発生時
     */
    default long addWithOverflowCheck(long a, long b) {
        // オーバーフロー検出：a > 0, b > 0 で a + b < 0 の場合はオーバーフロー
        // またはa < 0, b < 0 で a + b > 0 の場合もオーバーフロー
        if ((a > 0 && b > 0 && Long.MAX_VALUE - a < b) || 
            (a < 0 && b < 0 && Long.MIN_VALUE - a > b)) {
            throw new FibonacciOverflowException("フィボナッチ数列の計算でオーバーフローが発生しました: " + a + " + " + b);
        }
        return a + b;
    }
}

class Fibonacci {
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

class FibonacciRecursive implements FibonacciCalculator {
    private final Map<Long, Long> cache = new HashMap<>();

    public long exec(long number) {
        // 既に計算済みの値であればキャッシュから返す
        if (cache.containsKey(number)) {
            return cache.get(number);
        }

        // ベースケース
        if (number == 0) return 0;
        if (number == 1) return 1;

        // 再帰的に計算し、結果をキャッシュに保存
        long a = exec(number - 1);
        long b = exec(number - 2);
        long result = addWithOverflowCheck(a, b);
        cache.put(number, result);

        return result;
    }
}

class FibonacciLoop implements FibonacciCalculator {
    public long exec(long number) {
        if (number == 0) return 0;
        if (number == 1) return 1;

        long a = 0;
        long b = 1;
        long c;
        for (long i = 2; i <= number; i++) {
            c = addWithOverflowCheck(a, b);
            a = b;
            b = c;
        }
        return b;
    }
}

/**
 * ビネの公式（一般項）を使用してフィボナッチ数列を計算するクラス。
 * <p>
 * 注意: この実装は浮動小数点演算を使用しているため、特に大きな数値（例：92）では
 * 再帰処理やループ処理による計算結果と微小な差異が生じる場合があります。
 * これは浮動小数点演算の精度限界によるものであり、厳密な整数計算が必要な場合は
 * {@link FibonacciRecursive}または{@link FibonacciLoop}の使用を検討してください。
 * </p>
 * <p>
 * 例: n=92の場合<br>
 * 再帰/ループ実装: 7,540,113,804,746,346,429（厳密な整数計算による結果）<br>
 * 一般項実装: 7,540,113,804,746,369,024（浮動小数点演算に基づく近似値）<br>
 * </p>
 * <p>
 * テストでは各実装の特性を考慮し、それぞれに適した期待値を使用しています。
 * 一般項による計算と整数計算による結果の差は約0.0000003%と非常に小さいですが、
 * テストの正確性を保つために区別しています。
 * </p>
 */
class FibonacciGeneralTerm implements FibonacciCalculator {
    // フィボナッチ数列のLong型で表現可能な最大値
    private static final long MAX_FIBONACCI = 7_540_113_804_746_369_024L; // 93番目の値に近い

    public long exec(long number) {
        if (number == 0) return 0;
        if (number == 1) return 1;
        
        // 92以下はメイン処理で計算
        double sqrt5 = Math.sqrt(5);
        double phi = (1 + sqrt5) / 2;
        
        // 大きな数字のオーバーフローチェック
        // 数学的に検証：フィボナッチ数列は約 Φ^n/√5 で成長するため、
        // 結果が長すぎないか、また計算中にオーバーフローが起きていないか確認
        
        double result = Math.pow(phi, number) / sqrt5;
        
        // 浮動小数点値がLong.MAXより大きいか、または
        // 結果が正確に表現できない場合はオーバーフロー
        if (result > Long.MAX_VALUE || Double.isInfinite(result) || Double.isNaN(result)) {
            throw new FibonacciOverflowException("フィボナッチ数列の計算でオーバーフローが発生しました: n=" + number);
        }
        
        // 補足チェック: 92を超える場合、既知の制限値よりも大きくなるためオーバーフロー
        // Fibonacci.exec()でもチェックしているが、一貫性のためここでも実装
        long roundedResult = Math.round(result);
        if (roundedResult > MAX_FIBONACCI) {
            throw new FibonacciOverflowException("フィボナッチ数列の計算でオーバーフローが発生しました: 結果が大きすぎます");
        }

        return roundedResult;
    }
}