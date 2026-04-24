------------------------------------------------------------
-- REPORT FINANZIARI — VERSIONE DEFINITIVA
-- Autore: Saverio Zitoli (FinancialDB)
------------------------------------------------------------


------------------------------------------------------------
-- 1) REPORT CLIENTI
------------------------------------------------------------

-- 1.1 — Esposizione totale per cliente
SELECT
    c.idcliente,
    c.nome,
    c.cognome,
    SUM(p.importoerogato) AS totale_erogato,
    COUNT(p.idpratica) AS numero_pratiche
FROM cliente c
LEFT JOIN pratica p ON c.idcliente = p.idcliente
GROUP BY c.idcliente
ORDER BY totale_erogato DESC;


-- 1.2 — Totale investito per cliente
SELECT
    c.idcliente,
    c.nome,
    c.cognome,
    SUM(s.totaleoperazione) AS totale_investito
FROM cliente c
LEFT JOIN sottoscrizione s ON c.idcliente = s.idcliente
GROUP BY c.idcliente
ORDER BY totale_investito DESC;


------------------------------------------------------------
-- 2) REPORT PRATICHE
------------------------------------------------------------

-- 2.1 — Stato delle pratiche
SELECT
    statopratica,
    COUNT(*) AS numero_pratiche,
    SUM(importoerogato) AS totale_erogato
FROM pratica
GROUP BY statopratica
ORDER BY numero_pratiche DESC;


-- 2.2 — Pratiche con tassi (TAN/TAEG)
SELECT
    idpratica,
    datapratica,
    importoerogato,
    tan,
    taeg,
    CASE 
        WHEN taeg > tan THEN 'OK'
        ELSE 'ANOMALIA'
    END AS controllo_tassi
FROM pratica
ORDER BY idpratica;


------------------------------------------------------------
-- 3) REPORT PAGAMENTI
------------------------------------------------------------

-- 3.1 — Situazione rate per pratica
SELECT
    p.idpratica,
    COUNT(pg.idpagamento) AS numero_rate,
    SUM(pg.importorata) AS totale_rate,
    SUM(pg.importopagato) AS totale_pagato,
    SUM(pg.importorata) - SUM(pg.importopagato) AS residuo
FROM pratica p
LEFT JOIN pagamento pg ON p.idpratica = pg.idpratica
GROUP BY p.idpratica
ORDER BY p.idpratica;


-- 3.2 — Rate scadute e non pagate
SELECT
    pg.idpagamento,
    pg.idpratica,
    pg.datascadenza,
    pg.importorata,
    pg.importopagato,
    pg.statopagamento
FROM pagamento pg
WHERE pg.importopagato < pg.importorata
ORDER BY pg.datascadenza;


------------------------------------------------------------
-- 4) REPORT INVESTIMENTI
------------------------------------------------------------

-- 4.1 — Totale investito per titolo
SELECT
    t.idtitolo,
    t.nometitolo,
    SUM(s.quantita) AS totale_quote,
    SUM(s.totaleoperazione) AS totale_raccolto
FROM titolo t
LEFT JOIN sottoscrizione s ON t.idtitolo = s.idtitolo
GROUP BY t.idtitolo
ORDER BY totale_raccolto DESC;


-- 4.2 — Portafoglio clienti (dettaglio)
SELECT
    c.nome,
    c.cognome,
    t.nometitolo,
    s.quantita,
    s.prezzounitario,
    s.totaleoperazione
FROM sottoscrizione s
JOIN cliente c ON s.idcliente = c.idcliente
JOIN titolo t ON s.idtitolo = t.idtitolo
ORDER BY c.idcliente, t.idtitolo;


------------------------------------------------------------
-- 5) ANALISI DI RISCHIO
------------------------------------------------------------

-- 5.1 — Clienti con esposizione > 5000€
SELECT
    c.nome,
    c.cognome,
    SUM(p.importoerogato) AS esposizione
FROM cliente c
JOIN pratica p ON c.idcliente = p.idcliente
GROUP BY c.idcliente
HAVING SUM(p.importoerogato) > 5000
ORDER BY esposizione DESC;


-- 5.2 — Pratiche con residuo > 0
SELECT
    p.idpratica,
    SUM(pg.importorata) - SUM(pg.importopagato) AS residuo
FROM pratica p
JOIN pagamento pg ON p.idpratica = pg.idpratica
GROUP BY p.idpratica
HAVING SUM(pg.importorata) > SUM(pg.importopagato)
ORDER BY residuo DESC;


------------------------------------------------------------
-- 6) CONTROLLI DI COERENZA
------------------------------------------------------------

-- 6.1 — Sottoscrizioni incoerenti
SELECT *
FROM sottoscrizione
WHERE totaleoperazione <> quantita * prezzounitario;


-- 6.2 — Pagamenti incoerenti
SELECT *
FROM pagamento
WHERE importopagato > importorata;


-- 6.3 — Pratiche con TAN > TAEG
SELECT *
FROM pratica
WHERE tan > taeg;