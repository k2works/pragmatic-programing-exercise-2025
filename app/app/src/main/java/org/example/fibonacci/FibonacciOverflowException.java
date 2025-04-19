package org.example.fibonacci;

/**
 * フィボナッチ計算のオーバーフロー例外
 */
public class FibonacciOverflowException extends ArithmeticException {
    public FibonacciOverflowException(String message) {
        super(message);
    }
}
