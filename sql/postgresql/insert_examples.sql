------------------------------------------------------------
-- TABELLA: emittente
------------------------------------------------------------
INSERT INTO emittente (nomeemittente, tipoemittente, paese, settore) VALUES
('Banca Alfa', 'Banca', 'Italia', 'Finanza'),
('FinCorp International', 'Società di Investimento', 'Lussemburgo', 'Investimenti'),
('Credito Sud', 'Banca', 'Italia', 'Credito');


------------------------------------------------------------
-- TABELLA: titolo
------------------------------------------------------------
INSERT INTO titolo (tipotitolo, nometitolo, valorenominale, valoremercato, idemittente) VALUES
('Obbligazione', 'Obbligazione Alfa 2026', 1000.00, 1025.50, 1),
('Fondo', 'FinCorp Growth', 500.00, 520.00, 2),
('Obbligazione', 'Credito Sud 2030', 1000.00, 980.00, 3);


------------------------------------------------------------
-- TABELLA: cliente
------------------------------------------------------------
INSERT INTO cliente (nome, cognome, codicefiscale, partitaiva, datanascita, indirizzo, telefono, email, tipocliente) VALUES
('Mario', 'Rossi', 'RSSMRA80A01H501Z', '12345678901', '1980-01-01', 'Via Garibaldi 12', '3201112233', 'mario.rossi@email.it', 'PF'),
('Luca', 'Bianchi', 'BNCLCU75B15F205X', '98765432109', '1975-02-15', 'Via Dante 8', '3409988776', 'luca.bianchi@email.it', 'PF'),
('Giulia', 'Verdi', 'VRDGLI90C41H501W', '55566677788', '1990-03-10', 'Via Roma 20', '3805566778', 'giulia.verdi@email.it', 'PG');


------------------------------------------------------------
-- TABELLA: pratica
------------------------------------------------------------
INSERT INTO pratica (datapratica, importorichiesto, importoerogato, numerorate, cadenzarate, tan, taeg, statopratica, idcliente) VALUES
('2026-03-01', 5000.00, 4800.00, 24, 'Mensile', 4.50, 5.10, 'Aperta', 1),
('2026-03-01', 7500.00, 7200.00, 36, 'Mensile', 4.20, 4.90, 'Aperta', 2),
('2026-04-01', 3000.00, 3000.00, 12, 'Mensile', 3.80, 4.20, 'Chiusa', 3);


------------------------------------------------------------
-- TABELLA: pagamento
-- Struttura reale:
-- idpagamento | idpratica | numerorata | datascadenza | importorata | importopagato | statopagamento
------------------------------------------------------------
INSERT INTO pagamento (idpratica, numerorata, datascadenza, importorata, importopagato, statopagamento) VALUES
(1, 1, '2026-03-10', 200.00, 200.00, 'Pagato'),
(2, 1, '2026-03-25', 250.00, 250.00, 'Pagato'),
(3, 1, '2026-04-15', 300.00, 0.00, 'In attesa');


------------------------------------------------------------
-- TABELLA: sottoscrizione
-- Struttura reale:
-- idsottoscrizione | idcliente | idtitolo | datasottoscrizione | prezzounitario | quantita | totaleoperazione
------------------------------------------------------------
INSERT INTO sottoscrizione (idcliente, idtitolo, datasottoscrizione, prezzounitario, quantita, totaleoperazione) VALUES
(1, 1, '2026-03-05', 100.00, 10, 1000.00),
(2, 2, '2026-03-18', 500.00, 5, 2500.00),
(3, 3, '2026-04-02', 140.00, 7, 980.00);