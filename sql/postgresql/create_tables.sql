-- FinancialDB Template - PostgreSQL
-- Creazione delle tabelle principali

CREATE TABLE Cliente (
    IDCliente SERIAL PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    CodiceFiscale VARCHAR(16),
    PartitaIVA VARCHAR(11),
    DataNascita DATE,
    Indirizzo VARCHAR(100),
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    TipoCliente VARCHAR(2)
);

CREATE TABLE Pratica (
    IDPratica SERIAL PRIMARY KEY,
    DataPratica DATE,
    ImportoRichiesto NUMERIC(12,2),
    ImportoErogato NUMERIC(12,2),
    NumeroRate INT,
    CadenzaRate VARCHAR(20),
    TAN NUMERIC(5,2),
    TAEG NUMERIC(5,2),
    StatoPratica VARCHAR(30),
    IDCliente INT REFERENCES Cliente(IDCliente)
);

CREATE TABLE Pagamento (
    IDPagamento SERIAL PRIMARY KEY,
    IDPratica INT REFERENCES Pratica(IDPratica),
    NumeroRata INT,
    DataScadenza DATE,
    ImportoRata NUMERIC(12,2),
    ImportoPagato NUMERIC(12,2),
    StatoPagamento VARCHAR(30)
);

CREATE TABLE Emittente (
    IDEmittente SERIAL PRIMARY KEY,
    NomeEmittente VARCHAR(100),
    TipoEmittente VARCHAR(50),
    Paese VARCHAR(50),
    Settore VARCHAR(50)
);

CREATE TABLE Titolo (
    IDTitolo SERIAL PRIMARY KEY,
    TipoTitolo VARCHAR(50),
    NomeTitolo VARCHAR(100),
    ValoreNominale NUMERIC(12,2),
    ValoreMercato NUMERIC(12,2),
    IDEmittente INT REFERENCES Emittente(IDEmittente)
);

CREATE TABLE Sottoscrizione (
    IDSottoscrizione SERIAL PRIMARY KEY,
    IDCliente INT REFERENCES Cliente(IDCliente),
    IDTitolo INT REFERENCES Titolo(IDTitolo),
    DataSottoscrizione DATE,
    Quantita INT,
    PrezzoUnitario NUMERIC(12,2),
    TotaleOperazione NUMERIC(12,2)
);
