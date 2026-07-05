-- Window Functions Avancadas: Rankings e Analise Temporal

-- 1. Ranking de responsavel por taxa SLA (RANK + DENSE_RANK)
SELECT r.responsavel,
    COUNT(*) AS total,
    ROUND(SUM(f.dentro_sla)*100.0/COUNT(*), 1) AS taxa_sla_pct,
    RANK()       OVER (ORDER BY SUM(f.dentro_sla)*1.0/COUNT(*) DESC) AS rank_sla,
    DENSE_RANK() OVER (ORDER BY AVG(f.dias_realizados) ASC)           AS rank_velocidade
FROM fato_entregas f
JOIN dim_responsavel r ON f.id_responsavel = r.id_responsavel
GROUP BY r.responsavel;

-- 2. Evolucao mensal com acumulado e variacao LAG
WITH mensal AS (
    SELECT strftime("%Y", data_entrega) AS ano,
           strftime("%m", data_entrega) AS mes,
           COUNT(*) AS entregas
    FROM fato_entregas
    GROUP BY ano, mes
)
SELECT ano, mes, entregas,
    SUM(entregas) OVER (PARTITION BY ano ORDER BY mes ROWS UNBOUNDED PRECEDING) AS acumulado_ano,
    LAG(entregas)  OVER (ORDER BY ano, mes) AS mes_anterior,
    entregas - LAG(entregas) OVER (ORDER BY ano, mes) AS variacao_mom
FROM mensal ORDER BY ano, mes;

-- 3. Percentis de desvio por contrato (NTILE)
SELECT c.contrato, f.id_entrega,
    f.dias_realizados - f.prazo_dias AS desvio,
    NTILE(4) OVER (PARTITION BY c.contrato ORDER BY (f.dias_realizados - f.prazo_dias)) AS quartil
FROM fato_entregas f
JOIN dim_contrato c ON f.id_contrato = c.id_contrato;

-- 4. Moving Average de 3 meses
WITH mensal AS (
    SELECT strftime("%Y-%m", data_entrega) AS periodo,
           ROUND(AVG(dias_realizados), 1) AS prazo_medio
    FROM fato_entregas GROUP BY periodo
)
SELECT periodo, prazo_medio,
    ROUND(AVG(prazo_medio) OVER (
        ORDER BY periodo ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 1) AS media_movel_3m
FROM mensal ORDER BY periodo;