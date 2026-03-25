from db import run_query
import matplotlib.pyplot as plt

sql_machine_yield = """
SELECT
    m.machine_name,
    ROUND(AVG(me.yield_rate), 2) AS avg_yield,
    RANK() OVER (ORDER BY AVG(me.yield_rate) DESC) AS yield_rank
FROM machines m
JOIN lots l ON m.machine_id = l.machine_id
JOIN measurements me ON l.lot_id = me.lot_id
GROUP BY m.machine_name
ORDER BY avg_yield DESC;
"""

sql_shift_performance = """
SELECT
    l.shift,
    ROUND(AVG(me.yield_rate), 2) AS avg_yield,
    ROUND(STDDEV(me.yield_rate), 2) AS yield_std
FROM lots l
JOIN measurements me ON l.lot_id = me.lot_id
GROUP BY l.shift;
"""

sql_low_yield_lots = """
WITH lot_summary AS (
    SELECT
        l.lot_no,
        m.machine_name,
        l.shift,
        ROUND(AVG(me.yield_rate), 2) AS avg_yield,
        COALESCE(SUM(d.defect_count), 0) AS total_defects
    FROM lots l
    JOIN machines m ON l.machine_id = m.machine_id
    JOIN measurements me ON l.lot_id = me.lot_id
    LEFT JOIN defects d ON l.lot_id = d.lot_id
    GROUP BY l.lot_no, m.machine_name, l.shift
)
SELECT *
FROM lot_summary
WHERE avg_yield < 93
ORDER BY avg_yield ASC, total_defects DESC;
"""

def main():
    df_machine = run_query(sql_machine_yield)
    df_shift = run_query(sql_shift_performance)
    df_low_yield = run_query(sql_low_yield_lots)

    print("=== Machine Yield Ranking ===")
    print(df_machine)

    print("\n=== Shift Performance ===")
    print(df_shift)

    print("\n=== Low Yield Lots ===")
    print(df_low_yield.head(10))

    plt.figure(figsize=(8, 5))
    plt.bar(df_machine["machine_name"], df_machine["avg_yield"])
    plt.title("Average Yield by Machine")
    plt.xlabel("Machine")
    plt.ylabel("Average Yield")
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.savefig("machine_yield_ranking.png")
    plt.close()

    plt.figure(figsize=(6, 4))
    plt.bar(df_shift["shift"], df_shift["yield_std"])
    plt.title("Yield Std by Shift")
    plt.xlabel("Shift")
    plt.ylabel("Yield Std")
    plt.tight_layout()
    plt.savefig("shift_yield_std.png")
    plt.close()

    df_plot = df_low_yield.sort_values("avg_yield", ascending=True).copy()
    plt.figure(figsize=(8, 4))
    plt.barh(df_plot["lot_no"], df_plot["avg_yield"])
    plt.xlabel("Average Yield")
    plt.ylabel("Lot No")
    plt.title("Low-Yield Lots and Associated Defects")
    for i, (_, row) in enumerate(df_plot.iterrows()):
        plt.text(row["avg_yield"] + 0.03, i, f"defects={row['total_defects']}", va="center")
    plt.tight_layout()
    plt.savefig("lots_yield_relation.png")
    plt.close()

if __name__ == '__main__':
    main()