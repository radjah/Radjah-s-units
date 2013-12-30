
-- Table: measure
CREATE TABLE measure ( 
    id     INTEGER  PRIMARY KEY AUTOINCREMENT,
    start  DATETIME NOT NULL,
    stop   DATETIME,
    [DESC] CHAR     NOT NULL,
    mtime  REAL 
);


-- Table: weight
CREATE TABLE weight ( 
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    time    REAL    NOT NULL,
    brutto  FLOAT   NOT NULL,
    netto   FLOAT   NOT NULL,
    tara    FLOAT   NOT NULL,
    meas_id INTEGER NOT NULL 
);


-- Index: idx_measure
CREATE INDEX idx_measure ON measure ( 
    start ASC 
);


-- Index: meas_id
CREATE INDEX meas_id ON weight ( 
    id   ASC,
    time ASC 
);

