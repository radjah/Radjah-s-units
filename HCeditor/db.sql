CREATE TABLE cstruct (
  id      integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
  cid     integer NOT NULL,
  corder  integer NOT NULL,
  sid     integer NOT NULL
);

CREATE INDEX sindex
  ON cstruct
  (sid, corder);

CREATE TABLE cycle (
  cid    integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
  cname  varchar(128) NOT NULL
);

CREATE INDEX cname_idx
  ON cycle
  (cname);

CREATE TABLE sqlite_stat1 (
  tbl   ,
  idx   ,
  stat  
);

CREATE TABLE sstruct (
  pid     integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
  sid     integer NOT NULL,
  clevel  integer NOT NULL,
  ptime   integer NOT NULL
);

CREATE INDEX cindex
  ON sstruct
  (sid, clevel);

CREATE TABLE stages (
  sid    integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
  sname  varchar(128) NOT NULL
);

CREATE INDEX sname_idx
  ON stages
  (sname);

