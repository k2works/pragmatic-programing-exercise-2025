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

### ユースケース２：レンタル料金を計算する

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

## コアモデル
```plantuml
@startuml

Movie "1"<-u- Rental
Rental "*"<-l- "1"Customer
Movie "*"-r->"1"Price
Price <|-d- ChildrenPrice
Price <|-d- RegularPrice
Price <|-d- NewReleasePrice
DefaultPrice <|-u- RegularPrice
DefaultPrice <|-u- ChildrenPrice

class Movie {
- title
charge(days_rented)
frequent_renter_points(days_rented)
}

class Rental {
- days_rented
charge(days_rented)
frequent_renter_points(days_rented)
}

class Customer {
- name
statement()
html_statement()
total_charge()
total_frequent_renter_points()
}

interface Price<<protocol>> {
charge(days_rented)
}

class NewReleasePrice {
charge(days_rented)
frequent_renter_points(days_rented)
}

class RegularPrice {
charge(days_rented)
}

class ChildrenPrice {
charge(days_rented)
}

class DefaultPrice<<module>> {
frequent_renter_points(days_rented)
}


@enduml
```

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

## ライセンス

このプロジェクトは教育目的のみです。
