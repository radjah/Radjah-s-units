
-- Table: weight
CREATE TABLE weight ( 
    id      INTEGER  PRIMARY KEY AUTOINCREMENT,
    date    DATETIME NOT NULL,
    brutto  FLOAT    NOT NULL,
    netto   FLOAT    NOT NULL,
    tara    FLOAT    NOT NULL,
    meas_id INTEGER  NOT NULL 
);


-- Table: measure
CREATE TABLE measure ( 
    id     INTEGER  PRIMARY KEY AUTOINCREMENT,
    start  DATETIME NOT NULL,
    stop   DATETIME,
    [DESC] CHAR     NOT NULL,
    mtime  REAL 
);

