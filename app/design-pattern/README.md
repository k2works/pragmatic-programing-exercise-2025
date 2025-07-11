# デザインパターン in Clojure

このモジュールは、Clojureでの様々なデザインパターンの実装を提供します。このプロジェクトは、関数型プログラミング言語であるClojureでオブジェクト指向デザインパターンをどのように適用または適応させるかを示しています。

## 概要

このプロジェクトでは、以下のデザインパターンの実装を提供しています：

- Adapterパターン - 互換性のないインターフェースを持つクラス同士を連携させる
- Abstract Factoryパターン - 関連するオブジェクトのファミリーを、具体的なクラスを指定せずに生成するためのインターフェースを提供する
- Compositeパターン - オブジェクトをツリー構造で構成し、個々のオブジェクトとその集合を同じように扱う
- Decoratorパターン - 既存のオブジェクトに新しい機能を動的に追加する
- Abstract Serverパターン - アルゴリズムのファミリーを定義し、それぞれをカプセル化して交換可能にする
- Commandパターン - 要求をオブジェクトとしてカプセル化し、実行や取り消しなどの操作を可能にする
- Visitorパターン - オブジェクト構造の要素に対して実行する操作を表現し、操作を変更せずに新しい操作を定義できるようにする

以下、各パターンの詳細な説明と実装例を示します。

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

### Abstract Factoryパターン

Abstract Factoryパターンは、関連するオブジェクトのファミリーを、具体的なクラスを指定せずに生成するためのインターフェースを提供するパターンです。このパターンを使用すると、クライアントは生成されるオブジェクトの具体的なクラスを知ることなく、関連するオブジェクトを生成できます。

現在の実装では、異なる形状（円や四角形）を生成するファクトリーを提供しています。

```clojure
;; 形状ファクトリーインターフェース
(defmulti make (fn [factory type & args] (::type factory)))

;; 形状インターフェース
(defmulti translate (fn [shape dx dy] (::type shape)))
(defmulti scale (fn [shape factor] (::type shape)))
(defmulti to-string (fn [shape] (::type shape)))

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

(defmethod shape/to-string ::circle [circle]
  (let [[x y] (::center circle)
        radius (::radius circle)]
    (str "Circle center: [" x ", " y "] radius: " radius)))

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

(defmethod shape/to-string ::square [square]
  (let [[x y] (::top-left square)
        side (::side square)]
    (str "Square top-left: [" x ", " y "] side: " side)))

;; 形状ファクトリーの実装
(defn make-factory []
  {::factory/type ::implementation})

(defmethod factory/make ::implementation
  [factory type & args]
  (condp = type
    :square (apply square/make args)
    :circle (apply circle/make args)))

;; クライアント
(def shape-factory (atom nil))

(defn init []
  (reset! shape-factory (make-factory)))

;; 使用例
(let [square (factory/make @shape-factory :square [100 100] 10)
      circle (factory/make @shape-factory :circle [100 100] 10)]
  (println (shape/to-string square))
  (println (shape/to-string circle)))
```

この実装では、マルチメソッドを使用してAbstract Factoryパターンを実現しています。`make`という共通のファクトリーインターフェースを定義し、具体的なファクトリー実装がこのインターフェースを実装しています。

ファクトリーは、要求された型（:squareや:circle）に基づいて適切な形状オブジェクトを生成します。クライアントは、具体的な形状クラスを知ることなく、ファクトリーを通じて形状オブジェクトを生成できます。

#### クラス図

以下は、Abstract Factoryパターンの実装を表すクラス図です：

```plantuml
@startuml
skinparam classAttributeIconSize 0

interface "ShapeFactory" as factory {
  +make(factory, type, args)
}

class "ShapeFactoryImplementation" as factoryImpl {
  +make(factory, type, args)
}

interface "Shape" as shape {
  +translate(shape, dx, dy)
  +scale(shape, factor)
  +to-string(shape)
}

class "Circle" as circle {
  +center
  +radius
  +translate(circle, dx, dy)
  +scale(circle, factor)
  +to-string(circle)
}

class "Square" as square {
  +top-left
  +side
  +translate(square, dx, dy)
  +scale(square, factor)
  +to-string(square)
}

class "Client" as client {
  +shape-factory
  +init()
}

factoryImpl ..|> factory
circle ..|> shape
square ..|> shape
factory ..> shape : creates
client --> factory : uses

note right of factory
  ShapeFactoryは形状オブジェクトを
  生成するためのインターフェースを
  提供します。
end note

note right of factoryImpl
  ShapeFactoryImplementationは
  具体的な形状オブジェクトを
  生成する実装を提供します。
end note

note right of shape
  Shapeは全ての形状が
  実装すべきインターフェースを
  定義します。
end note

note right of client
  Clientはファクトリーを使用して
  形状オブジェクトを生成し、
  具体的な形状クラスを
  知る必要はありません。
end note
@enduml
```

#### シーケンス図

以下は、Abstract Factoryパターンの実行フローを表すシーケンス図です：

```plantuml
@startuml
actor User
participant "Client" as client
participant "ShapeFactory" as factory
participant "Circle" as circle
participant "Square" as square

User -> client : init()
activate client
client -> factory : make()
activate factory
factory --> client : factory instance
deactivate factory
client --> User : 初期化完了
deactivate client

User -> client : create shapes
activate client
client -> factory : make(factory, :circle, [100 100], 10)
activate factory
factory -> circle : make([100 100], 10)
activate circle
circle --> factory : circle instance
deactivate circle
factory --> client : circle instance
deactivate factory

client -> factory : make(factory, :square, [100 100], 10)
activate factory
factory -> square : make([100 100], 10)
activate square
square --> factory : square instance
deactivate square
factory --> client : square instance
deactivate factory

client --> User : created shapes
deactivate client

note right
  クライアントはファクトリーを通じて
  形状オブジェクトを生成し、
  具体的な形状クラスを知る必要はありません
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

### Decoratorパターン

Decoratorパターンは、既存のオブジェクトに新しい機能を動的に追加するパターンです。このパターンを使用すると、サブクラス化による継承よりも柔軟な方法で機能を拡張できます。

現在の実装では、形状（Shape）オブジェクトに操作の履歴を記録する機能を追加するJournaledShapeデコレータを提供しています。

```clojure
;; デコレータの実装
(defn make [shape]
  {::shape/type ::journal-shape
   ::journal []
   ::shape shape})

(defmethod shape/translate ::journal-shape [js dx dy]
  (-> js (update ::journal conj [:translate dx dy])
      (assoc ::shape (shape/translate (::shape js) dx dy))))

(defmethod shape/scale ::journal-shape [js factor]
  (-> js (update ::journal conj [:scale factor])
      (assoc ::shape (shape/scale (::shape js) factor))))

;; デコレータの使用例
(let [journaled-square (-> (js/make (square/make-square [0 0] 1))
                           (shape/translate 2 3)
                           (shape/scale 5))]
  ;; ジャーナルには操作の履歴が記録されています
  ;; [[:translate 2 3] [:scale 5]]
  (::js/journal journaled-square))
```

この実装では、マルチメソッドを使用してDecoratorパターンを実現しています。`make`関数は既存の形状をラップし、新しいジャーナル機能を持つデコレータオブジェクトを作成します。

デコレータは元の形状と同じインターフェース（`translate`と`scale`）を実装していますが、操作を元の形状に委譲する前に、その操作をジャーナルに記録します。これにより、クライアントは通常の形状とデコレートされた形状を区別せずに同じ方法で操作できます。

#### クラス図

以下は、Decoratorパターンの実装を表すクラス図です：

```plantuml
@startuml
skinparam classAttributeIconSize 0

interface "Shape" as shape {
  +translate(shape, dx, dy)
  +scale(shape, factor)
}

class "ConcreteShape\n(Circle, Square, etc.)" as concrete {
  +translate(shape, dx, dy)
  +scale(shape, factor)
}

class "JournaledShape" as decorator {
  +shape: Shape
  +journal: Collection<Operation>
  +translate(shape, dx, dy)
  +scale(shape, factor)
}

shape <|.. concrete
shape <|.. decorator
decorator o--> shape : decorates

note right of shape
  Shapeはマルチメソッドで
  定義されたインターフェースで、
  translateとscaleメソッドを
  提供します。
end note

note right of concrete
  ConcreteShapeは
  Shapeインターフェースの
  具体的な実装です。
end note

note right of decorator
  JournaledShapeはShapeを
  デコレートし、操作を委譲する前に
  ジャーナルに記録します。
end note
@enduml
```

#### シーケンス図

以下は、Decoratorパターンの実行フローを表すシーケンス図です：

```plantuml
@startuml
actor Client
participant "JournaledShape\n(Decorator)" as decorator
participant "ConcreteShape\n(Square)" as concrete

Client -> concrete : make-square([0, 0], 1)
activate concrete
concrete --> Client : square
deactivate concrete

Client -> decorator : make(square)
activate decorator
decorator --> Client : journaled-square
deactivate decorator

Client -> decorator : translate(journaled-square, 2, 3)
activate decorator
decorator -> decorator : journal.add([:translate, 2, 3])
decorator -> concrete : translate(square, 2, 3)
activate concrete
concrete --> decorator : translated-square
deactivate concrete
decorator --> Client : updated-journaled-square
deactivate decorator

Client -> decorator : scale(journaled-square, 5)
activate decorator
decorator -> decorator : journal.add([:scale, 5])
decorator -> concrete : scale(square, 5)
activate concrete
concrete --> decorator : scaled-square
deactivate concrete
decorator --> Client : updated-journaled-square
deactivate decorator

note right
  デコレータは操作を委譲する前に
  ジャーナルに記録します
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

### Commandパターン

Commandパターンは、要求をオブジェクトとしてカプセル化し、それによって異なる要求やキューイング、ログ記録、取り消し可能な操作などのパラメータ化されたクライアントを可能にするパターンです。このパターンを使用すると、操作の実行を要求するオブジェクトと、その操作を実際に実行するオブジェクトを分離できます。

現在の実装では、GUIアプリケーションでの操作（部屋の追加など）とそのundo機能を実装しています。

```clojure
;; Commandインターフェース
(defmulti execute :type)
(defmulti undo :type)

;; 具体的なコマンド（AddRoomCommand）
(defn add-room []
  ;stuff that adds rooms to the canvas
  ;and returns added room
  )

(defn delete-room [room]
  ;stuff that deletes the specified room from the canvas
  )

(defn make-add-room-command []
  {:type :add-room-command})

(defmethod execute :add-room-command [command]
  (assoc (make-add-room-command) :the-added-room (add-room)))

(defmethod undo :add-room-command [command]
  (delete-room (:the-added-room command)))

;; クライアント
(defn some-app [command]
  ;Some other stuff...
  (command)
  ;Some more other stuff...
  )

;; GUIアプリケーション（Invoker）
(defn gui-app [actions]
  (loop [actions actions
         undo-list (list)]
    (if (empty? actions)
      :done-nl
      (condp = (first actions)
        :add-room-action
        (let [executed-command (execute
                                 (make-add-room-command))]
          (recur (rest actions)
                 (conj undo-list executed-command)))
        :undo-action
        (let [command-to-undo (first undo-list)]
          (undo command-to-undo)
          (recur (rest actions)
                 (rest undo-list)))
        :TILT))))
```

この実装では、マルチメソッドを使用してCommandパターンを実現しています。`execute`と`undo`マルチメソッドは、コマンドインターフェースを定義し、`:add-room-command`型のコマンドに対する具体的な実装を提供しています。

`gui-app`関数は、アクションのリストを受け取り、それらを順番に処理します。`:add-room-action`アクションが来ると、新しいコマンドを作成して実行し、undo-listに追加します。`:undo-action`アクションが来ると、undo-listから最新のコマンドを取り出し、それを元に戻します。

このパターンにより、GUIアプリケーションは実行される具体的な操作を知る必要がなく、単にコマンドを実行・元に戻すだけで済みます。また、新しい操作を追加する際には、新しいコマンド型を定義し、`execute`と`undo`マルチメソッドに対する実装を提供するだけで済みます。

#### クラス図

以下は、Commandパターンの実装を表すクラス図です：

```plantuml
@startuml
skinparam classAttributeIconSize 0

interface "Command" as command {
  +execute(command)
  +undo(command)
}

class "AddRoomCommand" as addRoom {
  +type: :add-room-command
  +the-added-room
  +execute(command)
  +undo(command)
}

class "Client\n(some-app)" as client {
  +some-app(command)
}

class "Invoker\n(gui-app)" as invoker {
  +gui-app(actions)
  +undo-list
}

class "Receiver\n(add-room/delete-room)" as receiver {
  +add-room()
  +delete-room(room)
}

command <|.. addRoom
invoker --> command : uses
addRoom --> receiver : uses
client --> command : uses

note right of command
  Commandはマルチメソッドで
  定義されたインターフェースで、
  executeとundoメソッドを
  提供します。
end note

note right of addRoom
  AddRoomCommandは
  Commandインターフェースを実装し、
  add-roomとdelete-room関数を
  呼び出します。
end note

note right of invoker
  gui-app関数はアクションリストを
  処理し、適切なコマンドを
  実行・元に戻します。
  また、undo-listを管理します。
end note

note right of receiver
  add-roomとdelete-room関数は
  実際の操作を実行します。
end note

note right of client
  some-app関数はコマンドを
  受け取り、それを実行します。
end note
@enduml
```

#### シーケンス図

以下は、Commandパターンの実行フローを表すシーケンス図です：

```plantuml
@startuml
actor User
participant "Invoker\n(gui-app)" as invoker
participant "Command\n(AddRoomCommand)" as command
participant "Receiver\n(add-room/delete-room)" as receiver

User -> invoker : gui-app([:add-room-action, :undo-action])
activate invoker

invoker -> command : make-add-room-command()
activate command
command --> invoker : command
deactivate command

invoker -> command : execute(command)
activate command
command -> receiver : add-room()
activate receiver
receiver --> command : room
deactivate receiver
command --> invoker : executed-command
deactivate command

invoker -> command : undo(command)
activate command
command -> receiver : delete-room(room)
activate receiver
receiver --> command : result
deactivate receiver
command --> invoker : result
deactivate command

invoker --> User : result
deactivate invoker

note right
  Invokerはアクションに基づいて
  コマンドを作成・実行し、
  必要に応じて元に戻します。
  Commandは実際の操作を
  Receiverに委譲します。
end note
@enduml
```

### Visitorパターン

Visitorパターンは、オブジェクト構造の要素に対して実行する操作を表現し、操作を変更せずに新しい操作を定義できるようにするパターンです。このパターンを使用すると、操作の対象となるオブジェクト構造を変更せずに、新しい操作を追加できます。

現在の実装では、異なる形状（円や四角形）をJSON形式に変換する操作を提供しています。

```clojure
;; 形状インターフェース
(defmulti translate (fn [shape dx dy] (::type shape)))
(defmulti scale (fn [shape factor] (::type shape)))

;; 円の実装
(defn make [center radius]
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
(defn make [top-left side]
  {::shape/type ::square
   ::top-left top-left
   ::side side})

(defmethod shape/translate ::square [square dx dy]
  (let [[x y] (::top-left square)]
    (assoc square ::top-left [(+ x dx) (+ y dy)])))

(defmethod shape/scale ::square [square factor]
  (let [side (::side square)]
    (assoc square ::side (* side factor))))

;; Visitorインターフェース
(defmulti to-json ::shape/type)

;; 具体的なVisitor実装
(defmethod to-json ::square/square [square]
  (let [{:keys [::square/top-left ::square/side]} square
        [x y] top-left]
    (format "{\"top-left\":[%s,%s],\"side\": %s}" x y side)))

(defmethod to-json ::circle/circle [circle]
  (let [{:keys [::circle/center ::circle/radius]} circle
        [x y] center]
    (format "{\"center\":[%s,%s],\"radius\": %s}" x y radius)))

;; Visitorの使用例
(to-json (square/make [0 0] 1)) ;; => "{\"top-left\":[0,0],\"side\": 1}"
(to-json (circle/make [3 4] 1)) ;; => "{\"center\":[3,4],\"radius\": 1}"
```

この実装では、マルチメソッドを使用してVisitorパターンを実現しています。`to-json`マルチメソッドは、異なる形状タイプに対して異なる実装を提供するVisitorです。

各形状（円、四角形）は、自身の構造を変更せずに、Visitorによって新しい操作（JSON変換）を受け入れることができます。新しい形状タイプを追加する場合は、その形状に対する`to-json`メソッドを実装するだけで、既存のコードを変更せずに拡張できます。

また、新しい操作（例えばXML変換）を追加したい場合は、新しいマルチメソッド（例えば`to-xml`）を定義し、各形状タイプに対する実装を提供するだけで、既存の形状クラスを変更せずに拡張できます。

#### クラス図

以下は、Visitorパターンの実装を表すクラス図です：

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

interface "ShapeVisitor" as visitor {
  +to-json(shape)
}

class "JSONShapeVisitor" as jsonVisitor {
  +to-json(circle)
  +to-json(square)
}

shape <|.. circle
shape <|.. square
visitor <|.. jsonVisitor
visitor --> shape : visits
jsonVisitor --> circle : visits
jsonVisitor --> square : visits

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

note right of visitor
  ShapeVisitorはマルチメソッドで
  定義されたインターフェースで、
  to-jsonメソッドを提供します。
end note

note right of jsonVisitor
  JSONShapeVisitorはto-jsonメソッドの
  具体的な実装を提供し、
  各形状タイプに対して異なる
  JSON変換処理を行います。
end note
@enduml
```

#### シーケンス図

以下は、Visitorパターンの実行フローを表すシーケンス図です：

```plantuml
@startuml
actor Client
participant "JSONShapeVisitor\n(to-json)" as visitor
participant "Circle" as circle
participant "Square" as square

Client -> circle : make([3, 4], 1)
activate circle
circle --> Client : circle
deactivate circle

Client -> square : make([0, 0], 1)
activate square
square --> Client : square
deactivate square

Client -> visitor : to-json(circle)
activate visitor
visitor -> circle : get center and radius
activate circle
circle --> visitor : [3, 4], 1
deactivate circle
visitor --> Client : "{\"center\":[3,4],\"radius\": 1}"
deactivate visitor

Client -> visitor : to-json(square)
activate visitor
visitor -> square : get top-left and side
activate square
square --> visitor : [0, 0], 1
deactivate square
visitor --> Client : "{\"top-left\":[0,0],\"side\": 1}"
deactivate visitor

note right
  Clientは各形状オブジェクトを作成し、
  Visitorを使用して形状をJSON形式に
  変換します。Visitorは各形状タイプに
  応じた処理を行います。
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
