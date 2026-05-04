# Changelog
Tutte le modifiche rilevanti a questo progetto verranno documentate in questo file.

Il formato segue lo standard **Keep a Changelog**  
e il versionamento segue **Semantic Versioning (SemVer)**.

---

## [1.0.0] – 2026-05-04
### Added
- Prima release stabile del progetto **FinancialDB-Template**
- Supporto completo per **PostgreSQL**
- Supporto dedicato per **SQLite**
- Script principali:
  - installazione (`install.sql`)
  - reset (`reset.sql`)
  - disinstallazione (`uninstall.sql`)
- Struttura tabelle completa per pratiche, clienti, pagamenti, investimenti
- Dashboard SQL:
  - `dashboard_finanziaria.sql`
  - `dashboard_cliente.sql`
- Viste per analisi e reportistica:
  - `view_finanziaries.sql`
  - `report_finanziari.sql`
- Funzioni avanzate:
  - `rate_generator.sql`
  - `calcola_ammortamento_francese.sql`
- Script di esempio (insert, update, delete, select)
- Diagramma ER (`schema/ER-diagram.png`)
- Dati di esempio per test e sviluppo

---

## [1.1.0] – In sviluppo
### Planned
- Viste avanzate per analisi finanziaria
- Miglioramento delle query aggregate
- Ottimizzazione performance su dataset di grandi dimensioni

---

## [1.2.0] – Pianificata
### Planned
- Reportistica automatizzata (PDF/CSV)
- Generazione report schedulati

---

## [1.3.0] – Pianificata
### Planned
- Dashboard grafica con aggregazioni
- Integrazione con strumenti BI esterni

---

## Formato Versioni
- **MAJOR**: cambiamenti incompatibili con versioni precedenti  
- **MINOR**: nuove funzionalità retro‑compatibili  
- **PATCH**: correzioni retro‑compatibili  
