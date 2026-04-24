------------------------------------------------------------
-- SEZIONE 1 — VISUALIZZAZIONE DATI DI BASE
------------------------------------------------------------

-- Emittenti
SELECT * FROM emittente ORDER BY idemittente;

-- Titoli
SELECT * FROM titolo ORDER BY idtitolo;

-- Clienti
SELECT * FROM cliente ORDER BY idcliente;

-- Pratiche
SELECT * FROM pratica ORDER BY idpratica;

-- Pagamenti
SELECT * FROM pagamento ORDER BY idpagamento;

-- Sottoscrizioni
SELECT * FROM sottoscrizione ORDER BY idsottoscrizione;



------------------------------------------------------------
-- SEZIONE 2 — JOIN PRINCIPALI
------------------------------------------------------------

-- Titoli con emittente
SELECT 
    t.idtitolo,
    t.nometitolo,
    t.valorenominale,
    t.valoremercato,
    e.nomeemittente AS emittente
FROM titolo t
JOIN emittente e ON t.idemittente = e.idemittente
ORDER BY t.idtitolo;

-- Pratiche con dati cliente
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
    c.nome,
    c.cognome
FROM pratica p
JOIN cliente c ON p.idcliente = c.idcliente
ORDER BY p.idpratica;

-- Pagamenti con dati pratica e cliente
SELECT
    pg.idpagamento,
    pg.idpratica,
    pg.numerorata,
    pg.datascadenza,
    pg.importorata,
    pg.importopagato,
    pg.statopagamento,
    c.nome AS nome_cliente,
    c.cognome AS cognome_cliente
FROM pagamento pg
JOIN pratica p ON pg.idpratica = p.idpratica
JOIN cliente c ON p.idcliente = c.idcliente
ORDER BY pg.idpagamento;

-- Sottoscrizioni con cliente e titolo
SELECT
    s.idsottoscrizione,
    c.nome AS nome_cliente,
    c.cognome AS cognome_cliente,
    t.nometitolo,
    s.quantita,
    s.prezzounitario,
    s.totaleoperazione,
    s.datasottoscrizione
FROM sottoscrizione s
JOIN cliente c ON s.idcliente = c.idcliente
JOIN titolo t ON s.idtitolo = t.idtitolo
ORDER BY s.idsottoscrizione;



------------------------------------------------------------
-- SEZIONE 3 — RIEPILOGHI E REPORT
------------------------------------------------------------

-- Totale pratiche per cliente
SELECT 
    c.idcliente,
    c.nome,
    c.cognome,
    COUNT(p.idpratica) AS numero_pratiche,
    SUM(p.importoerogato) AS totale_erogato
FROM cliente c
LEFT JOIN pratica p ON c.idcliente = p.idcliente
GROUP BY c.idcliente
ORDER BY totale_erogato DESC;

-- Totale pagamenti per pratica
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

-- Totale investito per cliente
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
-- SEZIONE 4 — ANALISI E CONTROLLO COERENZA
------------------------------------------------------------

-- Pratiche con TAN > TAEG (anomalia)
SELECT *
FROM pratica
WHERE tan > taeg;

-- Pagamenti con importo pagato maggiore dell’importo rata
SELECT *
FROM pagamento
WHERE importopagato > importorata;

-- Sottoscrizioni con totaleoperazione incoerente
SELECT *
FROM sottoscrizione
WHERE totaleoperazione <> quantita * prezzounitario;

-- Rate non pagate
SELECT *
FROM pagamento
WHERE importopagato < importorata
ORDER BY datascadenza;