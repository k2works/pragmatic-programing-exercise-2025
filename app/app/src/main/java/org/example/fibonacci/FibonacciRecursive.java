package org.example.fibonacci;

import java.util.HashMap;
import java.util.Map;

public class FibonacciRecursive implements FibonacciCalculator {
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
