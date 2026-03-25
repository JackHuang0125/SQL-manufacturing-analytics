import streamlit as st
from db import run_query
import matplotlib.pyplot as plt

st.set_page_config(page_title='Manufacturing SQL Analytics Dashboard', layout="wide")

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

st.title('Manufacturing SQL Analytics Dashboard')

df_machine = run_query(sql_machine_yield)
df_shift = run_query(sql_shift_performance)
df_low_yield = run_query(sql_low_yield_lots)


st.subheader("Machine Yield Ranking")
st.dataframe(df_machine, use_container_width=True)

fig1, ax1 = plt.subplots(figsize=(8, 4))
ax1.bar(df_machine["machine_name"], df_machine["avg_yield"])
ax1.set_title("Average Yield by Machine")
ax1.set_xlabel("Machine")
ax1.set_ylabel("Average Yield")
plt.xticks(rotation=45)
st.pyplot(fig1)

st.subheader("Shift Performance")
st.dataframe(df_shift, use_container_width=True)

fig2, ax2 = plt.subplots(figsize=(6, 4))
ax2.bar(df_shift["shift"], df_shift["yield_std"])
ax2.set_title("Yield Std by Shift")
ax2.set_xlabel("Shift")
ax2.set_ylabel("Yield Std")
st.pyplot(fig2)

st.subheader("Low Yield Lots")
st.dataframe(df_low_yield, use_container_width=True)