## 專案目的
 - 學習 PostgresQL, 建立製造品質分析練習專案
 - 練習多表JOIN、聚合函式、CTE、窗函數（Window Function）、VIEW
 - 生成一組半導體製程資料，用來分析良率、缺陷率、班別表現

## 使用工具
- PostgresQL
- SQL
- psql

## 資料表
|欄位                |大小|
|-------------------|----|
|machines（設備    ）|   6|
|lots（批次）        | 100|
|measurements（量測）| 400|
|defects（缺陷數）   | 80 |

# 練習
- select, where, order by
- join
- group by
- aggregate function
- cte
- window functions
- view
- explain

# 情境
- 查詢不同機台的 yield 表現
- 比較不同班別的平均良率
- 統計缺陷類型的總數
- 建立 lot 品質 summary

## 分析問題
1. 哪些機台有較低的平均良率?
2. 哪個班別的良率變異最大?
3. 哪些批次的良率低且缺陷數高?

## 結果
1.
=== Machine Yield Ranking ===
|machine_name | avg_yield | yield_rank|
|-------------|-----------|-----------|
|CMP_01       |     96.60 |          1|
|ETCH_01      |     96.57 |          2|
|CVD_01       |     96.56 |          3|
|IMPLANT_01   |     96.49 |          4|
|ETCH_02      |     95.27 |          5|
|PHOTO_01     |     94.57 |          6|
2.
=== Shift Performance ===
|shift  |avg_yield  |yield_std|
|-------|-----------|---------|
|Night  |  96.53    |     1.47|
|Day    |  95.74    |     2.41|
3.
=== Low Yield Lots ===
|lot_no |machine_name |shift|avg_yield|  total_defects|
|-------|-------------|-----|---------|---------------|
|LOT016 |PHOTO_01     |Day  |    91.57|             72|
|LOT046 |PHOTO_01     |Day  |    91.71|             84|
|LOT062 |ETCH_02      |Day  |    92.37|             72|
|LOT088 |PHOTO_01     |Day  |    92.38|             76|

# psql 指令
- & "C:\Program Files\PostgreSQL\18\bin\psql.exe" -h localhost -p <post> -U <user> -d <database>
- \i '直接路徑'