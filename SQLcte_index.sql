WITH Russian_Medals AS (
  SELECT
    Year, COUNT(*) AS Medals
  FROM Summer_Medals
  WHERE
    Country = 'RUS'
    AND Medal = 'Gold'
    AND Year >= 1980
  GROUP BY Year)
  --3 year moving average
SELECT
  Year, Medals,
  AVG(Medals) OVER
    (ORDER BY Year ASC
     ROWS BETWEEN
     2 PRECEDING AND CURRENT ROW) AS Medals_MA
FROM Russian_Medals
ORDER BY Year ASC;



WITH countries_cte AS -- CTE
(
    SELECT olympic_cc
      , country
      , temp_06
      , precip_06
    FROM climate
    WHERE region = 'Africa'
)

SELECT DISTINCT cte.country
  , cte.temp_06
  , cte.precip_06
FROM athletes_wint AS wint
INNER JOIN countries_cte AS cte
  ON wint.country_code = cte.olympic_cc
ORDER BY temp_06;




CREATE INDEX defining_parameter_index ON daily_aqi (defining_parameter); 

EXPLAIN
SELECT category
  , COUNT(*) as record_cnt
  , SUM(no_sites) as aqi_monitoring_site_cnt
FROM daily_aqi
WHERE defining_parameter = 'SO2'
AND category <> 'Good'
AND state_code = 15 -- Hawaii
GROUP BY  category;