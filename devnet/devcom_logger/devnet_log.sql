
-- Table: weight
CREATE TABLE weight ( 
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    time    REAL    NOT NULL,
    brutto  FLOAT   NOT NULL,
    netto   FLOAT   NOT NULL,
    tara    FLOAT   NOT NULL,
    meas_id INTEGER NOT NULL 
);


-- Table: measure
CREATE TABLE measure ( 
    id        INTEGER  PRIMARY KEY AUTOINCREMENT,
    start     DATETIME NOT NULL,
    startmsec INTEGER  NOT NULL
                       DEFAULT ( 0 ),
    stop      DATETIME,
    stopmsec  INTEGER  DEFAULT ( 0 ),
    [DESC]    CHAR     NOT NULL,
    mtime     REAL 
);


-- Index: meas_id
CREATE INDEX meas_id ON weight ( 
    id   ASC,
    time ASC 
);


-- Index: idx_measure
CREATE INDEX idx_measure ON measure ( 
    start ASC 
);

