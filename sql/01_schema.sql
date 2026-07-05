-- Modelagem Dimensional: Star Schema
-- Contexto: Controle de entregas de veiculos especiais

CREATE TABLE IF NOT EXISTS dim_contrato (
    id_contrato   INTEGER PRIMARY KEY AUTOINCREMENT,
    contrato      TEXT UNIQUE NOT NULL,
    orgao         TEXT,
    uf            TEXT DEFAULT "SP",
    valor_total   REAL
);

CREATE TABLE IF NOT EXISTS dim_veiculo (
    id_veiculo        INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo_veiculo      TEXT UNIQUE NOT NULL,
    categoria         TEXT,
    prazo_padrao_dias INTEGER
);

CREATE TABLE IF NOT EXISTS dim_responsavel (
    id_responsavel INTEGER PRIMARY KEY AUTOINCREMENT,
    responsavel    TEXT UNIQUE NOT NULL,
    cargo          TEXT
);

CREATE TABLE IF NOT EXISTS fato_entregas (
    id_entrega       INTEGER PRIMARY KEY,
    id_contrato      INTEGER REFERENCES dim_contrato(id_contrato),
    id_veiculo       INTEGER REFERENCES dim_veiculo(id_veiculo),
    id_responsavel   INTEGER REFERENCES dim_responsavel(id_responsavel),
    data_pedido      DATE,
    data_entrega     DATE,
    prazo_dias       INTEGER,
    dias_realizados  INTEGER,
    dentro_sla       INTEGER,
    status           TEXT,
    prioridade       TEXT
);

CREATE INDEX IF NOT EXISTS idx_fato_contrato    ON fato_entregas(id_contrato);
CREATE INDEX IF NOT EXISTS idx_fato_responsavel ON fato_entregas(id_responsavel);