------------------------------------------------------------
-- FINANCIALDB - INSTALLAZIONE COMPLETA
-- Autore: Saverio Zitoli
-- Versione: 1.0
------------------------------------------------------------

------------------------------------------------------------
-- 1) CREAZIONE TABELLE
------------------------------------------------------------
\i 'C:/Users/User/Desktop/FinancialDB-Template/sql/postgresql/create_tables.sql'

------------------------------------------------------------
-- 2) FUNZIONI
------------------------------------------------------------
\i 'C:/Users/User/Desktop/FinancialDB-Template/sql/postgresql/rate_generator.sql'
\i 'C:/Users/User/Desktop/FinancialDB-Template/sql/postgresql/calcola_ammortamento_francese.sql'

------------------------------------------------------------
-- 3) VISTE
------------------------------------------------------------
\i 'C:/Users/User/Desktop/FinancialDB-Template/sql/postgresql/dashboard_finanziaria.sql'
\i 'C:/Users/User/Desktop/FinancialDB-Template/sql/postgresql/dashboard_cliente.sql'
\i 'C:/Users/User/Desktop/FinancialDB-Template/sql/postgresql/view_finanziaries.sql'
\i 'C:/Users/User/Desktop/FinancialDB-Template/sql/postgresql/report_finanziari.sql'

------------------------------------------------------------
-- 4) DATI DI ESEMPIO (OPZIONALE)
------------------------------------------------------------
\i 'C:/Users/User/Desktop/FinancialDB-Template/sql/postgresql/insert_examples.sql'

------------------------------------------------------------
-- INSTALLAZIONE COMPLETATA
------------------------------------------------------------