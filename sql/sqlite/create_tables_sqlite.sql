-- FinancialDB Template - SQLite
PRAGMA foreign_keys = ON;

CREATE TABLE Cliente (
    IDCliente INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome TEXT,
    Cognome TEXT,
    CodiceFiscale TEXT,
    PartitaIVA TEXT,
    DataNascita TEXT,
    Indirizzo TEXT,
    Telefono TEXT,
    Email TEXT,
    TipoCliente TEXT
);

CREATE TABLE Pratica (
    IDPratica INTEGER PRIMARY KEY AUTOINCREMENT,
    DataPratica TEXT,
    ImportoRichiesto REAL,
    ImportoErogato REAL,
    NumeroRate INTEGER,
    CadenzaRate TEXT,
    TAN REAL,
    TAEG REAL,
    StatoPratica TEXT,
    IDCliente INTEGER,
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente)
);

CREATE TABLE Pagamento (
    IDPagamento INTEGER PRIMARY KEY AUTOINCREMENT,
    IDPratica INTEGER,
    NumeroRata INTEGER,
    DataScadenza TEXT,
    ImportoRata REAL,
    ImportoPagato REAL,
    StatoPagamento TEXT,
    FOREIGN KEY (IDPratica) REFERENCES Pratica(IDPratica)
);

CREATE TABLE Emittente (
    IDEmittente INTEGER PRIMARY KEY AUTOINCREMENT,
    NomeEmittente TEXT,
    TipoEmittente TEXT,
    Paese TEXT,
    Settore TEXT
);

CREATE TABLE Titolo (
    IDTitolo INTEGER PRIMARY KEY AUTOINCREMENT,
    TipoTitolo TEXT,
    NomeTitolo TEXT,
    ValoreNominale REAL,
    ValoreMercato REAL,
    IDEmittente INTEGER,
    FOREIGN KEY (IDEmittente) REFERENCES Emittente(IDEmittente)
);

CREATE TABLE Sottoscrizione (
    IDSottoscrizione INTEGER PRIMARY KEY AUTOINCREMENT,
    IDCliente INTEGER,
    IDTitolo INTEGER,
    DataSottoscrizione TEXT,
    Quantita INTEGER,
    PrezzoUnitario REAL,
    TotaleOperazione REAL,
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente),
    FOREIGN KEY (IDTitolo) REFERENCES Titolo(IDTitolo)
);
