------------------------------------------------------------
-- UPDATE 1 — Aggiornare i dati di un cliente
------------------------------------------------------------
UPDATE cliente
SET telefono = '3209998877',
    email = 'mario.rossi.new@email.it'
WHERE idcliente = 1;



------------------------------------------------------------
-- UPDATE 2 — Modificare lo stato di una pratica
------------------------------------------------------------
UPDATE pratica
SET statopratica = 'Chiusa'
WHERE idpratica = 1;



------------------------------------------------------------
-- UPDATE 3 — Registrare un pagamento effettuato
------------------------------------------------------------
UPDATE pagamento
SET importopagato = importorata,
    statopagamento = 'Pagato'
WHERE idpagamento = 3;



------------------------------------------------------------
-- UPDATE 4 — Aggiornare il TAN e TAEG di una pratica
------------------------------------------------------------
UPDATE pratica
SET tan = 4.10,
    taeg = 4.80
WHERE idpratica = 2;



------------------------------------------------------------
-- UPDATE 5 — Correggere una sottoscrizione
------------------------------------------------------------
UPDATE sottoscrizione
SET quantita = 12,
    totaleoperazione = 12 * prezzounitario
WHERE idsottoscrizione = 1;



------------------------------------------------------------
-- UPDATE 6 — Aggiornare la data di scadenza di una rata
------------------------------------------------------------
UPDATE pagamento
SET datascadenza = '2026-03-20'
WHERE idpagamento = 1;



------------------------------------------------------------
-- UPDATE 7 — Cambiare emittente di un titolo
------------------------------------------------------------
UPDATE titolo
SET idemittente = 3
WHERE idtitolo = 2;