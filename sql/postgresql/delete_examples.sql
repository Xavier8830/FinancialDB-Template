------------------------------------------------------------
-- DELETE EXAMPLES — VERSIONE DEFINITIVA
-- Autore: Saverio Zitoli (FinancialDB)
------------------------------------------------------------

------------------------------------------------------------
-- 1) Cancellazione di una rata specifica
------------------------------------------------------------
-- Esempio: elimina la rata numero 1 della pratica 1
DELETE FROM pagamento
WHERE idpratica = 1 AND numerorata = 1;


------------------------------------------------------------
-- 2) Cancellazione di tutte le rate di una pratica
------------------------------------------------------------
-- Esempio: elimina tutte le rate della pratica 2
DELETE FROM pagamento
WHERE idpratica = 2;


------------------------------------------------------------
-- 3) Cancellazione di una sottoscrizione specifica
------------------------------------------------------------
-- Esempio: elimina la sottoscrizione con ID 1
DELETE FROM sottoscrizione
WHERE idsottoscrizione = 1;


------------------------------------------------------------
-- 4) Cancellazione di tutte le sottoscrizioni di un cliente
------------------------------------------------------------
-- Esempio: elimina tutte le sottoscrizioni del cliente 3
DELETE FROM sottoscrizione
WHERE idcliente = 3;


------------------------------------------------------------
-- 5) Cancellazione di una pratica (con relative rate)
------------------------------------------------------------
-- IMPORTANTE: prima si cancellano le rate, poi la pratica
-- Esempio: elimina la pratica 1
DELETE FROM pagamento WHERE idpratica = 1;
DELETE FROM pratica WHERE idpratica = 1;


------------------------------------------------------------
-- 6) Cancellazione di un cliente (con pratiche e sottoscrizioni)
------------------------------------------------------------
-- IMPORTANTE: ordine corretto per evitare errori FK
-- Esempio: elimina il cliente 2

-- 6.1 — elimina le rate delle pratiche del cliente
DELETE FROM pagamento
WHERE idpratica IN (SELECT idpratica FROM pratica WHERE idcliente = 2);

-- 6.2 — elimina le pratiche del cliente
DELETE FROM pratica
WHERE idcliente = 2;

-- 6.3 — elimina le sottoscrizioni del cliente
DELETE FROM sottoscrizione
WHERE idcliente = 2;

-- 6.4 — elimina il cliente
DELETE FROM cliente
WHERE idcliente = 2;


------------------------------------------------------------
-- 7) Cancellazione totale (RESET COMPLETO DEL DATABASE)
------------------------------------------------------------
-- ATTENZIONE: elimina tutti i dati da tutte le tabelle
-- Usare solo per test o ripristino

DELETE FROM pagamento;
DELETE FROM pratica;
DELETE FROM sottoscrizione;
DELETE FROM titolo;
DELETE FROM cliente;