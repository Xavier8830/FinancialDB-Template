CREATE OR REPLACE VIEW dashboard_cliente AS
SELECT
    c.idcliente,
    c.nome || ' ' || c.cognome AS cliente,
    COUNT(DISTINCT p.idpratica) AS numero_pratiche,
    COALESCE(SUM(p.importoerogato), 0) AS totale_erogato,
    COALESCE(SUM(pg.importopagato), 0) AS totale_pagato,
    COALESCE(SUM(p.importoerogato), 0) - COALESCE(SUM(pg.importopagato), 0) AS residuo_totale,
    MIN(CASE WHEN pg.statopagamento = 'In attesa' THEN pg.datascadenza END) AS prossima_scadenza,
    CASE 
        WHEN MIN(CASE WHEN pg.statopagamento = 'In attesa' THEN pg.datascadenza END) < CURRENT_DATE
        THEN CURRENT_DATE - MIN(CASE WHEN pg.statopagamento = 'In attesa' THEN pg.datascadenza END)
        ELSE 0
    END AS giorni_ritardo,
    COALESCE(SUM(p.numerorate), 0) AS rate_totali,
    COUNT(CASE WHEN pg.statopagamento = 'Pagato' THEN 1 END) AS rate_pagate,
    COUNT(CASE WHEN pg.statopagamento = 'In attesa' THEN 1 END) AS rate_mancanti,
    ROUND(
        (COUNT(CASE WHEN pg.statopagamento = 'Pagato' THEN 1 END)::numeric 
        / NULLIF(COUNT(pg.idpagamento), 0)) * 100,
        2
    ) AS avanzamento_percentuale
FROM cliente c
LEFT JOIN pratica p ON p.idcliente = c.idcliente
LEFT JOIN pagamento pg ON pg.idpratica = p.idpratica
GROUP BY
    c.idcliente,
    c.nome,
    c.cognome;