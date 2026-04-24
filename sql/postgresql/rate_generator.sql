------------------------------------------------------------
-- RATE GENERATOR — VERSIONE DEFINITIVA
-- Autore: Saverio Zitoli (FinancialDB)
------------------------------------------------------------

-- Funzione che genera automaticamente le rate di una pratica
-- Parametri:
--   p_idpratica      ? ID della pratica
--   p_importo        ? Importo totale erogato
--   p_numerorate     ? Numero di rate
--   p_datainizio     ? Data della prima scadenza
------------------------------------------------------------

CREATE OR REPLACE FUNCTION genera_rate(
    p_idpratica INT,
    p_importo NUMERIC,
    p_numerorate INT,
    p_datainizio DATE
)
RETURNS VOID AS $$
DECLARE
    v_importorata NUMERIC;
    v_data DATE;
    i INT;
BEGIN
    -- Calcolo importo rata
    v_importorata := ROUND(p_importo / p_numerorate, 2);

    -- Data iniziale
    v_data := p_datainizio;

    -- Ciclo di generazione rate
    FOR i IN 1..p_numerorate LOOP
        INSERT INTO pagamento (
            idpratica,
            numerorata,
            datascadenza,
            importorata,
            importopagato,
            statopagamento
        )
        VALUES (
            p_idpratica,
            i,
            v_data,
            v_importorata,
            0,
            'In attesa'
        );

        -- Incremento di un mese
        v_data := v_data + INTERVAL '1 month';
    END LOOP;
END;
$$ LANGUAGE plpgsql;