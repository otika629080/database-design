2.17 行データの入力（INSERT）
表に行データを入力するには、INSERT 文を使用します。
INSERT 文の構文は以下の通りです。
INSERT INTO 表 名(列 名 [ ,…])
VALUES (値 [ ,...])
値に文字列データを指定する場合には、’（シングルクォート）で括る必要があります。
ossdb =# INSERT INTO prod(prod_id ,prod_name ,price) VALUES (4,' バ ナ ナ ' ,30);
INSERT 0 1
ossdb =# SELECT * FROM prod;
prod_id | prod_name | price
---------+-----------+-------
1 | み か ん | 50
2 | り ん ご | 70
3 | メ ロ ン | 100
4 | バ ナ ナ | 30
(4 行)
2.18 データの更新（UPDATE）
行データを更新するには、UPDATE 文を使用します。
UPDATE 文の構文は以下の通りです。
UPDATE 表 名
SET 列 名 = 値
WHERE 条 件 式
以下の例では、prod 表の prod_id 列の値が 4 の行データの price 列の値を 40 に更新しています。