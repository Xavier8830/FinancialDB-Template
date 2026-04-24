------------------------------------------------------------
-- DASHBOARD FINANZIARIA — VERSIONE PROFESSIONALE
-- Autore: Saverio Zitoli (FinancialDB)
------------------------------------------------------------

CREATE OR REPLACE VIEW dashboard_finanziaria AS
SELECT
    c.idcliente,
    c.nome || ' ' || c.cognome AS cliente,
    p.idpratica,
    p.importoerogato,
    p.numerorate,
    
    -- Rate pagate
    COUNT(CASE WHEN pg.statopagamento = 'Pagato' THEN 1 END) AS rate_pagate,
    
    -- Rate mancanti
    COUNT(CASE WHEN pg.statopagamento = 'In attesa' THEN 1 END) AS rate_mancanti,
    
    -- Importo pagato
    COALESCE(SUM(pg.importopagato), 0) AS importo_pagato,
    
    -- Importo residuo
    p.importoerogato - COALESCE(SUM(pg.importopagato), 0) AS importo_residuo,
    
    -- Prossima rata
    MIN(CASE WHEN pg.statopagamento = 'In attesa' THEN pg.datascadenza END) AS prossima_scadenza,
    
    -- Ritardo (giorni)
    CASE 
        WHEN MIN(CASE WHEN pg.statopagamento = 'In attesa' THEN pg.datascadenza END) < CURRENT_DATE
        THEN CURRENT_DATE - MIN(CASE WHEN pg.statopagamento = 'In attesa' THEN pg.datascadenza END)
        ELSE 0
    END AS giorni_ritardo,
    
    -- Avanzamento %
    ROUND(
        (COUNT(CASE WHEN pg.statopagamento = 'Pagato' THEN 1 END)::numeric 
        / p.numerorate) * 100, 2
    ) AS avanzamento_percentuale

FROM cliente c
JOIN pratica p ON p.idcliente = c.idcliente
LEFT JOIN pagamento pg ON pg.idpratica = p.idpratica

GROUP BY
    c.idcliente,
    c.nome,
    c.cognome,
    p.idpratica,
    p.importoerogato,
    p.numerorate;