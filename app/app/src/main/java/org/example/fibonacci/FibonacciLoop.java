package org.example.fibonacci;

public class FibonacciLoop implements FibonacciCalculator {
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
