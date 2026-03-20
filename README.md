## 專案目的
學習 PostgresQL, 建立製造品質分析練習專案
練習多表JOIN、聚合函式、CTE、窗函數（Window Function）、VIEW

## 使用工具
- PostgresQL
- SQL
- psql

## 資料表
- machines：設備資料
- lots：批次資料
- measurements：量測資料
- defects：缺陷資料

# 練習
- select, where, order by
- join
- group by, function
- cte
- window functions
- view

# 情境
- 查詢不同機台的 yield 表現
- 比較不同班別的平均良率
- 統計缺陷類型的總數
- 建立 lot 品質 summary

# psql 指令
- & "C:\Program Files\PostgreSQL\18\bin\psql.exe" -h localhost -p <password> -U <user> -d <database>
- \i '直接路徑'