# SQL Analytics -- Logistica e Controle de Frota

Analise exploratoria de dados de logistica e frota de veiculos especiais usando SQL avancado e Python.

## O que este projeto demonstra

- **SQL avancado**: CTEs, Window Functions, Subqueries, CASE WHEN
- **Analise exploratoria**: Pandas, estatisticas descritivas
- **Visualizacao**: Matplotlib, Seaborn
- **Modelagem dimensional**: Star Schema (fatos + dimensoes)

## Estrutura

```
sql-analytics-logistica/
├── data/
│   └── sample_frota.csv
├── sql/
│   ├── 01_schema.sql
│   ├── 02_kpis_entrega.sql
│   └── 03_window_functions.sql
├── requirements.txt
└── README.md
```

## Como executar

```bash
git clone https://github.com/TiagoMFernandes/sql-analytics-logistica
cd sql-analytics-logistica
pip install -r requirements.txt
```

## Analises incluidas

1. **Distribuicao de entregas** por contrato, tipo e periodo
2. **Analise de SLA**: cumprimento por prioridade e responsavel
3. **Window Functions**: RANK, LAG, NTILE, Moving Average
4. **Modelagem dimensional**: Star Schema com fatos e dimensoes