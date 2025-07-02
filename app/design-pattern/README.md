# デザインパターン in Clojure

このモジュールは、Clojureでの様々なデザインパターンの実装を提供します。このプロジェクトは、関数型プログラミング言語であるClojureでオブジェクト指向デザインパターンをどのように適用または適応させるかを示しています。

## 概要

このアプリケーションは、以下のデザインパターンの実装を含みます：

- 生成パターン（Factory、Builder、Singleton など）
- 構造パターン（Adapter、Decorator、Proxy など）
- 振る舞いパターン（Observer、Strategy、Command など）

各パターンは、Clojureの関数型アプローチを活用しながら実装されています。

## インストール

[Clojure](https://clojure.org/guides/getting_started)とClojure CLIツールがインストールされていることを確認してください。

このリポジトリをクローンし、プロジェクトディレクトリに移動します：

```bash
git clone <repository-url>
cd design_pattern
```

## 使用方法

コア機能は`design_pattern.core`名前空間によって提供されています。各デザインパターンは独自の名前空間を持っています。

例えば、Strategyパターンを使用するには：

```clojure
(require '[design_pattern.strategy :as strategy])

;; Strategyパターンの使用例
(def context (strategy/create-context strategy/default-strategy))
(strategy/execute context "some-input")

;; 異なる戦略を使用
(strategy/set-strategy context strategy/alternative-strategy)
(strategy/execute context "some-input")
```

## テストの実行

このプロジェクトはテスト用に[speclj](https://github.com/slagyr/speclj)を使用しています。テストを実行するには：

```bash
clojure -M:spec
```

このプロジェクトはClojureの組み込みテストフレームワークもサポートしています：

```bash
clojure -M:test
```

## 実装されているデザインパターン

### 生成パターン

- **Factory Method**: オブジェクト生成のためのインターフェースを定義し、サブクラスにインスタンス化するクラスを選択させる
- **Abstract Factory**: 関連するオブジェクトのファミリーを生成するためのインターフェース
- **Builder**: 複雑なオブジェクトの構築を段階的に行う
- **Singleton**: クラスのインスタンスが1つだけ存在することを保証する

### 構造パターン

- **Adapter**: 互換性のないインターフェースを持つクラスを連携させる
- **Decorator**: オブジェクトに動的に責任を追加する
- **Proxy**: 他のオブジェクトへのアクセスを制御する代理オブジェクト

### 振る舞いパターン

- **Observer**: オブジェクト間の1対多の依存関係を定義し、あるオブジェクトの状態が変化すると、依存するすべてのオブジェクトに通知される
- **Strategy**: アルゴリズムのファミリーを定義し、それらを交換可能にする
- **Command**: リクエストをオブジェクトとしてカプセル化し、異なるリクエストでクライアントをパラメータ化する

## Clojureでのデザインパターン

Clojureは関数型プログラミング言語であるため、伝統的なオブジェクト指向デザインパターンの多くは異なる形で実装されます。このプロジェクトでは、各パターンがClojureの関数型アプローチでどのように実装されるかを示しています。

例えば：

- **Strategy**: 単純な関数として実装できる
- **Decorator**: 高階関数を使用して実装できる
- **Observer**: アトムやウォッチャーを使用して実装できる

## ライセンス

このプロジェクトは[MITライセンス](LICENSE)の下で利用可能です。