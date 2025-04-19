package org.example.fibonacci;

interface FibonacciCalculator {
    long exec(long number);

    /**
     * 加算処理でオーバーフローを検出する
     *
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
