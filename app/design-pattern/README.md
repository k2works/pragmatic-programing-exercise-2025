# デザインパターン in Clojure

このモジュールは、Clojureでの様々なデザインパターンの実装を提供します。このプロジェクトは、関数型プログラミング言語であるClojureでオブジェクト指向デザインパターンをどのように適用または適応させるかを示しています。

## 概要

このプロジェクトでは、以下のデザインパターンの実装を提供しています：

### Adapterパターン

Adapterパターンは、既存のクラスのインターフェースを、クライアントが期待する別のインターフェースに変換するパターンです。このパターンを使用すると、互換性のないインターフェースを持つクラス同士を連携させることができます。

現在の実装では、可変強度を持つライト（VariableLight）を、単純なオン/オフ機能を持つSwitchableインターフェースに適応させています。

```clojure
;; Switchableインターフェース（ターゲット）
(defmulti turn-on :type)
(defmulti turn-off :type)

;; VariableLight（アダプティー）
(defn turn-on-light [intensity]
  ;Turn it on with intensity.
  )

;; VariableLightAdapter（アダプター）
(defn make-adapter [min-intensity max-intensity]
  {:type :variable-light
   :min-intensity min-intensity
   :max-intensity max-intensity})

(defmethod turn-on :variable-light [variable-light]
  (turn-on-light (:max-intensity variable-light)))

(defmethod turn-off :variable-light [variable-light]
  (turn-on-light (:min-intensity variable-light)))

;; クライアント
(defn engage-switch [switchable]
  (turn-on switchable)
  (turn-off switchable))
```

この実装では、マルチメソッドを使用してアダプターパターンを実現しています。`variable-light-adapter`は、可変強度を持つライトを単純なオン/オフインターフェースに適応させるアダプターです。

アダプターは、`turn-on`を最大強度でのライト点灯に、`turn-off`を最小強度でのライト点灯にマッピングします。これにより、可変強度ライトを通常のスイッチと同じように扱うことができます。

#### クラス図

以下は、Adapterパターンの実装を表すクラス図です：

```plantuml
@startuml
skinparam classAttributeIconSize 0

interface "Switchable" as switchable {
  +turn-on(switchable)
  +turn-off(switchable)
}

class "VariableLight" as variableLight {
  +turn-on-light(intensity)
}

class "VariableLightAdapter" as adapter {
  +type: :variable-light
  +min-intensity
  +max-intensity
  +turn-on(variable-light)
  +turn-off(variable-light)
}

class "Client" as client {
  +engage-switch(switchable)
}

adapter ..|> switchable
adapter --> variableLight : adapts
client --> switchable : uses

note right of switchable
  Switchableはマルチメソッドで
  定義されたインターフェースで、
  turn-onとturn-offメソッドを
  提供します。
end note

note right of variableLight
  VariableLightは強度を指定して
  ライトを点灯させる機能を
  提供します。
end note

note right of adapter
  VariableLightAdapterは
  Switchableインターフェースを実装し、
  turn-onとturn-offの呼び出しを
  適切な強度でのturn-on-light呼び出しに
  変換します。
end note

note right of client
  Clientはengage-switch関数を通じて
  Switchableインターフェースを使用し、
  実際の実装の詳細を知る必要はありません。
end note
@enduml
```

#### シーケンス図

以下は、Adapterパターンの実行フローを表すシーケンス図です：

```plantuml
@startuml
actor User
participant "Client\n(engage-switch)" as client
participant "VariableLightAdapter" as adapter
participant "VariableLight\n(turn-on-light)" as variableLight

User -> client : engage-switch(adapter)
activate client

client -> adapter : turn-on(adapter)
activate adapter
adapter -> variableLight : turn-on-light(max-intensity)
activate variableLight
variableLight --> adapter : 結果
deactivate variableLight
adapter --> client : 結果
deactivate adapter

client -> adapter : turn-off(adapter)
activate adapter
adapter -> variableLight : turn-on-light(min-intensity)
activate variableLight
variableLight --> adapter : 結果
deactivate variableLight
adapter --> client : 結果
deactivate adapter

client --> User : 結果
deactivate client

note right
  アダプターは、Switchableインターフェースの
  メソッド呼び出しをVariableLightの
  適切なメソッド呼び出しに変換します
end note
@enduml
```

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
