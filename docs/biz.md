# 業務分析

## ビジネスモデル

```mermaid
mindmap
  root((ビジネスモデル))
    外部環境
      競争
      政治・社会・技術
      マクロ経済
      市場
    内部環境
      顧客
        顧客セグメント
        顧客関係
      価値
        価値提案
        チャネル
      インフラ
        主要活動
        主要パートナー
      資金
        収益源
          売上
        コスト構造
          変動費
          固定費
```

## インパクトマップ

```mermaid
mindmap
  root((Goals))
    Actors
      Impacts
        Deliverables
        Deliverables
      Impacts
        Deliverables
      Impacts
        Deliverables
        Deliverables
    Actors
      Impacts
        Deliverables
      Impacts
        Deliverables
    Actors
      Impacts
        Deliverables
      Impacts
        Deliverables
```

## ドメイン

```mermaid
mindmap
  root((ドメイン))
    組織
      ドメイン
        企業ドメイン
          理念
          ビジョン
          ミッション
        事業ドメイン
          誰に
          何を
          どのように
        サブドメイン
          コアサブドメイン
          汎用サブドメイン
          サポートサブドメイン
    事業
      部門
      部門
      部門
```

```mermaid
quadrantChart
    title サブドメインマッピング
    x-axis "特異性 低" --> "特異性 高"
    y-axis "複雑性 低" --> "複雑性 高"
    quadrant-1 "コアサブドメイン"
    quadrant-2 "汎用サブドメイン"
    quadrant-3 "汎用 or サポートサブドメイン"
    quadrant-4 "サポートサブドメイン"
    "境界付けられたコンテキスト A": [0.3, 0.6]
    "境界付けられたコンテキスト B": [0.45, 0.23]
    "境界付けられたコンテキスト C": [0.80, 0.80]
    "境界付けられたコンテキスト D": [0.78, 0.34]
    "境界付けられたコンテキスト E": [0.40, 0.34]
    "境界付けられたコンテキスト F": [0.35, 0.78]
```

### 組織構造

### 企業ドメイン

### 事業ドメイン

### サブドメイン

#### コアサブドメイン

#### 汎用サブドメイン

#### サポートサブドメイン

## ビジネスコンテキスト

### サブドメイン

```mermaid
flowchart LR
  subgraph 事業
    subgraph 自社
      subgraph 部門
        ユーザー管理
      end
      管理者 --> ユーザー管理
      ユーザー --> ユーザー管理
    end
  end
```

## ビジネスユースケース

### ユーザー管理

#### ユースケース図

```mermaid
graph TB
    subgraph "ユーザー管理"
        管理者((管理者))
        subgraph "ユーザー操作"
            ユーザー一覧を取得する[ユーザー一覧を取得する]
            ユーザーを新規登録する[ユーザーを新規登録する]
            ユーザーを取得する[ユーザーを取得する]
            登録済みユーザーを更新登録する[登録済みユーザーを更新登録する]
            登録済みユーザーを削除する[登録済みユーザーを削除する]
        end
    end
    管理者 --> ユーザー一覧を取得する
    管理者 --> ユーザーを新規登録する
    管理者 --> ユーザーを取得する
    管理者 --> 登録済みユーザーを更新登録する
    管理者 --> 登録済みユーザーを削除する
```

#### シーケンス図

```mermaid
sequenceDiagram
  participant 管理者
  participant システム
  管理者 ->> システム: ユーザー一覧を取得する
  管理者 ->> システム: ユーザーを新規登録する
  システム ->> 管理者: ユーザーを登録する
  管理者 ->> システム: ユーザーを取得する
  管理者 ->> システム: 登録済みユーザーを更新登録する
  システム ->> 管理者: ユーザーを更新登録する
  管理者 ->> システム: 登録済みユーザーを削除する
```

#### 業務フロー図

##### ユーザー一覧取得

```mermaid
flowchart TD
  A[スタート] -->|ユーザー一覧を取得する| B[ストップ]
```

##### ユーザー新規登録

```mermaid
flowchart TD
  A[スタート] -->|ユーザーを新規登録する| B[ストップ]
```

##### ユーザー取得

```mermaid
flowchart TD
  A[スタート] -->|ユーザーを取得する| B[ストップ]
```

##### ユーザー更新登録

```mermaid
flowchart TD
  A[スタート] -->|登録済みユーザーを更新登録する| B[ストップ]
```

##### ユーザー削除

```mermaid
flowchart TD
  A[スタート] -->|登録済みユーザーを削除する| B[ストップ]
```
