# レンタルビデオシステム

レンタルビデオシステムの最小限のClojure実装です。

## 概要

このプロジェクトは、以下の機能を持つシンプルなレンタルビデオシステムの実装を提供します：
- 異なる価格カテゴリの映画の作成と管理
- 顧客の作成と管理
- 顧客への映画のレンタル
- 映画の価格カテゴリとレンタル期間に基づくレンタル料金の計算

## プロジェクト構造

```
rentalVideo/
├── deps.edn        # プロジェクト依存関係
├── src/            # ソースコード
│   └── rentalvideo/
│       └── rentalvideo.clj  # メイン実装
└── spec/           # テスト
    └── rentalvideo/
        ├── rentalvideo_spec.clj  # Specljテスト
        └── rentalvideo_test.clj  # clojure.testテスト
```

## 使用方法

### プロジェクトの実行

プロジェクトを実行するには、Clojure CLIを使用できます：

```bash
# REPLを起動
clj -M

# REPL内で
(require 'rentalvideo.rentalvideo)
```

### テストの実行

specljを使用してテストを実行するには：

```bash
clj -M:spec
```

clojure.testを使用してテストを実行するには：

```bash
clj -M:test
```

## 例

```clojure
(require '[rentalvideo.rentalvideo :refer :all])

;; 映画を作成
(def matrix (create-movie "マトリックス" "SF" :regular))
(def toy-story (create-movie "トイ・ストーリー" "アニメーション" :children))
(def new-movie (create-movie "新作映画" "アクション" :new-release))

;; 顧客を作成
(def customer (create-customer "山田太郎" "taro@example.com"))

;; 映画をレンタル
(def updated-customer (rent-movie customer matrix 3))

;; レンタル料金を計算
(calculate-rental-fee matrix 3)  ;; => 9.0
```

## ライセンス

このプロジェクトは教育目的のみです。
