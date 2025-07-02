# デザインパターン in Clojure

このモジュールは、Clojureでの様々なデザインパターンの実装を提供します。このプロジェクトは、関数型プログラミング言語であるClojureでオブジェクト指向デザインパターンをどのように適用または適応させるかを示しています。

## 概要

このプロジェクトでは、以下のデザインパターンの実装を提供しています：

### Abstract Serverパターン

Abstract Serverパターンは、アルゴリズムのファミリーを定義し、それぞれをカプセル化して交換可能にするパターンです。Clojureでは、マルチメソッドを使用してこのパターンを実装しています。

現在の実装では、スイッチ可能なオブジェクト（例：ライト）に対して、オン/オフの操作を行うストラテジーを提供しています。

```clojure
;; プロトコルの定義
(defprotocol SwitchStrategy
  (turn-on [this switchable] "Turn on the switchable object")
  (turn-off [this switchable] "Turn off the switchable object"))

;; レコード形式の実装
(defrecord LightStrategy []
  SwitchStrategy
  (turn-on [_ switchable]
    (turn-on-light))
  (turn-off [_ switchable]
    (turn-off-light)))

;; 戦略を作成する関数
(defn create-strategy [switchable]
  (case (:type switchable)
    :light (->LightStrategy)
    nil))

;; スイッチを操作する関数
(defn engage-switch [switchable]
  (let [strategy (create-strategy switchable)]
    (if strategy
      (do
        (turn-on strategy switchable)
        (turn-off strategy switchable))
      (do
        ;; 後方互換性のためのマルチメソッド
        (legacy-turn-on switchable)
        (legacy-turn-off switchable)))))
```

この実装では、プロトコルとレコード形式を使用して、より明示的なインターフェースと実装を提供しています。`SwitchStrategy`プロトコルは、スイッチ可能なオブジェクトに対する操作を定義し、`LightStrategy`レコードはそのプロトコルを実装しています。

また、後方互換性のために、マルチメソッドベースの実装も維持しています。新しい実装では、`create-strategy`関数を使用して適切な戦略を作成し、それを使用してスイッチを操作します。

この実装により、新しいタイプのスイッチ可能なオブジェクトを追加する際に、新しいレコード型を定義し、プロトコルを実装するだけで拡張できます。

#### クラス図

以下は、Abstract Serverパターンの実装を表すクラス図です：

```plantuml
@startuml
skinparam classAttributeIconSize 0

interface "SwitchStrategy" as strategy {
  +turn-on(this, switchable)
  +turn-off(this, switchable)
}

class "LightStrategy" as light {
  +turn-on(this, switchable)
  +turn-off(this, switchable)
}

class "StrategyFactory" as factory {
  +create-strategy(switchable)
}

class "Client" as client {
  +engage-switch(switchable)
}

strategy <|.. light
factory ..> light : creates
client --> strategy
client --> factory : uses

note right of strategy
  Clojureでは、プロトコルを使用して
  インターフェースを定義します。
  turn-onとturn-offメソッドは
  各実装によって提供されます。
end note

note right of light
  LightStrategyレコードは
  SwitchStrategyプロトコルを実装し、
  turn-on-lightとturn-off-light関数を
  呼び出します。
end note

note right of factory
  create-strategy関数は
  switchableの:typeに基づいて
  適切な戦略を作成します。
end note

note right of client
  engage-switch関数は
  create-strategyを使用して戦略を取得し、
  そのプロトコルメソッドを呼び出します。
  戦略が見つからない場合は、
  レガシーのマルチメソッドを使用します。
end note
@enduml
```

#### シーケンス図

以下は、Abstract Serverパターンの実行フローを表すシーケンス図です：

```plantuml
@startuml
actor User
participant "Client\n(engage-switch)" as client
participant "StrategyFactory\n(create-strategy)" as factory
participant "LightStrategy\n(record)" as strategy
participant "LightFunctions\n(turn-on-light/turn-off-light)" as light

User -> client : engage-switch({:type :light})
activate client

client -> factory : create-strategy({:type :light})
activate factory
factory --> client : LightStrategy
deactivate factory

note right
  create-strategy関数は:typeキーに基づいて
  適切な戦略を作成します
end note

client -> strategy : turn-on(strategy, {:type :light})
activate strategy
strategy -> light : turn-on-light()
activate light
light --> strategy : 結果
deactivate light
strategy --> client : 結果
deactivate strategy

client -> strategy : turn-off(strategy, {:type :light})
activate strategy
strategy -> light : turn-off-light()
activate light
light --> strategy : 結果
deactivate light
strategy --> client : 結果
deactivate strategy

client --> User : 結果
deactivate client

note right
  プロトコルベースの実装では、
  戦略オブジェクトのメソッドを
  直接呼び出します
end note
@enduml
```

## インストール

[Clojure](https://clojure.org/guides/getting_started)とClojure CLIツールがインストールされていることを確認してください。

このリポジトリをクローンし、プロジェクトディレクトリに移動します：

```bash
git clone <repository-url>
cd design-pattern
```

## 使用方法

コア機能は`design-pattern.core`名前空間によって提供されています。各デザインパターンは独自の名前空間を持っています。

例えば、Abstract Serverパターンを使用するには：

```clojure
(require '[design-pattern.abstract-server :refer :all])

;; ライトを操作する
(engage-switch {:type :light})
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

## ライセンス

このプロジェクトは[MITライセンス](LICENSE)の下で利用可能です。
