------------------------------------------------------------
-- FINANCIALDB - RESET COMPLETO
-- Autore: Saverio Zitoli
-- Versione: 1.0
-- Descrizione:
-- Esegue uninstall + install in un solo passaggio
------------------------------------------------------------

-- 1) RIMOZIONE COMPLETA DI TABELLE, VISTE E DIPENDENZE
\i 'C:/Users/User/Desktop/FinancialDB-Template/uninstall.sql'

-- 2) INSTALLAZIONE COMPLETA DI TABELLE, FUNZIONI, VISTE E DATI
\i 'C:/Users/User/Desktop/FinancialDB-Template/install.sql'

------------------------------------------------------------
-- RESET COMPLETATO
------------------------------------------------------------