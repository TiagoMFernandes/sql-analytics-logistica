-- KPIs de Entrega e Aderencia ao SLA

-- 1. Taxa de SLA por contrato
SELECT
    c.contrato,
    COUNT(*) AS total_entregas,
    SUM(f.dentro_sla) AS dentro_sla,
    ROUND(SUM(f.dentro_sla) * 100.0 / COUNT(*), 1) AS taxa_sla_pct,
    ROUND(AVG(f.dias_realizados), 1) AS prazo_medio_dias
FROM fato_entregas f
JOIN dim_contrato c ON f.id_contrato = c.id_contrato
GROUP BY c.contrato ORDER BY taxa_sla_pct DESC;

-- 2. Desempenho por responsavel
WITH stats AS (
    SELECT r.responsavel,
        COUNT(*) AS total,
        SUM(f.dentro_sla) AS sla_ok,
        ROUND(AVG(f.dias_realizados), 1) AS media_dias
    FROM fato_entregas f
    JOIN dim_responsavel r ON f.id_responsavel = r.id_responsavel
    GROUP BY r.responsavel
)
SELECT *, ROUND(sla_ok * 100.0 / total, 1) AS taxa_sla_pct
FROM stats ORDER BY taxa_sla_pct DESC;

-- 3. Analise de prazo por tipo de veiculo
SELECT v.tipo_veiculo, COUNT(*) AS total,
    ROUND(AVG(f.dias_realizados), 1) AS prazo_realizado,
    ROUND(AVG(f.dias_realizados - f.prazo_dias), 1) AS desvio_medio
FROM fato_entregas f
JOIN dim_veiculo v ON f.id_veiculo = v.id_veiculo
GROUP BY v.tipo_veiculo ORDER BY desvio_medio DESC;