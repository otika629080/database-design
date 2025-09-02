# この章で学ぶこと
主キーの選択がパフォーマンスに与える影響

AUTO INCREMENT, UUID, ULIDの特徴と使い分け

ページ分割のメカニズムとパフォーマンス影響

順次生のあるIDとランダムIDの違い

実際のユースケースに応じたID選定方法

| 種類 | データ型 | メリット | デメリット |
| --- | --- | --- | --- |
| AUTO INCREMENT | INT | 高速 | DB上での生成が必要 |
| UUID(v4) | VARCHAR(36) or BINARY(16) | アプリケーション上で生成可能 | AUTO INCREMENTよりは遅い |
| ULID | VARCHAR(36) or BINARY(16) | アプリケーション上で生成可能, UUIDより高速 | AUTO INCREMENTよりは遅い |

## AUTO INCREMENT
```sql
CREATE TABLE 会員 (
    会員ID INT AUTO_INCREMENT PRIMARY KEY,
    氏名 VARCHAR(100) NOT NULL,
)
```
```kotlin
val memberId = memberRepository.insert({ name: 'XXX', ... })
memberCardRepository.insert({ memberId: memberID, ... })
```
- INT型は48byteなのでデータサイズが小さい
- インデックスの各ページにより多くのレコードが入るため読み書きが速い
- アプリケーション上での扱いにくさがネック
- 連番をIDに使いたくないという要件があるケース

## UUID
```sql
CREATE TABLE 会員(
    会員ID VARCHAR(36) PRIMARY KEY,
    氏名 VARCHAR(100) NOT NULL,
)
```
```kotlin
val memberId = UUID.generate()
memberRepository.insert({memberId: memberId, name: 'XXX', ...})
memberCardRepository.insert({memberId: memberId, ...})
```
- アプリケーション上でのユニークなIDを容易に生成できる
- データサイズが大きいので単純に遅い
- 連番ではないのでページの再構築が発生しやすく遅くなりやすい

## ULID
```sql
CREATE TABLE 会員(
    会員ID VARCHAR(26) PRIMARY KEY,
    氏名 VARCHAR(100) NOT NULL,
)
```
```kotlin
val memberId = ULID.generate()
memberRepository.insert({memberId: memberId, name: 'XXX', ...})
memberCardRepository.insert({memberId: memberId, ...})
```
- アプリケーション上でのユニークなIDを容易に生成できる
- データサイズが大きいので単純に遅い
- 連番なのでページの再構築が発生しにくくUUIDより速い

## INT, UUID, ULIDの性能比較(INSERT)
| レコード数 | INT(AUTO_INCREMENT) | ULID | UUID |
| --- | --- | --- | --- |
| 100万件 | 8.223秒 | 11.178秒 | 14.250秒 |
| 500万件 | 42.160秒 | 60.2秒 | 90.3秒 |
| 2000万件 | 194.9秒(3m15s) | 273.1秒(4m33s) | 1759.7秒(29m20s) |

- UUIDはランダム書き込みなのでレコードが増えるほどBufferPoolに乗らずディスクIOが増える
- INT, UUIDは末尾書き込みのみなのでレコードが増えても性能劣化は起きにくい
- 単純にデータサイズが小さいほどページあたりのレコード数も増えるのでディスクIOが減って速い

## Btreeインデックスの再構築1
1. リーフページが増えると枝ページも修正

## Btreeインデックスの再構築2
- 枝ページがいっぱいになると枝ページも新規ページを生成
- ルートページも修正

## Btreeインデックスの再構築3
ルートページもいっぱいになると上位ページを生成

### どのIDを使えばいいのか
- 数百万レコードのテーブルであればどのIDを選んでも性能差は感じない
- 連番にしたいか、ランダムにしたいか、擬似的な連番にしたいか要件次第
- 数千万レコード~規模になると何がボトルネックかに応じて選定が変わる