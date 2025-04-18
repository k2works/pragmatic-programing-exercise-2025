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

    @DisplayName("3を渡したら2を返す")
    @Test void when3_then2() {
        assertEquals(2, Fibonacci.fib(3));
    }

    @DisplayName("4を渡したら3を返す")
    @Test void when4_then3() {
        assertEquals(3, Fibonacci.fib(4));
    }

    @DisplayName("5を渡したら5を返す")
    @Test void when5_then5() {
        assertEquals(5, Fibonacci.fib(5));
    }
}

class Fibonacci {
    public static int fib(int number) {
        if (number == 0) return 0;
        if (number == 1) return 1;

        return fib(number - 1) + fib(number - 2);
    }
}
