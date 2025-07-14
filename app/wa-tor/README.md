# Wa-Torシミュレーション

## 概要

Wa-Torは、Alexander K. Dewdneyによって考案され、1984年12月のScientific American誌の「Computer Recreations」コラムで発表された個体群動態シミュレーションです。

このシミュレーションは、魚とサメの2種類の生物が生息するトーラス状（ドーナツ型）の世界「Wa-Tor」をモデル化しています。シミュレーションは、単純な生態系における捕食者-被食者の動態を示しています。

## シミュレーションのルール

1. 世界は2Dグリッドであり、各セルは空、魚、またはサメのいずれかを含むことができます。
2. 魚とサメは以下の単純なルールに従って移動します：
   - 魚は隣接する空のセルにランダムに移動します。
   - サメは隣接する魚を含むセルに、または魚が利用できない場合は空のセルにランダムに移動します。
   - サメが魚を食べると、エネルギーを獲得します。
   - サメは時間の経過とともにエネルギーを失い、エネルギーがゼロになると死にます。
3. 魚とサメの両方が一定の時間ステップ後に繁殖します。

## 設計

```plantuml
class World
abstract class Cell {
+ Tick
}
class Water
abstract class Animal {
+ Move
+ Reproduce
}
class Shark {
+ Eat
}
class Fish

World -> "*" Cell
Cell <|-- Water
Cell <|-- Animal
Animal <|-- Shark
Animal <|-- Fish


```

## 実装

このプロジェクトはClojureでWatorシミュレーションを実装しています。主要なコンポーネントは以下の通りです：

- `wator.core`：世界のグリッドを作成および操作するためのコア機能
- 特定のシミュレーションコンポーネント（魚、サメなど）のための追加の名前空間

## 使用方法

シミュレーションを実行するには：

```bash
clj -M -m wator.core
```

## テスト

specljを使用してテストを実行するには：

```bash
clj -M:spec
```

clojure.testを使用してテストを実行するには：

```bash
clj -M:test
```

## 参考文献

- [WikipediaのWator](https://en.wikipedia.org/wiki/Wa-Tor)
