------------------------------------------------------------
-- VIEW FINANZIARIE — VERSIONE DEFINITIVA
-- Autore: Saverio Zitoli (FinancialDB)
------------------------------------------------------------


------------------------------------------------------------
-- 1) VIEW: esposizione_clienti
------------------------------------------------------------
CREATE OR REPLACE VIEW esposizione_clienti AS
SELECT
    c.idcliente,
    c.nome,
    c.cognome,
    COUNT(p.idpratica) AS numero_pratiche,
    SUM(p.importoerogato) AS totale_erogato
FROM cliente c
LEFT JOIN pratica p ON c.idcliente = p.idcliente
GROUP BY c.idcliente;


------------------------------------------------------------
-- 2) VIEW: investimenti_clienti
------------------------------------------------------------
CREATE OR REPLACE VIEW investimenti_clienti AS
SELECT
    c.idcliente,
    c.nome,
    c.cognome,
    SUM(s.totaleoperazione) AS totale_investito
FROM cliente c
LEFT JOIN sottoscrizione s ON c.idcliente = s.idcliente
GROUP BY c.idcliente;


------------------------------------------------------------
-- 3) VIEW: pratiche_dettaglio
------------------------------------------------------------
CREATE OR REPLACE VIEW pratiche_dettaglio AS
SELECT
    p.idpratica,
    p.datapratica,
    p.importorichiesto,
    p.importoerogato,
    p.numerorate,
    p.cadenzarate,
    p.tan,
    p.taeg,
    p.statopratica,
    c.nome AS nome_cliente,
    c.cognome AS cognome_cliente
FROM pratica p
JOIN cliente c ON p.idcliente = c.idcliente;


------------------------------------------------------------
-- 4) VIEW: pagamenti_pratica
------------------------------------------------------------
CREATE OR REPLACE VIEW pagamenti_pratica AS
SELECT
    p.idpratica,
    COUNT(pg.idpagamento) AS numero_rate,
    SUM(pg.importorata) AS totale_rate,
    SUM(pg.importopagato) AS totale_pagato,
    SUM(pg.importorata) - SUM(pg.importopagato) AS residuo
FROM pratica p
LEFT JOIN pagamento pg ON p.idpratica = pg.idpratica
GROUP BY p.idpratica;


------------------------------------------------------------
-- 5) VIEW: portafoglio_titoli
------------------------------------------------------------
CREATE OR REPLACE VIEW portafoglio_titoli AS
SELECT
    c.nome,
    c.cognome,
    t.nometitolo,
    s.quantita,
    s.prezzounitario,
    s.totaleoperazione,
    s.datasottoscrizione
FROM sottoscrizione s
JOIN cliente c ON s.idcliente = c.idcliente
JOIN titolo t ON s.idtitolo = t.idtitolo;


------------------------------------------------------------
-- 6) VIEW: rischio_clienti
------------------------------------------------------------
CREATE OR REPLACE VIEW rischio_clienti AS
SELECT
    c.idcliente,
    c.nome,
    c.cognome,
    SUM(p.importoerogato) AS esposizione
FROM cliente c
JOIN pratica p ON c.idcliente = p.idcliente
GROUP BY c.idcliente
HAVING SUM(p.importoerogato) > 5000;


------------------------------------------------------------
-- 7) VIEW: anomalie_finanziarie
------------------------------------------------------------
CREATE OR REPLACE VIEW anomalie_finanziarie AS
(
    SELECT
        'TAN > TAEG' AS tipo_anomalia,
        idpratica AS riferimento,
        NULL AS riferimento_secondario
    FROM pratica
    WHERE tan > taeg

    UNION ALL

    SELECT
        'Pagamento > Rata',
        idpagamento,
        idpratica
    FROM pagamento
    WHERE importopagato > importorata

    UNION ALL

    SELECT
        'Totale != Quantità * Prezzo',
        idsottoscrizione,
        idcliente
    FROM sottoscrizione
    WHERE totaleoperazione <> quantita * prezzounitario
);