# レンタルビデオシステム

レンタルビデオシステムの最小限のClojure実装です。

## 基本仕様
+ ビデオレンタルの料金を計算して計算書を印刷するプログラム
+ システムにはどの映画を何日間借りるかが入力される。
+ 貸出の日数によって料金が計算され、映画の分類が判定される。
+ 映画の分類は３つある。一般向け、子供向け、新作。
+ レンタルポイントも印刷される。新作かどうかによってポイント計算の仕方が異なる。

## ユースケース
```plantuml
@startuml
left to right direction
skinparam packageStyle rectangle
actor customer
rectangle VedioRental {
  customer -- (レンタルする)
              (レンタル料金を計算する)
              (計算書を印刷する)
}
@enduml
```

### ユースケース１：レンタルする
```plantuml
@startuml
actor Customer
participant "RentalSystem" as system
participant "Customer" as customer
participant "Movie" as movie
participant "Rental" as rental
participant "RentalOrder" as order

Customer -> system: レンタル要求
activate system

system -> Customer: 顧客情報を要求
Customer -> system: 顧客情報を提供
system -> customer: make-customer(name)
activate customer

system -> Customer: レンタルする映画と日数を要求
Customer -> system: 映画タイトルと日数を提供
system -> movie: make-movie(title, type)
activate movie

system -> rental: make-rental(movie, days)
activate rental

system -> order: make-rental-order(customer, rentals)
activate order

system -> Customer: レンタル完了通知
deactivate order
deactivate rental
deactivate movie
deactivate customer
deactivate system

@enduml
```

### ユースケース２：レンタル料金を計算する
```plantuml
@startuml
actor Customer
participant "RentalSystem" as system
participant "StatementPolicy" as policy
participant "RentalOrder" as order
participant "Rental" as rental
participant "Movie" as movie

Customer -> system: 料金計算要求
activate system

system -> policy: make-statement-data(order)
activate policy

policy -> order: get customer and rentals
activate order
order --> policy: customer, rentals
deactivate order

policy -> policy: total-amount(rentals)
activate policy
  policy -> rental: determine-amount(rental)
  activate rental
    rental -> movie: get movie type
    activate movie
    movie --> rental: movie type
    deactivate movie
    rental --> policy: amount
  deactivate rental
policy --> policy: total amount
deactivate policy

policy -> policy: total-points(rentals)
activate policy
  policy -> rental: determine-points(rental)
  activate rental
    rental -> movie: get movie type
    activate movie
    movie --> rental: movie type
    deactivate movie
    rental --> policy: points
  deactivate rental
policy --> policy: total points
deactivate policy

policy --> system: statement data
deactivate policy

system -> Customer: 料金計算結果
deactivate system

@enduml
```

### ユースケース３：計算書を印刷する
```plantuml
@startuml
actor Customer

Customer -> a_customer: statement
    activate a_customer
      a_customer -> a_customer: total charge
      activate a_customer
        a_customer -> a_rental:*[for all rentals] charge
        activate a_rental
           a_rental -> a_movie: charge(days_rented)
           activate a_movie
             a_movie -> a_price: charge(days_rented)
           deactivate a_movie
        deactivate a_rental
      deactivate a_customer
      a_customer -> a_customer: total_frequent_renter_points
      activate a_customer
        a_customer -> a_rental:*[for all rentals] frequent_renter_points
        activate a_rental
           a_rental -> a_movie: frequent_renter_points(days_rented)
           activate a_movie
             a_movie -> a_price: frequent_renter_points(days_rented)
           deactivate a_movie
        deactivate a_rental
      deactivate a_customer
    deactivate a_customer

@enduml

```

## ドメインモデル
```plantuml
@startuml

Customer "1" <-- "*" RentalOrder : contains
RentalOrder "1" *-- "*" Rental : contains
Rental "*" --> "1" Movie : references
Movie --> MovieType : has type

StatementPolicy <|-- DefaultPolicy
StatementPolicy <|-- BuyTwoGetOneFreePolicy

StatementFormatter <|-- TextFormatter
StatementFormatter <|-- HTMLFormatter

RentalOrder ..> StatementPolicy : uses
RentalOrder ..> StatementFormatter : uses

enum MovieType {
  REGULAR
  CHILDRENS
  NEW_RELEASE
}

class Customer {
  - name: String
}

class RentalOrder {
  - customer: Customer
  - rentals: List<Rental>
}

class Rental {
  - movie: Movie
  - days: Integer
}

class Movie {
  - title: String
  - type: MovieType
}

interface StatementPolicy {
  + determineAmount(rental): Double
  + determinePoints(rental): Integer
  + totalAmount(rentals): Double
  + totalPoints(rentals): Integer
  + makeStatementData(order): StatementData
}

class DefaultPolicy {
  + determineAmount(rental): Double
  + determinePoints(rental): Integer
  + totalAmount(rentals): Double
  + totalPoints(rentals): Integer
}

class BuyTwoGetOneFreePolicy {
  + totalAmount(rentals): Double
}

interface StatementFormatter {
  + formatRentalStatement(statementData): String
}

class TextFormatter {
  + formatRentalStatement(statementData): String
}

class HTMLFormatter {
  + formatRentalStatement(statementData): String
}

class StatementData {
  - customerName: String
  - movies: List<MovieData>
  - owed: Double
  - points: Integer
}

class MovieData {
  - title: String
  - price: Double
}

StatementPolicy ..> StatementData : creates
StatementData *-- "*" MovieData : contains

@enduml
```

## プロジェクト構造

```
rentalVideo/
├── deps.edn        # プロジェクト依存関係
├── src/            # ソースコード
│   └── video_store/
│       ├── buy_two_get_one_free_policy.clj  # 2つ買うと1つ無料のポリシー
│       ├── constructors.clj                 # コンストラクタ関数
│       ├── html_statement_formatter.clj     # HTML形式のフォーマッタ
│       ├── normal_statement_policy.clj      # 通常の料金ポリシー
│       ├── order_processing.clj             # 注文処理
│       ├── statement_formatter.clj          # 明細フォーマッタインターフェース
│       ├── statement_policy.clj             # 明細ポリシーインターフェース
│       └── text_statement_formatter.clj     # テキスト形式のフォーマッタ
└── spec/           # テスト
    └── video_store/
        ├── integration_specs.clj            # 統合テスト (speclj)
        ├── integration_test.clj             # 統合テスト (clojure.test)
        ├── statement_formatter_spec.clj     # フォーマッタテスト (speclj)
        ├── statement_formatter_test.clj     # フォーマッタテスト (clojure.test)
        ├── statement_policy_spec.clj        # ポリシーテスト (speclj)
        └── statement_policy_test.clj        # ポリシーテスト (clojure.test)
```

## 使用方法

### プロジェクトの実行

プロジェクトを実行するには、Clojure CLIを使用できます：

```bash
# REPLを起動
clj -M

# REPL内で
(require 'video_store.constructors)
(require 'video_store.statement_policy)
(require 'video_store.text_statement_formatter)
```

### テストの実行

```bash
clj -M:spec
```

## ライセンス

このプロジェクトは教育目的のみです。
