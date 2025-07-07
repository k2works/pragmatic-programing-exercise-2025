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

### Compositeパターン

Compositeパターンは、オブジェクトをツリー構造で構成し、個々のオブジェクトとオブジェクトの集合を同じように扱うことができるようにするパターンです。このパターンを使用すると、クライアントは個々のオブジェクトとその組み合わせを区別せずに操作できます。

現在の実装では、異なる形状（円や四角形）とそれらの組み合わせ（複合形状）を同じインターフェースで操作できるようにしています。

```clojure
;; 形状インターフェース
(defmulti translate (fn [shape dx dy] (::type shape)))
(defmulti scale (fn [shape factor] (::type shape)))

;; 円の実装
(defn make-circle [center radius]
  {::shape/type ::circle
   ::center center
   ::radius radius})

(defmethod shape/translate ::circle [circle dx dy]
  (let [[x y] (::center circle)]
    (assoc circle ::center [(+ x dx) (+ y dy)])))

(defmethod shape/scale ::circle [circle factor]
  (let [radius (::radius circle)]
    (assoc circle ::radius (* radius factor))))

;; 四角形の実装
(defn make-square [top-left side]
  {::shape/type ::square
   ::top-left top-left
   ::side side})

(defmethod shape/translate ::square [square dx dy]
  (let [[x y] (::top-left square)]
    (assoc square ::top-left [(+ x dx) (+ y dy)])))

(defmethod shape/scale ::square [square factor]
  (let [side (::side square)]
    (assoc square ::side (* side factor))))

;; 複合形状の実装
(defn make []
  {::shape/type ::composite-shape
   ::shapes []})

(defn add [cs shape]
  (update cs ::shapes conj shape))

(defmethod shape/translate ::composite-shape [cs dx dy]
  (let [translated-shapes (map #(shape/translate % dx dy)
                             (::shapes cs))]
      (assoc cs ::shapes translated-shapes)))

(defmethod shape/scale ::composite-shape [cs factor]
  (let [scaled-shapes (map #(shape/scale % factor)
                         (::shapes cs))]
    (assoc cs ::shapes scaled-shapes)))
```

この実装では、マルチメソッドを使用してCompositeパターンを実現しています。`translate`と`scale`という共通のインターフェースを定義し、各形状（円、四角形）とその複合形状に対して実装しています。

複合形状は他の形状を含むことができ、操作（移動やサイズ変更）が複合形状に適用されると、その操作は含まれるすべての形状に再帰的に適用されます。これにより、クライアントは個々の形状と複合形状を区別せずに同じ方法で操作できます。

#### クラス図

以下は、Compositeパターンの実装を表すクラス図です：

```plantuml
@startuml
skinparam classAttributeIconSize 0

interface "Shape" as shape {
  +translate(shape, dx, dy)
  +scale(shape, factor)
}

class "Circle" as circle {
  +center
  +radius
  +translate(circle, dx, dy)
  +scale(circle, factor)
}

class "Square" as square {
  +top-left
  +side
  +translate(square, dx, dy)
  +scale(square, factor)
}

class "CompositeShape" as composite {
  +shapes: Collection<Shape>
  +add(shape)
  +translate(composite, dx, dy)
  +scale(composite, factor)
}

circle ..|> shape
square ..|> shape
composite ..|> shape
composite o--> shape : contains

note right of shape
  Shapeはマルチメソッドで
  定義されたインターフェースで、
  translateとscaleメソッドを
  提供します。
end note

note right of circle
  Circleは中心点と半径を持ち、
  Shapeインターフェースを実装します。
end note

note right of square
  Squareは左上の座標と辺の長さを持ち、
  Shapeインターフェースを実装します。
end note

note right of composite
  CompositeShapeは複数のShapeを含み、
  操作を含まれるすべてのShapeに
  委譲します。
end note
@enduml
```

#### シーケンス図

以下は、Compositeパターンの実行フローを表すシーケンス図です：

```plantuml
@startuml
actor Client
participant "CompositeShape" as composite
participant "Circle" as circle
participant "Square" as square

Client -> composite : make()
activate composite
composite --> Client : empty composite
deactivate composite

Client -> circle : make-circle([5, 5], 10)
activate circle
circle --> Client : circle
deactivate circle

Client -> square : make-square([0, 0], 5)
activate square
square --> Client : square
deactivate square

Client -> composite : add(composite, circle)
activate composite
composite --> Client : updated composite
deactivate composite

Client -> composite : add(composite, square)
activate composite
composite --> Client : updated composite
deactivate composite

Client -> composite : translate(composite, 3, 4)
activate composite
composite -> circle : translate(circle, 3, 4)
activate circle
circle --> composite : translated circle
deactivate circle
composite -> square : translate(square, 3, 4)
activate square
square --> composite : translated square
deactivate square
composite --> Client : translated composite
deactivate composite

Client -> composite : scale(composite, 2)
activate composite
composite -> circle : scale(circle, 2)
activate circle
circle --> composite : scaled circle
deactivate circle
composite -> square : scale(square, 2)
activate square
square --> composite : scaled square
deactivate square
composite --> Client : scaled composite
deactivate composite

note right
  複合形状に対する操作は、
  含まれるすべての形状に
  委譲されます
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
