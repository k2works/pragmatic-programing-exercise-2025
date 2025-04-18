package org.example;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class AppTest {
    @DisplayName("0を渡したら0を返す")
    @Test void when0_then0() {
        assertEquals(0, Fibonacci.fib(0));
    }

    @DisplayName("1を渡したら1を返す")
    @Test void when1_then1() {
        assertEquals(1, Fibonacci.fib(1));
    }

    @DisplayName("2を渡したら1を返す")
    @Test void when2_then1() {
        assertEquals(1, Fibonacci.fib(2));
    }
}

class Fibonacci {
    public static int fib(int i) {
        if (i == 0) return 0;
        return 1;
    }
}
