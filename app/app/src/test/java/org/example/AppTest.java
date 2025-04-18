package org.example;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class AppTest {
    @DisplayName("0を渡したら0を返す")
    @Test void when0_then0() {
        assertEquals(0, Fibonacci.fib(0));
    }
}

class Fibonacci {
    public static int fib(int i) {
        return 0;
    }
}
