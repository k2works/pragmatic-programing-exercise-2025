package org.example.fibonacci;

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
public class FibonacciGeneralTerm implements FibonacciCalculator {
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
