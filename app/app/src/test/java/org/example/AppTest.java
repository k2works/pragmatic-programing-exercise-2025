package org.example;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class AppTest {
    @DisplayName("0を渡したら0を返す")
    @Test void when0_then0() {
        assertEquals(0, Fibonacci.calc(0));
    }

    @DisplayName("1を渡したら1を返す")
    @Test void when1_then1() {
        assertEquals(1, Fibonacci.calc(1));
    }

    @DisplayName("2を渡したら1を返す")
    @Test void when2_then1() {
        assertEquals(1, Fibonacci.calc(2));
    }

    @DisplayName("3を渡したら2を返す")
    @Test void when3_then2() {
        assertEquals(2, Fibonacci.calc(3));
    }

    @DisplayName("4を渡したら3を返す")
    @Test void when4_then3() {
        assertEquals(3, Fibonacci.calc(4));
    }

    @DisplayName("5を渡したら5を返す")
    @Test void when5_then5() {
        assertEquals(5, Fibonacci.calc(5));
    }
}

class Fibonacci {
    public static int calc(int number) {
        if (number == 0) return 0;
        if (number == 1) return 1;

        return calc(number - 1) + calc(number - 2);
    }
}
