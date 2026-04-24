CREATE OR REPLACE FUNCTION calcola_ammortamento_francese(
    p_capitale NUMERIC,
    p_tasso NUMERIC,
    p_rate INT
)
RETURNS TABLE (
    numerorata INT,
    rata NUMERIC,
    quota_interessi NUMERIC,
    quota_capitale NUMERIC,
    capitale_residuo NUMERIC
) AS $$
DECLARE
    i INT;
    tasso_mensile NUMERIC;
    rata_costante NUMERIC;
    capitale NUMERIC := p_capitale;
BEGIN
    tasso_mensile := p_tasso / 12;

    rata_costante := ROUND(
        p_capitale * (tasso_mensile / (1 - POWER(1 + tasso_mensile, -p_rate))),
        2
    );

    FOR i IN 1..p_rate LOOP
        quota_interessi := ROUND(capitale * tasso_mensile, 2);
        quota_capitale := ROUND(rata_costante - quota_interessi, 2);
        capitale := ROUND(capitale - quota_capitale, 2);

        numerorata := i;
        rata := rata_costante;
        capitale_residuo := capitale;

        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE plpgsql;