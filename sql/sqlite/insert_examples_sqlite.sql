-- ============================
-- CLIENTI
-- ============================
INSERT INTO Cliente (cliente_id, nome, cognome, codice_fiscale, data_nascita, telefono, email)
VALUES
(1, 'Marco', 'Rossi', 'RSSMRC80A01H501U', '1980-01-01', '3331112222', 'marco.rossi@example.com'),
(2, 'Laura', 'Bianchi', 'BNCLRA85C41F205Z', '1985-03-01', '3332223333', 'laura.bianchi@example.com');

-- ============================
-- PRATICHE
-- ============================
INSERT INTO Pratica (pratica_id, cliente_id, data_apertura, stato, note)
VALUES
(1, 1, '2024-01-10', 'Aperta', 'Pratica iniziale'),
(2, 2, '2024-02-15', 'Aperta', 'Richiesta documentazione');

-- ============================
-- PAGAMENTI
-- ============================
INSERT INTO Pagamento (pagamento_id, pratica_id, data_pagamento, importo, metodo)
VALUES
(1, 1, '2024-01-15', 150.00, 'Bonifico'),
(2, 2, '2024-02-20', 200.00, 'Carta');

-- ============================
-- EMITTENTI
-- ============================
INSERT INTO Emittente (emittente_id, nome, paese)
VALUES
(1, 'Banca Alfa', 'Italia'),
(2, 'FinCorp International', 'Lussemburgo');

-- ============================
-- TITOLI
-- ============================
INSERT INTO Titolo (titolo_id, emittente_id, nome, categoria, rischio)
VALUES
(1, 1, 'Obbligazione Alfa 2028', 'Obbligazione', 'Basso'),
(2, 2, 'Fondo FinCorp Global', 'Fondo', 'Medio');

-- ============================
-- SOTTOSCRIZIONI
-- ============================
INSERT INTO Sottoscrizione (sottoscrizione_id, cliente_id, titolo_id, data_sottoscrizione, importo)
VALUES
(1, 1, 1, '2024-03-01', 5000.00),
(2, 2, 2, '2024-03-05', 10000.00);
